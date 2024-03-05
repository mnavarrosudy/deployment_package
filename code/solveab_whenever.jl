function solveab_whenever(param, w, L, L_ini, tc, w_periods, L_periods, T_periods, d, nobs, model, a_ini = nothing, b_ini = nothing)

    xtic = time()

    # Assign values from param
    alpha = param[1]
    theta = param[2]
    epsilon = param[3]
    phi = param[6]
    H = param[7] * ones(nobs)
    LL = param[8]
    beta = param[10]

    # Convergence indicator
    aconverge = 0.0
    bconverge = 0.0

    # The function that calls solveab_in_whenever iterates over the number of years for which we have data.
    # For now, as a shortcut, we assume that the we have the same number of years (but possibly different years) for w and L.
    w_year = w_periods[d]; # Year of data for which (a, b) are solved.
    T_up_to_w = T_periods[T_periods .<= w_year]; # Years of transportation innovations before the year of data.
    last_T_up_to_w = T_up_to_w[lastindex(T_up_to_w)]; # Year of the last transportation innovation before the year of data.
    T_up_to_w_and_w = copy(T_up_to_w);
    w_year ∉ T_up_to_w ? push!(T_up_to_w_and_w, w_year) : T_up_to_w_and_w; # Add the year of data to the vector T_up_to_w_and_w
    
    L_year = L_periods[d]; # Year of data for which (a, b) are solved.
    T_up_to_L = T_periods[T_periods .<= L_year]; # Years of transportation innovations before the year of data.
    last_T_up_to_L = T_up_to_L[lastindex(T_up_to_L)]; # Year of the last transportation innovation before the year of data.
    T_up_to_L_and_L = copy(T_up_to_L);
    L_year ∉ T_up_to_L ? push!(T_up_to_L_and_L, L_year) : T_up_to_L_and_L; # Add the year of data to the vector T_up_to_L_and_L
    
    # Trade costs
    dd_w = tc[T_periods .== last_T_up_to_w][1] .^ (-theta * phi); # Check this step in the paper. # Type: Matrix{Float64}

    # Initializations
    if (isnothing(a_ini))
        a_i = ones(nobs)
    else
        a_i = a_ini
    end

    if (isnothing(b_ini))
        b_i = ones(nobs)
    else
        b_i = b_ini
    end

    tradesh = zeros(nobs, nobs)
    dtradesh = zeros(nobs)

    # Initialize the vector where wages and population in steady state are stored for each transportation innovation.
    w_ss = [zeros(Float64, nobs) for i in 1:lastindex(T_periods)];
    L_ss = [zeros(Float64, nobs) for i in 1:lastindex(T_periods)];

    # Initialize the vector of predicted population at a certain point in time based on convergence process. 
    L_hat = [zeros(Float64, nobs) for i in 1:lastindex(T_up_to_L_and_L)]; 

    # Initialize the vector of predicted population at a certain point in time based on convergence process to be used in inner loop.
    L_hat_for_w = [zeros(Float64, nobs) for i in 1:lastindex(T_up_to_w_and_w)]; 

    function loops(alpha, theta, epsilon, L, w, H, LL, a_i, b_i, tradesh, dtradesh, aconverge, bconverge, dd_w, L_ini)
        xx = 1
        counter_outer = 1

        ######################################
        ### Start outer loop for amenities ###
        ######################################
        
        while xx < 2000

            #########################################
            ### Start inner loop for productivity ###
            #########################################

            x = 1
            counter_inner = 1
            while x < 2000
                # Trade share
                if (model == 1)
                    pwmat = a_i .* (w .^ (-theta)) * ones(1, nobs)
                elseif (model == 2)
                    pwmat = (L_ini .* (a_i .^ theta) .* (w .^ (-theta))) * ones(Float64, 1, nobs)
                else
                    aconverge = 0.0
                    x = 10000
                    break
                end
                nummat = dd_w .* pwmat
                denom = sum(nummat, dims = 1)
                denommat = ones(nobs, 1) * denom
                tradesh = nummat ./ denommat

                # Income equals expenditure
                income = w .* L_ini
                expend = tradesh * income
            
                # Convergence criterion
                income_r = round.(income .* (10 .^ 6))
                expend_r = round.(expend .* (10 .^ 6))
            
                # Update loop
                if income_r == expend_r
                    x = 10000
                    aconverge = 1.0
                else
                    a_e = a_i .* (income ./ expend)
                    a_i = 0.25 .* a_e .+ 0.75 .* a_i
                    # Normalization
                    a_i = a_i ./ geomean(a_i)
                    aconverge = 0.0
                    x += 1
                end
                counter_inner = counter_inner + 1                
            end
            #println("Inner loop for productivity was solved $counter_inner times.")
            
            #######################################
            ### End inner loop for productivity ###
            #######################################

            #println("The first element of a_i: ", a_i[1])

            # After the inner loop, 'a_i' is converged. Using 'a_i' converged, and an initial guess of 'b_i', we compute w_ss and L_ss for the transportation innovations.
            for t in 1:lastindex(T_periods)
                # Given (a, b), solve for the wages and population in each steady state t associated with a transportation innovation.
                w_ss[t], L_ss[t] = solveLw(param, a_i, b_i, tc[t], nobs, model);
            end

            # Once we have w_ss and L_ss, we solve for L_D using our reduced-form convergence process
            for t in 1:lastindex(T_up_to_L_and_L)
                if t == 1
                    L_hat[t] = L_ss[t]
                else
                    L_hat[t] = beta ^ (T_up_to_L_and_L[t] - T_up_to_L_and_L[t-1]) * L_hat[t-1] + (1 - beta ^ (T_up_to_L_and_L[t] - T_up_to_L_and_L[t-1])) * L_ss[t-1]
                end
            end

            # This corresponds to the population vector in the year at the position `d` in the vector L_periods.
            L_D = L_hat[lastindex(T_up_to_L_and_L)]

            # We also solve for L in the year of w data to be used in the inner loop.
            for t in 1:lastindex(T_up_to_w_and_w)
                if t == 1
                    L_hat_for_w[t] = L_ss[t]
                else
                    L_hat_for_w[t] = beta ^ (T_up_to_w_and_w[t] - T_up_to_w_and_w[t-1]) * L_hat_for_w[t-1] + (1 - beta ^ (T_up_to_w_and_w[t] - T_up_to_w_and_w[t-1])) * L_ss[t-1]
                end
            end

            # We replace L_ini to be used in the inner loop. This corresponds to the population vector in the year at the position `d` in the vector w_periods
            L_ini = L_hat_for_w[lastindex(T_up_to_w_and_w)]

            #println("The first element of L_D_hat: ", L_D[1])

            # Convergence criterion
            L_r = round.(L .* (10 .^ 6)) # Original tolerance is 10 .^ 6
            L_D_r = round.(L_D .* (10 .^ 6)) # Original tolerance is 10 .^ 6

            # Update loop
            if L_r == L_D_r
                xx = 10000
                bconverge = 1.0
            else
                b_e = b_i .* (L ./ L_D)
                b_i = 0.25 * b_e .+ 0.75 * b_i
                # Normalization
                b_i = b_i ./ geomean(b_i)
                bconverge = 0.0
                xx += 1
            end
            #println("The first element of b_i: ", b_i[1])
            counter_outer = counter_outer + 1
        end
        #println("Outer loop for amenity was solved $counter_outer times")
        return a_i, b_i, tradesh, aconverge, bconverge

    end
    a, b, tradesh, aconverge, bconverge = loops(alpha, theta, epsilon, L, w, H, LL, a_i, b_i, tradesh, dtradesh, aconverge, bconverge, dd_w, L_ini)
    xtic = time() - xtic;


    # Throw a message in case there is failure in convergence
    if (aconverge != 1.0) & (bconverge != 1.0)
        println("Productivities and Amenities failed to converge")
    elseif (aconverge != 1.0)
        println("Productivities failed to converge")
    elseif (bconverge != 1.0)
        println("Amenities failed to converge")
    end

    #println("Convergence time: $xtic")

    return a, b #, tradesh, dtradesh, aconverge, bconverge, xtic
end