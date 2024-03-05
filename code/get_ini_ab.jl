function get_ini_ab(a, b, w, L)
    
    # We regress (a, b) on a constant, w, and L and predict their values.
    reg_data = DataFrame(a=a, b=b, w=w, L=L)
    a_ols = lm(@formula(a~w+L), reg_data)
    b_ols = lm(@formula(b~w+L), reg_data)
    a_ini = predict(a_ols).+1.0;
    b_ini = predict(b_ols).+1.0;

    return a_ini, b_ini
end