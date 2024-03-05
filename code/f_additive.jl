function f_additive(psi_hat, params_to_est, param, w, L, tc_on_grid, wL_periods, w_periods, L_periods, T_periods, D_periods, nobs, model, diff_periods, a_ini = nothing, b_ini = nothing)

    xtic = time()

    # Initialize vector of vectors that receive the equilibrium a and b
    a = [zeros(Float64, nobs) for i in 1:D_periods]; # I assume that the number of w years are the same as the number of L years
    b = [zeros(Float64, nobs) for i in 1:D_periods]; # I assume that the number of w years are the same as the number of L years

    param_it = copy(param)

    if params_to_est == "theta"
        theta_hat = psi_hat[1]

        # Replace theta in param for theta_hat sent by the optimizer
        param_it[2] = theta_hat

        for t in 1:lastindex(T_periods)
            a[t], b[t] = solveab(param_it, w[t], L[t], tc_true_dgp_weighted[t], nobs, model);
        end

        # Moments and objective function for different periods
        Q = calc_obj_func(a, b, T_periods)

    elseif params_to_est == "theta_and_beta"
        theta_hat = psi_hat[1]
        beta_hat = psi_hat[2]

        # Replace theta and beta in param for theta_hat and beta_hat sent by the optimizer
        param_it[2] = theta_hat
        param_it[10] = beta_hat

        for d in 1:lastindex(D_periods)
            #println("period $p")
            a[d], b[d] = solveab_in_D(param_it, w[d], L[d], tc_true_dgp_weighted, D_periods, T_periods, d, nobs, model)
        end

        # Moments and objective function for different periods
        Q = calc_obj_func(a, b, D_periods)
        
    elseif params_to_est == "theta_and_gamma"
        theta_hat = psi_hat[1]
        gamma_hat = psi_hat[2:end]

        # Replace theta in param for theta_hat sent by the optimizer
        param_it[2] = theta_hat

        tc_on_grid_weighted = [zeros(Float64, nobs, nobs) for i in 1:lastindex(T_periods)];

        for t in 1:lastindex(T_periods)
            tc_on_grid_weighted[t] = weight_shortest_path(nobs, tc_on_grid[t], gamma_hat)
        end

        for d in 1:lastindex(L_periods)
            if diff_periods
                println("Solving model with different periods for L and w in year ", d)
                a[d], b[d] = solveab_whenever(param_it, w[d], L[d], L[d], tc_on_grid_weighted, w_periods, L_periods, T_periods, d, nobs, model, a_ini, b_ini)
            else
                println("Solving model with the same periods for L and w in year ", d)
                a[d], b[d] = solveab_in_D(param_it, w[d], L[d], tc_on_grid_weighted, wL_periods, T_periods, d, nobs, model, a_ini, b_ini);
            end
            #a[t], b[t] = solveab(param_it, w[t], L[t], tc_on_grid_weighted[t], nobs, model);
        end

        # Moments and objective function for different periods
        Q = calc_obj_func(a, b, D_periods)

    elseif params_to_est == "theta_beta_and_gamma"
        theta_hat = psi_hat[1]
        beta_hat = psi_hat[2]
        gamma_hat = psi_hat[3:end]

        # Replace theta and beta in param for theta_hat and beta_hat sent by the optimizer
        param_it[2] = theta_hat
        param_it[10] = beta_hat

        tc_on_grid_weighted = [zeros(Float64, nobs, nobs) for i in 1:lastindex(T_periods)];

        for t in 1:lastindex(T_periods)
            if (lastindex(gamma_hat) == 1)
                tc_on_grid_weighted[t] = tc_on_grid[t][1]
            else
                tc_on_grid_weighted[t] = weight_shortest_path(nobs, tc_on_grid[t], gamma_hat)
            end
        end

        for d in 1:lastindex(D_periods)
            #println("period $p")
            a[d], b[d] = solveab_in_D(param_it, w[d], L[d], tc_on_grid_weighted, D_periods, T_periods, d, nobs, model)
        end

        # Moments and objective function for different periods
        Q = calc_obj_func(a, b, D_periods)
    end
    xtic = time() - xtic;
    eval_time = round(xtic/60; digits = 2);
    println("psi_hat = ", psi_hat, "; obj. function = ", Q, "; eval. time = ", eval_time, " min.")
    return Q, eval_time
end