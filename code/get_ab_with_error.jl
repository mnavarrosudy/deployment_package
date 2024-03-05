function get_ab_with_error(mc_data_iteration, period, error_struct, mu, sigma)
    
    # Productivity
    a = mc_data_iteration[:, 2]

    # Amenity
    b = mc_data_iteration[:, 3]

    # Scale distribution of econometric errors
    e = mu .+ sigma .* mc_data_iteration[:, period+3]

    # Initialize variable that represents the error
    err = 0

    # Error structure. 1: Additive; 2: Multiplicative
    if error_struct == 2
        # Lognormal transformation (to make all elements positive)
        err = exp.(e)

        # Productivity and amenity vectors with econometric error
        a_mc = a .* err
        b_mc = b .* err

    else
        # No additional transformation
        err = e

        # Productivity and amenity vectors with econometric error
        a_mc = a .+ err
        b_mc = b .+ err

    end

    # Normalization
    a_mc = a_mc ./ geomean(a_mc)
    b_mc = b_mc ./ geomean(b_mc)

    a_ratio = mean(a) / mean(a_mc)
    b_ratio = mean(b) / mean(b_mc)
    var_ratio = var(err) / var(a)
    return a_mc, b_mc, a_ratio, b_ratio, var_ratio
end