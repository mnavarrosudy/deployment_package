function solveLw_whenever(param, a, b, L_ss, tc, w_periods, L_periods, T_periods, d, nobs, model)

    ################################################################
    ### First step: Convergence of L in the year we want L to be ###
    ################################################################

    L_year = L_periods[d]; # Year of data for which (a, b) are solved.
    T_up_to_L = T_periods[T_periods .<= L_year]; # Years of transportation innovations before the year of data.
    last_T_up_to_L = T_up_to_L[lastindex(T_up_to_L)]; # Year of the last transportation innovation before the year of data.
    T_up_to_L_and_L = copy(T_up_to_L);
    L_year ∉ T_up_to_L ? push!(T_up_to_L_and_L, L_year) : T_up_to_L_and_L; # Add the year of data to the vector T_up_to_L_and_L
    
    L_hat = [zeros(Float64, nobs) for i in 1:lastindex(T_up_to_L_and_L)]; 

    # Reduced-form convergence process
    for t in 1:lastindex(T_up_to_L_and_L)
        if t == 1
            L_hat[t] = L_ss[t]
        else
            L_hat[t] = beta ^ (T_up_to_L_and_L[t] - T_up_to_L_and_L[t-1]) * L_hat[t-1] + (1 - beta ^ (T_up_to_L_and_L[t] - T_up_to_L_and_L[t-1])) * L_ss[t-1]
        end
    end
    
    L_D = L_hat[lastindex(T_up_to_L_and_L)] # L in the year of data

    #################################################################
    ### Second step: Convergence of L in the year we want w to be ###
    #################################################################

    w_year = w_periods[d]; # Year of data for which (a, b) are solved.
    T_up_to_w = T_periods[T_periods .<= w_year]; # Years of transportation innovations before the year of data.
    last_T_up_to_w = T_up_to_w[lastindex(T_up_to_w)]; # Year of the last transportation innovation before the year of data.
    T_up_to_w_and_w = copy(T_up_to_w);
    w_year ∉ T_up_to_w ? push!(T_up_to_w_and_w, w_year) : T_up_to_w_and_w; # Add the year of data to the vector T_up_to_w_and_w

    L_hat_for_w = [zeros(Float64, nobs) for i in 1:lastindex(T_up_to_w_and_w)]; 

    for t in 1:lastindex(T_up_to_w_and_w)
        if t == 1
            L_hat_for_w[t] = L_ss[t]
        else
            L_hat_for_w[t] = beta ^ (T_up_to_w_and_w[t] - T_up_to_w_and_w[t-1]) * L_hat_for_w[t-1] + (1 - beta ^ (T_up_to_w_and_w[t] - T_up_to_w_and_w[t-1])) * L_ss[t-1]
        end
    end

    L_D_for_w = L_hat_for_w[lastindex(T_up_to_w_and_w)]

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
    dd = tc[T_periods .== last_T_up_to_w][1] .^ (-theta * phi); # Check this step in the paper. # Type: Matrix{Float64}

    x = 1

    # Loop to solve for w_D
    while x < 2000
        # Trade share
        if (model == 1)
            pwmat = (a .* (w_D .^ (-theta))) * ones(1, nobs) # Type: Matrix{Float64}
        elseif (model == 2)
            pwmat = L_D_for_w .* (a .^ theta) .* (w_D .^ (-theta)) * ones(1, nobs)
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
        income = w_D .* L_D_for_w
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