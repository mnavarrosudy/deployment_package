function weight_shortest_path(nobs, tc_on_grid, tc_weigth)

    # Initialize vector of weighted counterfactual shortest path matrices for each period
    tc_ctfl_weighted = [zeros(Float64, nobs, nobs) for i in 1:lastindex(tc_weigth)];

    # Initialize vector of weighted shortest path matrices for each period
    tc_weighted = zeros(Float64, nobs, nobs);
#=
    println("the type of the object that receives the weighted matrices is: ", typeof(sp_ctfl_weighted))
    println("the type of the shortest path object is: ", typeof(sp_on_grid))
    println("the type of the weighting procedure is: ", typeof(tc_weigth[1] * sp_on_grid[1]))

    println("the number of multiplications is: ", lastindex(tc_weigth))
=#
    for w in 1:lastindex(tc_weigth) 
        tc_ctfl_weighted[w] = tc_weigth[w] * tc_on_grid[w]
    end

    tc_weighted = sum(tc_ctfl_weighted)

    return tc_weighted
end