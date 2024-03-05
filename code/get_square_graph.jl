# Description: This function creates a squared network of N^2 nodes, with horizontal, vertical and diagional links between adjacent nodes.

function get_square_graph(N)

    # Create empty graph
    graph = Graph(N^2)

    # Add edges between adjacent nodes and nodes in diagonals
    for i in 1:N, j in 1:N
        node = (i - 1) * N + j
        neighbors = [(i - 1, j), (i + 1, j), (i, j - 1), (i, j + 1), (i - 1, j - 1), (i - 1, j + 1), (i + 1, j - 1), (i + 1, j + 1)]
        for (ni, nj) in neighbors
            if ni in 1:N && nj in 1:N
                neighbor_node = (ni - 1) * N + nj
                add_edge!(graph, node, neighbor_node)
            end
        end
    end

    return graph
end