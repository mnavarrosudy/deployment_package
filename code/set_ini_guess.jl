function set_ini_guess(convergence, transp_param, gamma_dim)

    # Note: The initial guess needs to be a STRICT interior point.

    if (convergence == true) & (transp_param == false)
        println("Two scalar parameters θ and β to be estimated.")
        # Initial solution guess
        ini_guess = [3.1, 0.7];
        params_to_est = "theta_and_beta";

    elseif (convergence == true) & (transp_param == true)
        println("Two scalar parameters θ and β, and one parameter vector γ of dimension ", gamma_dim, " to be estimated.")
        # Initial solution guess
        ini_guess = [3.1, 0.7, fill(1/gamma_dim, gamma_dim)...];
        params_to_est = "theta_beta_and_gamma";

    elseif (convergence == false) & (transp_param == false)
        println("One scalar parameter θ to be estimated.")
        # Initial solution guess
        ini_guess = [3.1];
        params_to_est = "theta";

    elseif (convergence == false) & (transp_param == true)
        println("One scalar parameters θ, and one parameter vector γ of dimension ", gamma_dim, " to be estimated.")
        # Initial solution guess
        #ini_guess = [3.5, fill(1/gamma_dim, gamma_dim)...];
        ini_guess = [4.0, 1/4, 1/4, 1/2];
        params_to_est = "theta_and_gamma";
    end
    return ini_guess, params_to_est
end