# Get the path of the file directory
file_dir = dirname(@__FILE__)

# Get the path of the main directory
main_dir = file_dir #dirname(@__DIR__)
while !endswith(main_dir, "deployment_package")
    global main_dir = dirname(main_dir) 
end

# Load Package manager
using Pkg

# Load packages. If not installed, do: Pkg.add("package_name"), for example: Pkg.add("Graphs"))
using Graphs # To create graphs. The function create_graph() uses it.
using GraphRecipes # To create graph plots. The function plot_graph() uses it.
using Colors # To color graph's edges. The function color_edges() uses it.
using ColorSchemes # To assign colors to vectors with no discrete values. The function plot_graph() uses it.
using Plots # To create plots. The function plot_graph() uses it.
using LinearAlgebra # To use functions such as diagind()
using JLD2 # To use functions such as load_object() of type .jld2
using Optim # To use unconstrained optimization tools. The function get_error_params() uses it.
using Distributions # To generate instances of random variables. The function get_error_params() uses it.
using StatsBase # To use function geomean(). The functions solveLw() and solveab() use it.
using BlackBoxOptim # To use blackbox optimization tools. 
using NLopt # To use non-linear constrained optimization algorithms.
using NLSolversBase # To calculate finite differences using functions OnceDifferentiable() and TwiceDifferentiable.
using DelimitedFiles # To export files in .CSV format.
using GraphPlot
using DataFrames
using GLM # To run linear regressions
using CSV # To read CSV files

# Load auxiliary functions
include(joinpath(file_dir, "set_ini_guess.jl"))
include(joinpath(file_dir, "get_square_graph.jl"))
include(joinpath(file_dir, "get_edges.jl"))
include(joinpath(file_dir, "dist_btw_nodes.jl"))
include(joinpath(file_dir, "shortest_path.jl"))
include(joinpath(file_dir, "shortest_path_on_grid.jl"))
include(joinpath(file_dir, "weight_shortest_path.jl"))
include(joinpath(file_dir, "get_ab_with_error.jl"))
include(joinpath(file_dir, "solveLw.jl"))
include(joinpath(file_dir, "solveLw_whenever.jl"))
include(joinpath(file_dir, "solveLw_in_D.jl"))
include(joinpath(file_dir, "get_ini_ab.jl"))
include(joinpath(file_dir, "f_additive.jl"))
include(joinpath(file_dir, "solveab.jl"))
include(joinpath(file_dir, "solveab_in_D.jl"))
include(joinpath(file_dir, "solveab_whenever.jl"))
include(joinpath(file_dir, "calc_obj_func.jl"))

#=
include(joinpath(file_dir, "f_multiplicative.jl"))
include(joinpath(file_dir, "sequential_quadratic.jl"))
include(joinpath(file_dir, "ip_newton.jl"))
include(joinpath(file_dir, "blackbox.jl"))
include(joinpath(file_dir, "cobyla.jl"))
include(joinpath(file_dir, "lbfgs.jl"))
=#


