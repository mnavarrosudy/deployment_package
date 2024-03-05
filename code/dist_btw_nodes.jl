function dist_btw_nodes(N, adj_matrix, tc_walk, road_edges, tc_road, river_edges, tc_river, bridge_edges, tc_bridge, ferry_edges, tc_ferry)
    
    # Create matrix of transportation costs on edges
    distmx = fill(Inf, N^2, N^2); 
    
    # Fill transportation cost matrix with walking cost
    for i in 1:N^2
        for j in 1:N^2
            if adj_matrix[i, j] == 1
                node1 = ((i - 1) % N + 1, (i - 1) ÷ N + 1)
                node2 = ((j - 1) % N + 1, (j - 1) ÷ N + 1)
                
                if abs(node1[1] - node2[1]) + abs(node1[2] - node2[2]) == 1
                    distmx[i, j] = distmx[j, i] = tc_walk  # Orthogonal edge distance
                else
                    distmx[i, j] = distmx[j, i] = sqrt(2) * tc_walk  # Diagonal edge distance
                end
            end
        end
    end

    # Fill transportation cost matrix with river cost
    if isempty(river_edges) #river_edges == nothing
        distmx = distmx
    else
        for (index1, index2) in river_edges
            if adj_matrix[index1, index2] == 1
                if (abs(index1 - index2) == 1 || abs(index1 - index2) == N)
                    distmx[index1, index2] = distmx[index2, index1] = tc_river  # Orthogonal edge distance
                else
                    distmx[index1, index2] = distmx[index2, index1] = sqrt(2) * tc_river  # Diagonal edge distance
                end
            end
        end
    end

    # Fill transportation cost matrix with roads cost    
    if isempty(road_edges) #road_edges == nothing
        distmx = distmx
    else
        for (index1, index2) in road_edges
            if adj_matrix[index1, index2] == 1
                distmx[index1, index2] = distmx[index2, index1] = tc_road
            end
        end
    end

    # Fill transportation cost matrix with bridges cost    
    if isempty(bridge_edges) #bridge_edges == nothing
        distmx = distmx
    else
        for (index1, index2) in bridge_edges
            if adj_matrix[index1, index2] == 1
                distmx[index1, index2] = distmx[index2, index1] = tc_bridge
            end
        end
    end

    # Fill transportation cost matrix with ferries cost    
    if isempty(ferry_edges) #ferry_edges == nothing
        distmx = distmx
    else
        for (index1, index2) in ferry_edges
            if adj_matrix[index1, index2] == 1
                distmx[index1, index2] = distmx[index2, index1] = tc_ferry
            end
        end
    end

    return distmx
end