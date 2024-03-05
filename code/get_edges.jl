# Description: This function initializes the variables that contain the cartesian coordinates associated with rivers, roads, ferries, and bridges.
# It calls the function get_network(..) where there are predetermined network structures, and returns these objects. 

# Additional functions used below
include(joinpath(file_dir, "get_network.jl"))
include(joinpath(file_dir, "geography_edges.jl"))
include(joinpath(file_dir, "transportation_edges.jl"))

function get_edges(N, adj_matrix, period, network_id)

    borders, roads, bridges, ferries = get_network(network_id, period)
    n_rivers = lastindex(borders) / 2;
    river_edges = Vector{Tuple{Int64, Int64}}()
    
    for i in 1:n_rivers
        #println("river ", i)
        j = Int(2*i - 1)
        #println("border ", j, " and ", j+1)
        river_edges = [river_edges; geography_edges(N, adj_matrix, borders[j], borders[j+1])]
    end

    # Get edges
    #river_edges = geography_edges(N, adj_matrix, borders[1], borders[2]);
    road_edges = transportation_edges(N, adj_matrix, roads);
    bridge_edges = transportation_edges(N, adj_matrix, bridges);
    ferry_edges = transportation_edges(N, adj_matrix, ferries);

    return river_edges, road_edges, bridge_edges, ferry_edges
    
end