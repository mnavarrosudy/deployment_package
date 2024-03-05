function get_network(network_id, period)

    borders = Vector{Vector{Tuple{Int64, Int64}}}();
    border1 = Vector{Tuple{Int64, Int64}}();
    border2 = Vector{Tuple{Int64, Int64}}();
    border3 = Vector{Tuple{Int64, Int64}}();
    border4 = Vector{Tuple{Int64, Int64}}();
    roads = Vector{Vector{Tuple{Int64, Int64}}}();
    bridges = Vector{Vector{Tuple{Int64, Int64}}}();
    ferries = Vector{Vector{Tuple{Int64, Int64}}}();
    
    if network_id == 1
        # River borders
        border1 = Vector{Tuple{Int64, Int64}}([(0,5), (1,5), (2,5), (3,5), (4,5), (5,5), (6,5), (7,5), (8,5), (9,5), (10,5)]);
        border2 = Vector{Tuple{Int64, Int64}}([(0,6), (1,6), (2,6), (3,6), (4,6), (5,6), (6,6), (7,6), (8,6), (9,6), (10,6)]);
        push!(borders, border1);
        push!(borders, border2);

        if period == 1
            # Roads
            road1_0 = Vector{Tuple{Int64, Int64}}([(5,0), (5,1), (5,2), (5,3), (5,4), (5,5)]);
            road2_0 = Vector{Tuple{Int64, Int64}}([(0,5), (1,5), (2,5), (3,5), (4,5), (5,5), (6,5), (7,5), (8,5), (9,5), (10,5)]);
            road3_0 = Vector{Tuple{Int64, Int64}}([(5,6), (5,7), (5,8), (5,9), (5,10)]);
            push!(roads, road1_0);
            push!(roads, road2_0);
            push!(roads, road3_0);

            # Bridges

            # Ferries
            ferry1_0 = Vector{Tuple{Int64, Int64}}([(5,5), (5,6)]);
            push!(ferries, ferry1_0);

        elseif period == 2
            # Roads
            road1_1 = Vector{Tuple{Int64, Int64}}([(5,0), (5,1), (5,2), (5,3), (5,4), (5,5)]);
            road2_1 = Vector{Tuple{Int64, Int64}}([(0,5), (1,5), (2,5), (3,5), (4,5), (5,5), (6,5), (7,5), (8,5), (9,5), (10,5)]);
            road3_1 = Vector{Tuple{Int64, Int64}}([(5,6), (5,7), (5,8), (5,9), (5,10)]);
            push!(roads, road1_1);
            push!(roads, road2_1);
            push!(roads, road3_1);

            # Bridges
            bridge1_1 = Vector{Tuple{Int64, Int64}}([(5,5), (5,6)]);
            push!(bridges, bridge1_1);

            # Ferries


        elseif period == 3
            # Roads
            road1_1 = Vector{Tuple{Int64, Int64}}([(5,0), (5,1), (5,2), (5,3), (5,4), (5,5)]);
            road2_1 = Vector{Tuple{Int64, Int64}}([(0,5), (1,5), (2,5), (3,5), (4,5), (5,5), (6,5), (7,5), (8,5), (9,5), (10,5)]);
            road3_1 = Vector{Tuple{Int64, Int64}}([(5,6), (5,7), (5,8), (5,9), (5,10)]);
            push!(roads, road1_1);
            push!(roads, road2_1);
            push!(roads, road3_1);

            # Bridges
            bridge1_1 = Vector{Tuple{Int64, Int64}}([(5,5), (5,6)]);
            push!(bridges, bridge1_1);

            # Ferries

        end
    elseif network_id == 2
        # River borders
        border1 = Vector{Tuple{Int64, Int64}}([(0,5), (1,5), (2,5), (3,5), (4,5), (5,5), (6,5), (7,5), (8,5), (9,5), (10,5)]);
        border2 = Vector{Tuple{Int64, Int64}}([(0,6), (1,6), (2,6), (3,6), (4,6), (5,6), (6,6), (7,6), (8,6), (9,6), (10,6)]);
        push!(borders, border1);
        push!(borders, border2);

        if period == 1

            # Roads
            #road1_0 = Vector{Tuple{Int64, Int64}}([(5,0), (5,1), (5,2), (5,3), (5,4), (5,5)]);
            #road2_0 = Vector{Tuple{Int64, Int64}}([(0,5), (1,5), (2,5), (3,5), (4,5), (5,5), (6,5), (7,5), (8,5), (9,5), (10,5)]);
            #push!(roads, road1_0);
            #push!(roads, road2_0);

            # Bridges

            # Ferries
            ferry1_0 = Vector{Tuple{Int64, Int64}}([(2,5), (2,6)]);
            ferry2_0 = Vector{Tuple{Int64, Int64}}([(5,5), (5,6)]);
            #ferry3_0 = Vector{Tuple{Int64, Int64}}([(9,5), (9,6)]);
            push!(ferries, ferry1_0);
            push!(ferries, ferry2_0);
            #push!(ferries, ferry3_0);

        elseif period == 2
            # Roads
            #road1_1 = Vector{Tuple{Int64, Int64}}([(5,0), (5,1), (5,2), (5,3), (5,4), (5,5)]);
            #road2_1 = Vector{Tuple{Int64, Int64}}([(0,5), (1,5), (2,5), (3,5), (4,5), (5,5), (6,5), (7,5), (8,5), (9,5), (10,5)]);
            #road3_1 = Vector{Tuple{Int64, Int64}}([(2,5), (2,6), (2,7), (2,8), (2,9), (2,10)]); 
            #push!(roads, road1_1);
            #push!(roads, road2_1);
            #push!(roads, road3_1);

            # Bridges
            bridge1_1 = Vector{Tuple{Int64, Int64}}([(5,5), (5,6)]);
            push!(bridges, bridge1_1);

            # Ferries
            ferry1_1 = Vector{Tuple{Int64, Int64}}([(2,5), (2,6)]);
            #ferry2_1 = Vector{Tuple{Int64, Int64}}([(9,5), (9,6)]);
            push!(ferries, ferry1_1);
            #push!(ferries, ferry2_1);

        elseif period == 3
            # Roads
            #road1_2 = Vector{Tuple{Int64, Int64}}([(5,0), (5,1), (5,2), (5,3), (5,4), (5,5)]);
            #road2_2 = Vector{Tuple{Int64, Int64}}([(0,5), (1,5), (2,5), (3,5), (4,5), (5,5), (6,5), (7,5), (8,5), (9,5), (10,5)]);
            #road3_2 = Vector{Tuple{Int64, Int64}}([(2,5), (2,6), (2,7), (2,8), (2,9), (2,10)]);
            #road4_2 = Vector{Tuple{Int64, Int64}}([(8,5), (8,6), (8,7), (8,8), (8,9), (8,10)]);
            #push!(roads, road1_2);
            #push!(roads, road2_2);
            #push!(roads, road3_2);
            #push!(roads, road4_2);

            # Bridges   
            bridge1_2 = Vector{Tuple{Int64, Int64}}([(5,5), (5,6)]);
            bridge2_2 = Vector{Tuple{Int64, Int64}}([(2,5), (2,6)]);
            push!(bridges, bridge1_2);
            push!(bridges, bridge2_2);

            # Ferries
            #ferry1_2 = Vector{Tuple{Int64, Int64}}([(2,5), (2,6)]);
            #ferry2_2 = Vector{Tuple{Int64, Int64}}([(9,5), (9,6)]);
            #push!(ferries, ferry1_2);
            #push!(ferries, ferry2_2);

        end
    elseif network_id == 3
        # River borders

        if period == 1

            # Roads
            road1_0 = Vector{Tuple{Int64, Int64}}([(5,0), (5,1), (5,2), (5,3), (5,4), (5,5)]);
            road2_0 = Vector{Tuple{Int64, Int64}}([(0,5), (1,5), (2,5), (3,5), (4,5), (5,5), (6,5), (7,5), (8,5), (9,5), (10,5)]);
            push!(roads, road1_0);
            push!(roads, road2_0);

            # Bridges

            # Ferries

        elseif period == 2
            # Roads
            road1_1 = Vector{Tuple{Int64, Int64}}([(5,0), (5,1), (5,2), (5,3), (5,4), (5,5)]);
            road2_1 = Vector{Tuple{Int64, Int64}}([(0,5), (1,5), (2,5), (3,5), (4,5), (5,5), (6,5), (7,5), (8,5), (9,5), (10,5)]);
            road3_1 = Vector{Tuple{Int64, Int64}}([(2,5), (2,6), (2,7), (2,8), (2,9), (2,10)]);
            push!(roads, road1_1);
            push!(roads, road2_1);
            push!(roads, road3_1);

            # Bridges

            # Ferries

        elseif period == 3
            # Roads
            road1_2 = Vector{Tuple{Int64, Int64}}([(5,0), (5,1), (5,2), (5,3), (5,4), (5,5)]);
            road2_2 = Vector{Tuple{Int64, Int64}}([(0,5), (1,5), (2,5), (3,5), (4,5), (5,5), (6,5), (7,5), (8,5), (9,5), (10,5)]);
            road3_2 = Vector{Tuple{Int64, Int64}}([(2,5), (2,6), (2,7), (2,8), (2,9), (2,10)]);
            road4_2 = Vector{Tuple{Int64, Int64}}([(8,5), (8,6), (8,7), (8,8), (8,9), (8,10)]);
            push!(roads, road1_2);
            push!(roads, road2_2);
            push!(roads, road3_2);
            push!(roads, road4_2);

            # Bridges

            # Ferries

        end
    elseif network_id == 4
        # River borders
        border1 = Vector{Tuple{Int64, Int64}}([(0,5), (1,5), (2,5), (3,5), (4,5), (5,5), (6,5), (7,5), (8,5), (9,5), (10,5)]);
        border2 = Vector{Tuple{Int64, Int64}}([(0,6), (1,6), (2,6), (3,6), (4,6), (5,6), (6,6), (7,6), (8,6), (9,6), (10,6)]);
        push!(borders, border1);
        push!(borders, border2);

        if period == 1

            # Roads
            road1_0 = Vector{Tuple{Int64, Int64}}([(8,10), (8,9), (8,8), (8,7), (8,6)]);
            road2_0 = Vector{Tuple{Int64, Int64}}([(1,6), (2,6), (3,6), (4,6), (5,6), (6,6), (7,6), (8,6)]);
            road3_0 = Vector{Tuple{Int64, Int64}}([(1,5), (2,5), (3,5), (4,5), (5,5), (6,5), (7,5), (8,5)]);
            road4_0 = Vector{Tuple{Int64, Int64}}([(8,5), (8,4), (8,3), (8,2), (8,1), (8,0)]);
            road5_0 = Vector{Tuple{Int64, Int64}}([(1,6), (1,5)]);
            push!(roads, road1_0);
            push!(roads, road2_0);
            push!(roads, road3_0);
            push!(roads, road4_0);
            push!(roads, road5_0);

            # Bridges

            # Ferries
            ferry1_1 = Vector{Tuple{Int64, Int64}}([(8,6), (8,5)]);
            push!(ferries, ferry1_1);


        elseif period == 2
            # Roads
            road1_0 = Vector{Tuple{Int64, Int64}}([(8,10), (8,9), (8,8), (8,7), (8,6)]);
            road2_0 = Vector{Tuple{Int64, Int64}}([(1,6), (2,6), (3,6), (4,6), (5,6), (6,6), (7,6), (8,6)]);
            road3_0 = Vector{Tuple{Int64, Int64}}([(1,5), (2,5), (3,5), (4,5), (5,5), (6,5), (7,5), (8,5)]);
            road4_0 = Vector{Tuple{Int64, Int64}}([(8,5), (8,4), (8,3), (8,2), (8,1), (8,0)]);
            road5_0 = Vector{Tuple{Int64, Int64}}([(1,6), (1,5)]);
            push!(roads, road1_0);
            push!(roads, road2_0);
            push!(roads, road3_0);
            push!(roads, road4_0);
            push!(roads, road5_0);

            # Bridges
            bridge1_1 = Vector{Tuple{Int64, Int64}}([(8,5), (8,6)]);
            push!(bridges, bridge1_1);

            # Ferries

        elseif period == 3
            # Roads
            road1_0 = Vector{Tuple{Int64, Int64}}([(8,10), (8,9), (8,8), (8,7), (8,6)]);
            road2_0 = Vector{Tuple{Int64, Int64}}([(1,6), (2,6), (3,6), (4,6), (5,6), (6,6), (7,6), (8,6)]);
            road3_0 = Vector{Tuple{Int64, Int64}}([(1,5), (2,5), (3,5), (4,5), (5,5), (6,5), (7,5), (8,5)]);
            road4_0 = Vector{Tuple{Int64, Int64}}([(8,5), (8,4), (8,3), (8,2), (8,1), (8,0)]);
            push!(roads, road1_0);
            push!(roads, road2_0);
            push!(roads, road3_0);
            push!(roads, road4_0);

            # Bridges
            bridge1_1 = Vector{Tuple{Int64, Int64}}([(8,5), (8,6)]);
            push!(bridges, bridge1_1);

            # Ferries

        end
    elseif network_id == 5
        # River borders
        border1 = Vector{Tuple{Int64, Int64}}([(0,5), (1,5), (2,5), (3,5), (4,5), (5,5), (6,5), (7,5), (8,5), (9,5), (10,5)]);
        border2 = Vector{Tuple{Int64, Int64}}([(0,6), (1,6), (2,6), (3,6), (4,6), (5,6), (6,6), (7,6), (8,6), (9,6), (10,6)]);
        push!(borders, border1);
        push!(borders, border2);

        if period == 1

            # Roads
            road1_0 = Vector{Tuple{Int64, Int64}}([(8,8), (8,7), (8,6)]);
            road2_0 = Vector{Tuple{Int64, Int64}}([(1,6), (2,6), (3,6), (4,6), (5,6), (6,6), (7,6), (8,6)]);
            road3_0 = Vector{Tuple{Int64, Int64}}([(1,5), (2,5), (3,5), (4,5), (5,5), (6,5), (7,5), (8,5)]);
            road4_0 = Vector{Tuple{Int64, Int64}}([(8,5), (8,4), (8,3)]);
            push!(roads, road1_0);
            push!(roads, road2_0);
            push!(roads, road3_0);
            push!(roads, road4_0);

            # Bridges

            # Ferries
            ferry1_0 = Vector{Tuple{Int64, Int64}}([(8,6), (8,5)]);
            ferry2_0 = Vector{Tuple{Int64, Int64}}([(1,6), (1,5)]);
            push!(ferries, ferry1_0);
            push!(ferries, ferry2_0);

        elseif period == 2
            # Roads
            road1_1 = Vector{Tuple{Int64, Int64}}([(8,10), (8,9), (8,8), (8,7), (8,6)]);
            road2_1 = Vector{Tuple{Int64, Int64}}([(1,6), (2,6), (3,6), (4,6), (5,6), (6,6), (7,6), (8,6)]);
            road3_1 = Vector{Tuple{Int64, Int64}}([(1,5), (2,5), (3,5), (4,5), (5,5), (6,5), (7,5), (8,5)]);
            road4_1 = Vector{Tuple{Int64, Int64}}([(8,5), (8,4), (8,3)]);
            push!(roads, road1_1);
            push!(roads, road2_1);
            push!(roads, road3_1);
            push!(roads, road4_1);

            # Bridges

            # Ferries
            ferry1_1 = Vector{Tuple{Int64, Int64}}([(8,6), (8,5)]);
            ferry2_1 = Vector{Tuple{Int64, Int64}}([(1,6), (1,5)]);
            push!(ferries, ferry1_1);
            push!(ferries, ferry2_1);

        elseif period == 3
            # Roads
            road1_2 = Vector{Tuple{Int64, Int64}}([(8,10), (8,9), (8,8), (8,7), (8,6)]);
            road2_2 = Vector{Tuple{Int64, Int64}}([(1,6), (2,6), (3,6), (4,6), (5,6), (6,6), (7,6), (8,6)]);
            road3_2 = Vector{Tuple{Int64, Int64}}([(1,5), (2,5), (3,5), (4,5), (5,5), (6,5), (7,5), (8,5)]);
            road4_2 = Vector{Tuple{Int64, Int64}}([(8,5), (8,4), (8,3), (8,2), (8,1), (8,0)]);
            push!(roads, road1_2);
            push!(roads, road2_2);
            push!(roads, road3_2);
            push!(roads, road4_2);

            # Bridges
            #bridge1_2 = Vector{Tuple{Int64, Int64}}([(1,6), (1,5)]);
            #push!(bridges, bridge1_2);

            # Ferries
            ferry1_2 = Vector{Tuple{Int64, Int64}}([(8,6), (8,5)]);
            ferry2_2 = Vector{Tuple{Int64, Int64}}([(1,6), (1,5)]);
            push!(ferries, ferry1_2);
            push!(ferries, ferry2_2)

        elseif period == 4
            # Roads
            road1_3 = Vector{Tuple{Int64, Int64}}([(8,10), (8,9), (8,8), (8,7), (8,6)]);
            road2_3 = Vector{Tuple{Int64, Int64}}([(1,6), (2,6), (3,6), (4,6), (5,6), (6,6), (7,6), (8,6)]);
            road3_3 = Vector{Tuple{Int64, Int64}}([(1,5), (2,5), (3,5), (4,5), (5,5), (6,5), (7,5), (8,5)]);
            road4_3 = Vector{Tuple{Int64, Int64}}([(8,5), (8,4), (8,3), (8,2), (8,1), (8,0)]);
            push!(roads, road1_3);
            push!(roads, road2_3);
            push!(roads, road3_3);
            push!(roads, road4_3);

            # Bridges
            bridge1_3 = Vector{Tuple{Int64, Int64}}([(1,6), (1,5)]);
            push!(bridges, bridge1_3);

            # Ferries
            ferry1_3 = Vector{Tuple{Int64, Int64}}([(8,6), (8,5)]);
            push!(ferries, ferry1_3)

        elseif period == 5
            # Roads
            road1_4 = Vector{Tuple{Int64, Int64}}([(8,10), (8,9), (8,8), (8,7), (8,6)]);
            road2_4 = Vector{Tuple{Int64, Int64}}([(1,6), (2,6), (3,6), (4,6), (5,6), (6,6), (7,6), (8,6)]);
            road3_4 = Vector{Tuple{Int64, Int64}}([(1,5), (2,5), (3,5), (4,5), (5,5), (6,5), (7,5), (8,5)]);
            road4_4 = Vector{Tuple{Int64, Int64}}([(8,5), (8,4), (8,3), (8,2), (8,1), (8,0)]);
            push!(roads, road1_4);
            push!(roads, road2_4);
            push!(roads, road3_4);
            push!(roads, road4_4);

            # Bridges
            bridge1_4 = Vector{Tuple{Int64, Int64}}([(1,6), (1,5)]);
            bridge2_4 = Vector{Tuple{Int64, Int64}}([(8,6), (8,5)]);
            push!(bridges, bridge1_4);
            push!(bridges, bridge2_4);

            # Ferries

        end
    elseif network_id == 6
        # River borders
        border1 = Vector{Tuple{Int64, Int64}}([(5,10), (5,9), (5,8), (5,7), (5,6), (5,5), (5,4), (5,3), (5,2), (5,1), (5,0)]);
        border2 = Vector{Tuple{Int64, Int64}}([(6,10), (6,9), (6,8), (6,7), (6,6), (6,5), (6,4), (6,3), (6,2), (6,1), (6,0)]);
        border3 = Vector{Tuple{Int64, Int64}}([(0,5), (1,5), (2,5), (3,5), (4,5), (5,5)]);
        border4 = Vector{Tuple{Int64, Int64}}([(0,6), (1,6), (2,6), (3,6), (4,6), (5,6)]);
        push!(borders, border1);
        push!(borders, border2);
        push!(borders, border3);
        push!(borders, border4);

        if period == 1

            # Roads
            road1_0 = Vector{Tuple{Int64, Int64}}([(8,8), (8,7)]);
            road2_0 = Vector{Tuple{Int64, Int64}}([(2,8), (3,8), (4,8), (5,8)]);
            road3_0 = Vector{Tuple{Int64, Int64}}([(6,8), (7,8), (8,8)]);
            road4_0 = Vector{Tuple{Int64, Int64}}([(3,3), (4,3), (5,3)]);
            road5_0 = Vector{Tuple{Int64, Int64}}([(6,3), (7,4), (8,5)]);
            road6_0 = Vector{Tuple{Int64, Int64}}([(1,1), (2,2), (3,3)]);
            road7_0 = Vector{Tuple{Int64, Int64}}([(0,10), (1,9), (2,8)]);
            push!(roads, road1_0);
            push!(roads, road2_0);
            push!(roads, road3_0);
            push!(roads, road4_0);
            push!(roads, road5_0);
            push!(roads, road6_0);
            push!(roads, road7_0);

            # Bridges

            # Ferries
            ferry1_0 = Vector{Tuple{Int64, Int64}}([(5,8), (6,8)]);
            ferry2_0 = Vector{Tuple{Int64, Int64}}([(5,3), (6,3)]);
            ferry3_0 = Vector{Tuple{Int64, Int64}}([(3,5), (3,6)]);
            push!(ferries, ferry1_0);
            push!(ferries, ferry2_0);
            push!(ferries, ferry3_0);

        elseif period == 2

            # Roads
            road1_1 = Vector{Tuple{Int64, Int64}}([(8,8), (8,7)]);
            road2_1 = Vector{Tuple{Int64, Int64}}([(2,8), (3,8), (4,8), (5,8)]);
            road3_1 = Vector{Tuple{Int64, Int64}}([(6,8), (7,8), (8,8)]);
            road4_1 = Vector{Tuple{Int64, Int64}}([(3,3), (4,3), (5,3)]);
            road5_1 = Vector{Tuple{Int64, Int64}}([(6,3), (7,4), (8,5)]);
            road6_1 = Vector{Tuple{Int64, Int64}}([(1,1), (2,2), (3,3)]);
            road7_1 = Vector{Tuple{Int64, Int64}}([(0,10), (1,9), (2,8)]);
            push!(roads, road1_1);
            push!(roads, road2_1);
            push!(roads, road3_1);
            push!(roads, road4_1);
            push!(roads, road5_1);
            push!(roads, road6_1);
            push!(roads, road7_1);

            # Bridges
            bridge1_1 = Vector{Tuple{Int64, Int64}}([(5,8), (6,8)]);
            push!(bridges, bridge1_1);

            # Ferries
            ferry1_1 = Vector{Tuple{Int64, Int64}}([(5,3), (6,3)]);
            ferry2_1 = Vector{Tuple{Int64, Int64}}([(3,5), (3,6)]);
            push!(ferries, ferry1_1);
            push!(ferries, ferry2_1);

        elseif period == 3

            # Roads
            road1_2 = Vector{Tuple{Int64, Int64}}([(8,8), (8,7)]);
            road2_2 = Vector{Tuple{Int64, Int64}}([(2,8), (3,8), (4,8), (5,8)]);
            road3_2 = Vector{Tuple{Int64, Int64}}([(6,8), (7,8), (8,8)]);
            road4_2 = Vector{Tuple{Int64, Int64}}([(3,3), (4,3), (5,3)]);
            road5_2 = Vector{Tuple{Int64, Int64}}([(6,3), (7,4), (8,5)]);
            road6_2 = Vector{Tuple{Int64, Int64}}([(1,1), (2,2), (3,3)]);
            road7_2 = Vector{Tuple{Int64, Int64}}([(0,10), (1,9), (2,8)]);
            push!(roads, road1_2);
            push!(roads, road2_2);
            push!(roads, road3_2);
            push!(roads, road4_2);
            push!(roads, road5_2);
            push!(roads, road6_2);
            push!(roads, road7_2);

            # Bridges
            bridge1_2 = Vector{Tuple{Int64, Int64}}([(5,8), (6,8)]);
            bridge2_2 = Vector{Tuple{Int64, Int64}}([(3,5), (3,6)]);
            push!(bridges, bridge1_2);
            push!(bridges, bridge2_2);


            # Ferries
            ferry1_2 = Vector{Tuple{Int64, Int64}}([(5,3), (6,3)]);
            push!(ferries, ferry1_2);

        end
    elseif network_id == 7
        # Ferries
        ferry1 = Vector{Tuple{Int64, Int64}}([(5,0), (6,0)]);
        push!(ferries, ferry1);

        if period == 1
            border1 = Vector{Tuple{Int64, Int64}}([(5,2), (5,1), (5,0)]);
            border2 = Vector{Tuple{Int64, Int64}}([(6,2), (6,1), (6,0)]);
            push!(borders, border1);
            push!(borders, border2);

            road1_0 = Vector{Tuple{Int64, Int64}}([(5,2), (6,2)]);
            push!(roads, road1_0)

        elseif period == 2
            border1 = Vector{Tuple{Int64, Int64}}([(5,4), (5,3), (5,2), (5,1), (5,0)]);
            border2 = Vector{Tuple{Int64, Int64}}([(6,4), (6,3), (6,2), (6,1), (6,0)]);
            push!(borders, border1);
            push!(borders, border2);

            road1_1 = Vector{Tuple{Int64, Int64}}([(5,4), (6,4)]);
            push!(roads, road1_1)

        elseif period == 3
            border1 = Vector{Tuple{Int64, Int64}}([(5,6), (5,5), (5,4), (5,3), (5,2), (5,1), (5,0)]);
            border2 = Vector{Tuple{Int64, Int64}}([(6,6), (6,5), (6,4), (6,3), (6,2), (6,1), (6,0)]);
            push!(borders, border1);
            push!(borders, border2);

            road1_2 = Vector{Tuple{Int64, Int64}}([(5,6), (6,6)]);
            push!(roads, road1_2)

        elseif period == 4
            border1 = Vector{Tuple{Int64, Int64}}([(5,8), (5,7), (5,6), (5,5), (5,4), (5,3), (5,2), (5,1), (5,0)]);
            border2 = Vector{Tuple{Int64, Int64}}([(6,8), (6,7), (6,6), (6,5), (6,4), (6,3), (6,2), (6,1), (6,0)]);
            push!(borders, border1);
            push!(borders, border2);

            road1_3 = Vector{Tuple{Int64, Int64}}([(5,8), (6,8)]);
            push!(roads, road1_3)

        end

    else
        # River borders

        if period == 1

            # Roads

            # Bridges

            # Ferries

        elseif period == 2
            
            # Roads
            road1_1 = Vector{Tuple{Int64, Int64}}([(5,0), (5,1), (5,2), (5,3), (5,4), (5,5), (5,6), (5,7), (5,8), (5,9), (5,10)]);
            road2_1 = Vector{Tuple{Int64, Int64}}([(0,5), (1,5), (2,5), (3,5), (4,5), (5,5), (6,5), (7,5), (8,5), (9,5), (10,5)]);
            push!(roads, road1_1);
            push!(roads, road2_1);

            # Bridges

            # Ferries

        elseif period == 3

            # Roads
            road1_2 = Vector{Tuple{Int64, Int64}}([(5,0), (5,1), (5,2), (5,3), (5,4), (5,5), (5,6), (5,7), (5,8), (5,9), (5,10)]);
            road2_2 = Vector{Tuple{Int64, Int64}}([(0,5), (1,5), (2,5), (3,5), (4,5), (5,5), (6,5), (7,5), (8,5), (9,5), (10,5)]);
            push!(roads, road1_2);
            push!(roads, road2_2);

            # Bridges

            # Ferries

        end
    end
    return borders, roads, bridges, ferries #border1, border2, roads, bridges, ferries
end