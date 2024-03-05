function transportation_edges(N, adj_matrix, node_seq)
    
    transportation_edges = Vector{Tuple{Int64, Int64}}()
    
    if isempty(node_seq) 
        transportation_edges = Vector{Tuple{Int64, Int64}}(); #nothing;
    else
        for seq in node_seq
            for i in 1:length(seq) - 1
                node1 = seq[i]
                node2 = seq[i + 1]
                
                if node1[1] < 0 || node1[1] > N || node1[2] < 0 || node1[2] > N ||
                    node2[1] < 0 || node2[1] > N || node2[2] < 0 || node2[2] > N
                    continue  # Skip if any node is outside the grid
                end
                
                index1 = node1[2] * N + node1[1] + 1
                index2 = node2[2] * N + node2[1] + 1
                
                if adj_matrix[index1, index2] == 1
                    push!(transportation_edges, (index1, index2))
                    push!(transportation_edges, (index2, index1))
                end
            end
        end
    end
    return transportation_edges
end