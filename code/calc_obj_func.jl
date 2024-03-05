function calc_obj_func(a, b, periods)

    # Moments and objective function for different periods
    if (periods == 2)
        m1 = sum((a[1] .- a[2]).^2)
        m2 = sum((b[1] .- b[2]).^2)
        Q = 0.5*m1 + (1-0.5)*m2
    elseif (periods == 3)
        m1 = sum((a[1] .- a[2]).^2)
        m2 = sum((a[1] .- a[3]).^2)
        m3 = sum((a[2] .- a[3]).^2)
        m4 = sum((b[1] .- b[2]).^2)
        m5 = sum((b[1] .- b[3]).^2)
        m6 = sum((b[2] .- b[3]).^2)
        Q = (1/6)*m1 + (1/6)*m2 + (1/6)*m3 + (1/6)*m4 + (1/6)*m5 + (1/6)*m6
    end
    return Q
end