function geography_edges(N, adj_matrix, border_1, border_2)
    
    river_edges = Vector{Tuple{Int64, Int64}}()
    
    if (isempty(border_1) || isempty(border_2))
        river_edges = Vector{Tuple{Int64, Int64}}(); #nothing;
    else
        for node1 in border_1
            for node2 in border_2
                if node1[1] < 0 || node1[1] > N || node1[2] < 0 || node1[2] > N ||
                    node2[1] < 0 || node2[1] > N || node2[2] < 0 || node2[2] > N
                    continue  # Skip if any node is outside the grid
                end
        
                index1 = node1[2] * N + node1[1] + 1
                index2 = node2[2] * N + node2[1] + 1

                if adj_matrix[index1, index2] == 1 && node1 != node2
                    push!(river_edges, (index1, index2))
                    push!(river_edges, (index2, index1))
                end
            end
        end
    end
    return river_edges
end