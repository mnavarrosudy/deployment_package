function shortest_path_on_grid(N, graph, adj_matrix, tc_walk, road_edges, tc_road, river_edges, tc_river, bridge_edges, tc_bridge, ferry_edges, tc_value)

# Periods
#periods = 2;

#= 
# Network
N = 11;
nobs = 121; # Number of nodes
#network_id = 4; # Id of network infrastructure and geography pre coded 
tc_walk = 7.9; # Baseline transportation cost
tc_river = 10000.0; # Trasportation cost of crossing the river (without transportation infrastructure)
tc_road = 1.0; # Transportation cost of traveling on roads
tc_bridge = 1.0; # Transportation cost of traveling on bridge
tc_ferry = 4.0; # Transportation cost of traveling on ferry
=#
#network_params = [nobs, tc_walk, tc_river, tc_road, tc_bridge, tc_ferry];

#=
# Vector of graphs for each period
graph

# Vector of adjancency matrices in each period 
adj_matrix

# Vector of edges in each period
river_edges, road_edges, bridge_edges, ferry_edges

# Matrix with transportation costs distribution
tc_distrib = [[1, 2, 3, 4, 5, 6, 7, 8], [0.0, 0.0, 0.2, 0.6, 0.2, 0.0, 0.0, 0.0]]

=#

################ Before this point, they should be inputs of the function ###################

################ The function starts here ################

    # Initialize vector of weighted shortest path matrices for each period
    #sp_weighted = [zeros(Float64, nobs, nobs) for i in 1:periods];

    # Initialize vector of transportation cost matrices for each counterfactual scenario
    distmx_ctfl = [zeros(Float64, N^2, N^2) for j in 1:lastindex(tc_value)];
    sp_ctfl = [zeros(Float64, N^2, N^2) for j in 1:lastindex(tc_value)];
    
    for c in 1:lastindex(tc_value) 
        distmx_ctfl[c] = dist_btw_nodes(N, adj_matrix, tc_walk, road_edges, tc_road, river_edges, tc_river, bridge_edges, tc_bridge, ferry_edges, tc_value[c]);
        sp_ctfl[c] = shortest_path(N, graph, distmx_ctfl[c]) # tc_weigth[c] * shortest_path(N, graph, distmx_ctfl[c], periods)
    end

    return sp_ctfl
end

#=

d = ones(4,4) * 1
e = ones(4,4) * 2
f = ones(4,4) * 3
g = ones(4,4) * 4
h = ones(4,4) * 5
k = ones(4,4) * 6
J = [[d, e],[f, g], [h, k]]
w = [0.8, 0.1, 0.1]
M = w[1] * J[1]
N = w[2] * J[2]
O = w[3] * J[3]
M+N+O
[d, e]+[f, g]+[h, k]
sum(J)
J[1]

M = [[d, e],[f, g]]
N = sum.(M, dims = 2)
# Create empty graph for each period
graph = [Graph(N^2) for i in 1:periods]

for p in 1:periods
    for i in 1:N, j in 1:N
        node = (i - 1) * N + j
        neighbors = [(i - 1, j), (i + 1, j), (i, j - 1), (i, j + 1), (i - 1, j - 1), (i - 1, j + 1), (i + 1, j - 1), (i + 1, j + 1)]
        for (ni, nj) in neighbors
            if ni in 1:N && nj in 1:N
                neighbor_node = (ni - 1) * N + nj
                add_edge!(graph[p], node, neighbor_node)
            end
        end
    end
end

adj_matrix = [zeros(Float64, nobs, nobs) for i in 1:periods];

for p in 1:periods
    adj_matrix[p] = adjacency_matrix(graph[p]);
end

include("get_network.jl")
include("geography_edges.jl")
include("transportation_edges.jl")
include("get_edges3.jl")

river_edges, road_edges, bridge_edges, ferry_edges = get_edges(N, adj_matrix, periods, 2)

river_edges[2]

# Initialize
border1 = [Vector{Tuple{Int64, Int64}}() for i in 1:periods];
border2 = [Vector{Tuple{Int64, Int64}}() for i in 1:periods];
roads = [Vector{Vector{Tuple{Int64, Int64}}}() for i in 1:periods];
bridges = [Vector{Vector{Tuple{Int64, Int64}}}() for i in 1:periods];
ferries = [Vector{Vector{Tuple{Int64, Int64}}}(); for i in 1:periods];

for p in 1:periods
    # Get network
    border1[p], border2[p], roads[p], bridges[p], ferries[p] = get_network(network_id, p)

end


river_edges = [Vector{Tuple{Int64, Int64}}() for i in 1:periods];
road_edges = [Vector{Tuple{Int64, Int64}}() for i in 1:periods];
bridge_edges = [Vector{Tuple{Int64, Int64}}() for i in 1:periods];
ferry_edges = [Vector{Tuple{Int64, Int64}}() for i in 1:periods];


# Get edges
river_edges = geography_edges(N, adj_matrix[1], border1[1], border2[1]);
road_edges = transportation_edges(N, adj_matrix[1], roads[1]);
bridge_edges = transportation_edges(N, adj_matrix[1], bridges[1]);
ferry_edges = transportation_edges(N, adj_matrix[1], ferries[1]);

=#