function run_model(experiment_num)
    
    model         = 1; # Type of model -> 1: constant returns; 2: increasing returns (i.e. with aglomeration forces)
    diff_periods  = true; # Type of diff_periods -> false: same years for L and w; true: different years for L and w.
    wL_periods    = [1991, 2010]; #[1995, 2005]; # [1990, 1995]; # Years of data when L and w are observed the same year.
    w_periods     = [1992, 2011]; # Years of data for w.
    L_periods     = [1991, 2010]; # Years of data for L.
    D_periods     = 2; # Number of years of data.
    error_struct  = 1; # Error structure -> 1: Additive; 2: Multiplicative
    moment_struct = 1; #  Moment structure -> 1: Additive; 2: Multiplicative
    opt_method    = 2 # Optimization algorithm
    transp_param  = true;
    convergence   = false;

    # Parameters of fundamentals (log-normal distribution for productivity and amenities)
    mu_fund    = -2.0; # Location parameter μ
    sigma_fund = 2.4; # Shape parameter σ
    shift_fund = 4.0;

    # Vector of parameters of fundamentals
    fund_params = [mu_fund, sigma_fund, shift_fund];

    # Network parameters
    T_periods             = [1980, 1998, 2005]; # [1995, 2005];# # [1990, 1995]; # Number of Transportation network periods
    N                     = 11; # Number of nodes on one side of a square graph
    nobs                  = 121; # Number of nodes
    network_id            = 2; # Id of network infrastructure and geography pre coded 
    tc_walk               = 1.0; # Baseline transportation cost
    tc_river              = 10000.0; # Trasportation cost of crossing the river (without transportation infrastructure)
    tc_road               = 1.0; # Transportation cost of traveling on roads
    tc_bridge             = 1.0; # Transportation cost of traveling on bridge
    tc_ferry_true_distrib = [[6.0, 10.0, 17.0], [1/4, 1/4, 1/2]]; # [[16.0], [1.0]]; # [[6, 12, 18], [1/4, 1/4, 1/2]]; # [[16.0], [1.0]]# True distribution of transportation cost of traveling on ferry
    tc_ferry              = tc_ferry_true_distrib[1]' * tc_ferry_true_distrib[2]; # Mean transportation cost of traveling on ferry
    
    # Vector of network parameters
    network_params = [nobs, tc_walk, tc_river, tc_road, tc_bridge, tc_ferry];

    # Model parameters
    alpha   = 0.75 # Share of goods in consumption expenditure (1-housing share)
    sigma   = 4.0 # Elasticity of substitution in model with constant returns
    Hsigma  = 5.0 # Elasticity of substitution in model with aglomeration forces
    theta   = 4.0 # Goods Frechet shape parameter. Controls the dispersion in productivity across goods. Elasticity of trade wrt trade costs. 
    epsilon = 3.0 # Worker Frechet shape parameter. Controls the disperson of amenities across workers. Elasticity of population wrt real income.
    phi     = 0.33 # Elasticity of costs wrt to effective distance # Note: The paper says that theta*phi = 1, but theta = 4 (i.e. if theta = 4 and phi*theta = 1, then phi = 0.25)
    H       = 100.0; # Land area
    LL      = 153889.0; # Aggregate labor supply # US civilian labor force 2010 (Statistical Abstract, millions)
    F       = 1.0; # Fixed production cost
    beta    = 0.6667 # Convergence parameter

    # Vector of model parameters
    param = [alpha, theta, epsilon, sigma, Hsigma, phi, H, LL, F, beta];

    # Dimension of parameter vector γ
    gamma_dim = lastindex(tc_ferry_true_distrib[2])

    # Initial guess
    ini_guess, params_to_est = set_ini_guess(convergence, transp_param, gamma_dim)

############## Before this, we load parameters, hopefully in one line #################

