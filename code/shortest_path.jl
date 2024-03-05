function shortest_path(N, graph, distmx)

    # Shortest path matrix
    shortest_path = zeros(N^2, N^2);

        for i in 1:N^2
            shortest_path[i, :] = dijkstra_shortest_paths(graph, i, distmx).dists
        end
    
        shortest_path[diagind(shortest_path)] .= 1.0;

    return shortest_path
end