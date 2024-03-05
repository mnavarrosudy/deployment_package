function solveLw_in_D(param, a, b, L_ss, tc, D_periods, T_periods, d, nobs, model)

    ########################################################
    ### First step: Convergence of L in the year of data ###
    ########################################################

    D_year = D_periods[d]; # Year of data for which (w, L) are solved.
    T_up_to_D = T_periods[T_periods .<= D_year]; # Years of transportation innovations before the year of data.
    last_T_up_to_D = T_up_to_D[lastindex(T_up_to_D)]; # Year of the last transportation innovation before the year of data.
    D_year ∉ T_up_to_D ? push!(T_up_to_D, D_year) : T_up_to_D; # T_up_to_D is a vector containing the transportation innovation years and also the year of data to be analyzed.
    
    L_hat = [zeros(Float64, nobs) for i in 1:lastindex(T_up_to_D)]; 
    L_ss_before_D = L_ss[T_periods .<= D_year]; # Vector with steady state populations for every year with a transportation innovation before the year of data to be analyzed.
    
    # Reduced-form convergence process
    for t in 1:lastindex(T_up_to_D)
        if t == 1
            L_hat[t] = L_ss_before_D[t]
        else
            L_hat[t] = param[10] ^ (T_up_to_D[t] - T_up_to_D[t-1]) * L_hat[t-1] + (1 - param[10] ^ (T_up_to_D[t] - T_up_to_D[t-1])) * L_ss_before_D[t-1]
        end
    end
    
    L_D = L_hat[lastindex(T_up_to_D)] # L in the year of data

    ##############################################################################################################
    ### Second step: Steady state of w, given fundamentals (a, b), L_D, and the last transportation innovation ###
    ##############################################################################################################

    # Assign values from param
    alpha = param[1]
    theta = param[2]
    epsilon = param[3]
    phi = param[6]
    H = param[7] * ones(nobs)
    LL = param[8]

    # Initializations
    w_D = ones(nobs)
    tradesh = zeros(nobs, nobs)
    dtradesh = zeros(nobs)

    # Convergence indicator
    wconverge = 0.0

    # Trade costs
    dd = tc[T_periods .== last_T_up_to_D][1] .^ (-theta * phi); # Check this step in the paper. # Type: Matrix{Float64}

    x = 1

    # Loop to solve for w_D
    while x < 2000
        # Trade share
        if (model == 1)
            pwmat = (a .* (w_D .^ (-theta))) * ones(1, nobs) # Type: Matrix{Float64}
        elseif (model == 2)
            pwmat = L_D .* (a .^ theta) .* (w_D .^ (-theta)) * ones(1, nobs)
        else
            wconverge = 0.0
            x = 10000
            break
        end
        nummat = dd .* pwmat
        denom = sum(nummat, dims = 1)
        denommat = ones(nobs, 1) * denom
        tradesh = nummat ./ denommat

        # Income equals expenditure
        income = w_D .* L_D
        expend = tradesh * income
        
        # Convergence criterion
        income_r = round.(Int, income .* (10 .^ 6))
        expend_r = round.(Int, expend .* (10 .^ 6))

        # Update loop
        if income_r == expend_r
            x = 10000
            wconverge = 1.0
        else
            w_e = w_D .* (expend ./ income) .^ (1 / theta)
            w_D = 0.25 * w_e + 0.75 * w_D # Type: Vector{Float64}
            # Normalization
            w_D = w_D ./ geomean(w_D) # Type: Vector{Float64}
            wconverge = 0.0
            x += 1
        end
    end

    return w_D, L_D
end