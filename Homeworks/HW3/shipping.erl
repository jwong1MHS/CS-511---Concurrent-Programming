%% Name: Kevin Ha
%% Partner: Jason Wong
%% Section: A

-module(shipping).
-compile(export_all).
-include_lib("./shipping.hrl").

get_ship(Shipping_State, Ship_ID) ->
    %% Reminder: Internal representation of Records!
    case lists:keyfind(Ship_ID, 2, Shipping_State#shipping_state.ships) of
        false -> error;
        Tuple -> Tuple
    end.

get_container(Shipping_State, Container_ID) ->
    case lists:keyfind(Container_ID, 2, Shipping_State#shipping_state.containers) of
        false -> error;
        Tuple -> Tuple
    end.

get_port(Shipping_State, Port_ID) ->
    case lists:keyfind(Port_ID, 2, Shipping_State#shipping_state.ports) of
        false -> error;
        Tuple -> Tuple
    end.

get_occupied_docks(Shipping_State, Port_ID) ->
    [Dock || {Port, Dock, _ } <- Shipping_State#shipping_state.ship_locations, Port == Port_ID].

get_ship_location(Shipping_State, Ship_ID) ->
    case lists:keyfind(Ship_ID, 3, Shipping_State#shipping_state.ship_locations) of
        {Port_ID, Dock_ID, _ } -> {Port_ID, Dock_ID};
        false -> error
    end.

get_container_weight(Shipping_State, Container_IDs) ->
    case catch
        lists:foldl(fun(X, Acc) ->
            element(3, get_container(Shipping_State, X)) + Acc end, 
            0, Container_IDs) of

        {'EXIT', {badarg, _}} -> error;
        {'EXIT', {function_clause, _}} -> error;
        N -> N
    end. 

get_ship_weight(Shipping_State, Ship_ID) ->
    case maps:find(Ship_ID, Shipping_State#shipping_state.ship_inventory) of
        {ok, Value} -> get_container_weight(Shipping_State, Value);
        error -> error
    end.

load_ship(Shipping_State, Ship_ID, Container_IDs) ->
    %% God this is so gross...
    %% Remove io:formats..
    case get_ship(Shipping_State, Ship_ID) of
        {ship, _, _, Container_Cap} ->
            case get_ship_location(Shipping_State, Ship_ID) of 
                {Port_ID, _ } ->
                    case get_port(Shipping_State, Port_ID) of 
                        {port,_ ,_ ,_ ,_} ->
                            Port_Inv = maps:get(Port_ID, Shipping_State#shipping_state.port_inventory),
                            Ship_Inv = maps:get(Ship_ID, Shipping_State#shipping_state.ship_inventory),
                            case is_sublist(Port_Inv, Container_IDs) of
                                true ->
                                    case (length(Ship_Inv) + length(Container_IDs) =< Container_Cap) of
                                        true ->
                                            US = maps:update(Ship_ID, Ship_Inv ++ Container_IDs, Shipping_State#shipping_state.ship_inventory),
                                            % New = [X || X <- Port_Inv, lists:member(X, Container_IDs) == false],
                                            UP = maps:update(Port_ID, Port_Inv -- Container_IDs, Shipping_State#shipping_state.port_inventory),
                                            {ok, Shipping_State#shipping_state{ship_inventory = US, port_inventory = UP}};
                                        false ->
                                            %%io:format("Container reached cap~n"),
                                            error
                                    end; 
                                false ->
                                    %%io:format("Containers not at port~n"),
                                    error
                            end;
                        error ->
                            %%io:format("Not a valid port ID~n"),
                            error
                    end;
                error ->
                    error
            end;
        error ->
            %%io:format("Not a valid ship ID~n"),
            error
    end.

unload_ship_all(Shipping_State, Ship_ID) ->
    case get_ship(Shipping_State, Ship_ID) of
        {ship, _, _, Container_Cap} ->
            case get_ship_location(Shipping_State, Ship_ID) of 
                {Port_ID, _ } ->
                    case get_port(Shipping_State, Port_ID) of 
                        {port,_,_,_,_} ->
                            Port_Inv = maps:get(Port_ID, Shipping_State#shipping_state.port_inventory),
                            Ship_Inv = maps:get(Ship_ID, Shipping_State#shipping_state.ship_inventory),
                            case (length(Port_Inv) + length(Ship_Inv) =< Container_Cap) of
                                true -> 
                                    UP = maps:update(Port_ID, Port_Inv ++ Ship_Inv, Shipping_State#shipping_state.port_inventory),
                                    US = maps:update(Ship_ID, [], Shipping_State#shipping_state.ship_inventory),
                                    {ok, Shipping_State#shipping_state{ship_inventory = US, port_inventory = UP}};
                                false ->
                                    %io:format("Container capacity reached~n"),
                                    error
                            end;
                        error ->
                            %%io:format("Not a valid port ID~n"),
                            error
                    end;
                error ->
                    error
            end;
        error ->
            %%io:format("Not a valid ship ID~n"),
            error
    end.

unload_ship(Shipping_State, Ship_ID, Container_IDs) ->
    case get_ship(Shipping_State, Ship_ID) of
        {ship, _, _, _} ->
            case get_ship_location(Shipping_State, Ship_ID) of 
                {Port_ID, _ } ->
                    case get_port(Shipping_State, Port_ID) of 
                        {port,_ ,_ ,_ , Container_Cap} ->
                            Port_Inv = maps:get(Port_ID, Shipping_State#shipping_state.port_inventory),
                            Ship_Inv = maps:get(Ship_ID, Shipping_State#shipping_state.ship_inventory),
                            case is_sublist(Ship_Inv, Container_IDs) of
                                true ->
                                    case (length(Port_Inv) + length(Container_IDs) =< Container_Cap) of
                                        true ->
                                            % New = [X || X <- Ship_Inv, lists:member(X, Container_IDs) == false],
                                            US = maps:update(Ship_ID, Ship_Inv -- Container_IDs, Shipping_State#shipping_state.ship_inventory),
                                            UP = maps:update(Port_ID, Port_Inv ++ Container_IDs, Shipping_State#shipping_state.port_inventory),
                                            {ok, Shipping_State#shipping_state{ship_inventory = US, port_inventory = UP}};
                                        false ->
                                            %%io:format("Container reached cap~n"),
                                            error
                                    end; 
                                false ->
                                    %%io:format("Containers not on ship~n"),
                                    error
                            end;
                        error ->
                            %%io:format("Not a valid port ID~n"),
                            error
                    end;
                error ->
                    error
            end;
        error ->
            %%io:format("Not a valid ship ID~n"),
            error
    end.

set_sail(Shipping_State, Ship_ID, {Port_ID, Dock}) ->
    case get_ship(Shipping_State, Ship_ID) of 
        {ship, _, _, _ } ->
            case get_port(Shipping_State, Port_ID) of
                {port, _, _, Docks, _} ->
                    case lists:member(Dock, Docks) of
                        true ->
                            case lists:member(Dock, get_occupied_docks(Shipping_State, Port_ID)) of 
                                true ->
                                    %%io:format("Dock in use~n"),
                                    error;
                                false ->
                                    NT = lists:keyreplace(Ship_ID, 3, Shipping_State#shipping_state.ship_locations, {Port_ID, Dock, Ship_ID}),
                                    {ok, Shipping_State#shipping_state{ship_locations = NT}}
                            end;
                        false ->
                            %%io:format("Not a valid dock~n"),
                            error
                    end;
                error ->
                    %%io:format("Not a valid port ID~n"),
                    error
            end;
        error ->
            %%io:format("Not a valid ship ID~n"),
            error
    end.    



%% Determines whether all of the elements of Sub_List are also elements of Target_List
%% @returns true is all elements of Sub_List are members of Target_List; false otherwise
% is_sublist(Target_List, Sub_List) ->
%     lists:all(fun (Elem) -> lists:member(Elem, Target_List) end, Sub_List).
is_sublist([], []) -> true;
is_sublist(_, []) -> true;
is_sublist([], _) -> false;
is_sublist([H1 | T1], [H2 | T2]) ->
    case lists:member(H2, [H1 | T1]) of
        true ->
            is_sublist([H1 | T1] -- [H2], T2);
        false ->
            false
    end.
    


%% Prints out the current shipping state in a more friendly format
print_state(Shipping_State) ->
    io:format("--Ships--~n"),
    _ = print_ships(Shipping_State#shipping_state.ships, Shipping_State#shipping_state.ship_locations, Shipping_State#shipping_state.ship_inventory, Shipping_State#shipping_state.ports),
    io:format("--Ports--~n"),
    _ = print_ports(Shipping_State#shipping_state.ports, Shipping_State#shipping_state.port_inventory).


%% helper function for print_ships
get_port_helper([], _Port_ID) -> error;
get_port_helper([ Port = #port{id = Port_ID} | _ ], Port_ID) -> Port;
get_port_helper( [_ | Other_Ports ], Port_ID) -> get_port_helper(Other_Ports, Port_ID).


print_ships(Ships, Locations, Inventory, Ports) ->
    case Ships of
        [] ->
            ok;
        [Ship | Other_Ships] ->
            {Port_ID, Dock_ID, _} = lists:keyfind(Ship#ship.id, 3, Locations),
            Port = get_port_helper(Ports, Port_ID),
            {ok, Ship_Inventory} = maps:find(Ship#ship.id, Inventory),
            io:format("Name: ~s(#~w)    Location: Port ~s, Dock ~s    Inventory: ~w~n", [Ship#ship.name, Ship#ship.id, Port#port.name, Dock_ID, Ship_Inventory]),
            print_ships(Other_Ships, Locations, Inventory, Ports)
    end.

print_containers(Containers) ->
    io:format("~w~n", [Containers]).

print_ports(Ports, Inventory) ->
    case Ports of
        [] ->
            ok;
        [Port | Other_Ports] ->
            {ok, Port_Inventory} = maps:find(Port#port.id, Inventory),
            io:format("Name: ~s(#~w)    Docks: ~w    Inventory: ~w~n", [Port#port.name, Port#port.id, Port#port.docks, Port_Inventory]),
            print_ports(Other_Ports, Inventory)
    end.
%% This functions sets up an initial state for this shipping simulation. You can add, remove, or modidfy any of this content. This is provided to you to save some time.
%% @returns {ok, shipping_state} where shipping_state is a shipping_state record with all the initial content.
shipco() ->
    Ships = [#ship{id=1,name="Santa Maria",container_cap=20},
              #ship{id=2,name="Nina",container_cap=20},
              #ship{id=3,name="Pinta",container_cap=20},
              #ship{id=4,name="SS Minnow",container_cap=20},
              #ship{id=5,name="Sir Leaks-A-Lot",container_cap=20}
             ],
    Containers = [
                  #container{id=1,weight=200},
                  #container{id=2,weight=215},
                  #container{id=3,weight=131},
                  #container{id=4,weight=62},
                  #container{id=5,weight=112},
                  #container{id=6,weight=217},
                  #container{id=7,weight=61},
                  #container{id=8,weight=99},
                  #container{id=9,weight=82},
                  #container{id=10,weight=185},
                  #container{id=11,weight=282},
                  #container{id=12,weight=312},
                  #container{id=13,weight=283},
                  #container{id=14,weight=331},
                  #container{id=15,weight=136},
                  #container{id=16,weight=200},
                  #container{id=17,weight=215},
                  #container{id=18,weight=131},
                  #container{id=19,weight=62},
                  #container{id=20,weight=112},
                  #container{id=21,weight=217},
                  #container{id=22,weight=61},
                  #container{id=23,weight=99},
                  #container{id=24,weight=82},
                  #container{id=25,weight=185},
                  #container{id=26,weight=282},
                  #container{id=27,weight=312},
                  #container{id=28,weight=283},
                  #container{id=29,weight=331},
                  #container{id=30,weight=136}
                 ],
    Ports = [
             #port{
                id=1,
                name="New York",
                docks=['A','B','C','D'],
                container_cap=200
               },
             #port{
                id=2,
                name="San Francisco",
                docks=['A','B','C','D'],
                container_cap=200
               },
             #port{
                id=3,
                name="Miami",
                docks=['A','B','C','D'],
                container_cap=200
               }
            ],
    %% {port, dock, ship}
    Locations = [
                 {1,'B',1},
                 {1, 'A', 3},
                 {3, 'C', 2},
                 {2, 'D', 4},
                 {2, 'B', 5}
                ],
    Ship_Inventory = #{
      1=>[14,15,9,2,6],
      2=>[1,3,4,13],
      3=>[],
      4=>[2,8,11,7],
      5=>[5,10,12]},
    Port_Inventory = #{
      1=>[16,17,18,19,20],
      2=>[21,22,23,24,25],
      3=>[26,27,28,29,30]
     },
    #shipping_state{ships = Ships, containers = Containers, ports = Ports, ship_locations = Locations, ship_inventory = Ship_Inventory, port_inventory = Port_Inventory}.