############## Here we start we the actual operations of this script ##################

    ###############################
    ### Read in Montecarlo data ###
    ###############################

    data_dir = joinpath(main_dir, "data", "ab_data.jld2")
    mc_data  = load_object(data_dir);

    ###############################
    ### Data Generating Process ###
    ###############################

    ###############
    ### Network ###
    ###############

    # Initialize objects
    graph                = [Graph(N^2) for i in 1:lastindex(T_periods)];
    adj_matrix           = [zeros(Float64, nobs, nobs) for i in 1:lastindex(T_periods)];  # This is a list of matrices, implicitly indexed by the list index of T_periods
    river_edges          = [Vector{Tuple{Int64, Int64}}() for i in 1:lastindex(T_periods)];
    road_edges           = [Vector{Tuple{Int64, Int64}}() for i in 1:lastindex(T_periods)];
    bridge_edges         = [Vector{Tuple{Int64, Int64}}() for i in 1:lastindex(T_periods)];
    ferry_edges          = [Vector{Tuple{Int64, Int64}}() for i in 1:lastindex(T_periods)];
    distmx               = [fill(Inf, N^2, N^2) for i in 1:lastindex(T_periods)]; 
    tc_avg               = [zeros(N^2, N^2) for i in 1:lastindex(T_periods)];
    tc_true_dgp          = [[zeros(Float64, nobs, nobs) for i in 1:lastindex(tc_ferry_true_distrib[1])] for j in 1:lastindex(T_periods)];
    tc_true_dgp_weighted = [zeros(Float64, nobs, nobs) for i in 1:lastindex(T_periods)];
    
    for t in 1:lastindex(T_periods)
        # Vector of graphs for each period
        graph[t] = get_square_graph(N);

        # Vector with adjancency matrix in each period 
        adj_matrix[t] = adjacency_matrix(graph[t])

        # Vector of edges cost in each period
        river_edges[t], road_edges[t], bridge_edges[t], ferry_edges[t] = get_edges(N, adj_matrix[t], t, network_id);

        # Vector with matrix of cost between nodes in each period
        distmx[t] = dist_btw_nodes(N, adj_matrix[t], tc_walk, road_edges[t], tc_road, river_edges[t], tc_river, bridge_edges[t], tc_bridge, ferry_edges[t], tc_ferry);
        
        # Vector with shortest path matrix using the average tc_ferry in each period
        tc_avg[t] = shortest_path(N, graph[t], distmx[t]);

        # Vector with shortest path matrix on the true DGP in each period
        tc_true_dgp[t] = shortest_path_on_grid(N, graph[t], adj_matrix[t], tc_walk, road_edges[t], tc_road, river_edges[t], tc_river, bridge_edges[t], tc_bridge, ferry_edges[t], tc_ferry_true_distrib[1]);

        # Vector with shortest path matrix weighted on the true DGP in each period
        tc_true_dgp_weighted[t] = weight_shortest_path(tc_true_dgp[t], tc_ferry_true_distrib[2]);

    end


    ##############################################
    ### Fundamentals: Productivity and Amenity ###
    ##############################################

    # Create copy of original data in which we apply transformations
    mc_data_mod = copy(mc_data);

    # Productivity: Lognormal(mu_fund, sigma_fund) + shift
    mc_data_mod[:, 2] = exp.(mu_fund .+ sigma_fund*mc_data[:, 2]) .+ shift_fund; # exp.(mc_data[:, 2]);

    # Amenity: Lognormal(mu_fund, sigma_fund) + shift
    mc_data_mod[:, 3] = exp.(mu_fund .+ sigma_fund*mc_data[:, 3]) .+ shift_fund; # exp.(mc_data[:, 3])

    # Choose sample and filter mc_data_mod
    sample            = 1;
    select_rows       = mc_data_mod[:, 1] .== sample;
    data              = mc_data_mod[select_rows, :];

    if moment_struct == 1
        moment_struct_name = "Additive";
    else
        moment_struct_name = "Multiplicative";
    end

    ###########################################
    ### Pre-computed objects for estimation ###
    ###########################################

    # Create grid of possible values for tc_ferry
    tc_ferry_grid = [6.0, 10.0, 17.0];  

    # Initialize object
    tc_on_grid = [[zeros(Float64, nobs, nobs) for i in 1:lastindex(tc_ferry_grid)] for j in 1:lastindex(T_periods)];

    for t in 1:lastindex(T_periods)
        # Vector with shortest path matrix on the estimation grid in each transportation innovation period
        tc_on_grid[t] = shortest_path_on_grid(N, graph[t], adj_matrix[t], tc_walk, road_edges[t], tc_road, river_edges[t], tc_river, bridge_edges[t], tc_bridge, ferry_edges[t], tc_ferry_grid);
    end

    println("Starting estimation of parameters. ", moment_struct_name, " 'moment'.")

    ###############################
    ### Data generating process ###
    ###############################

    # Initialize the vectors where productivity and amenity are stored
    #a          = zeros(Float64, nobs);
    #b          = zeros(Float64, nobs);
    #a_ratio    = 0.0;
    #b_ratio    = 0.0;
    #var_ratio  = 0.0;

    # Initialize the vectors where wages and population are stored for each year of data available.
    w_D        = [zeros(Float64, nobs) for i in 1:lastindex(w_periods)];
    L_D        = [zeros(Float64, nobs) for i in 1:lastindex(L_periods)];
    tradesh    = [zeros(Float64, nobs, nobs) for i in 1:D_periods];
    dtradesh   = [zeros(Float64, nobs) for i in 1:D_periods];
    wconverge  = zeros(lastindex(w_periods));
    Lconverge  = zeros(lastindex(L_periods));
    dimensions = lastindex(ini_guess); #1+lastindex(tc_ferry_grid) # Number of parameters to estimate

    # Initialize the vector where wages and population in steady state are stored for each transportation innovation.
    w_ss       = [zeros(Float64, nobs) for i in 1:lastindex(T_periods)];
    L_ss       = [zeros(Float64, nobs) for i in 1:lastindex(T_periods)];

    # Get the vectors of productivity and amenity
    a, b, a_ratio, b_ratio, var_ratio = get_ab_with_error(data, 1, error_struct, 0.0, 0.0);

    # Given (a, b) we precompute (w_ss, L_ss) for the years in the vector T_periods.
    # L_ss helps us to compute L_D. Given a, b, L_D, and the transportation network, we solve for w_D.
    # Recall, the pair (w_D, L_D) is the pair of wages and population we observe for the years in the vector D_periods (years of data).
    for t in 1:lastindex(T_periods)
        # Given (a, b), solve for the wages and population in each steady state t associated with a transportation innovation.
        w_ss[t], L_ss[t] = solveLw(param, a, b, tc_true_dgp_weighted[t], nobs, model);
    end

    # The DGP yields (w_D, L_D) for the periods in which there are data.
    # We assume that w adjusts quickly, hence, wages are in steady state since the last transportation innovation.
    # We assume that L does not adjust fast. Therefore, population are off steady state.
    # Population L off steady state depends on previous steady states and the convergence parameter β.    
    for d in 1:D_periods
        if diff_periods
            # Given (a, b) we obtain the vectors of wages w and population L for different years given by w_periods and L_periods respectively.
            w_D[d], L_D[d] = solveLw_whenever(param, a, b, L_ss, tc_true_dgp_weighted, w_periods, L_periods, T_periods, d, nobs, model);
        else
            # Given (a, b) we obtain the vectors of wages w and population L for the same years given by wL_periods.
            w_D[d], L_D[d] = solveLw_in_D(param, a, b, L_ss, tc_true_dgp_weighted, wL_periods, T_periods, d, nobs, model);
        end
    end

    ################################################
    ### Evaluate the model with given parameters ###
    ################################################

    # Get initial guess for productivity and amenity vectors
    a_ini, b_ini = get_ini_ab(a, b, w_D[1], L_D[1]);

    # Get the experiment to run
    #experiment_num      = 26;
    experiment_data_dir = joinpath(main_dir, "data", "experiments.txt");
    experiment_data     = readdlm(experiment_data_dir, '\t', Float64, '\n');
    experiment_vec      = vec(experiment_data[experiment_data[:, 1] .== experiment_num, 2:end]);
    
    # GMM evaluation 
    gmm_value, eval_time = f_additive(experiment_vec, params_to_est, param, w_D, L_D, tc_on_grid, wL_periods, w_periods, L_periods, T_periods, D_periods, nobs, model, a_ini, b_ini)

    #####################
    ### Write results ###
    #####################

    # Get the results directory
    results_dir = joinpath(main_dir, "results", "gmm_values.txt");
    new_line = string(experiment_num, ";", experiment_vec, ";", gmm_value, ";", eval_time);

    # Open the file in write mode, overwriting its content
    results_file = open(results_dir, "a");

    # Write the new line to the file
    println(results_file, new_line);

    # Close the file
    close(results_file);

end