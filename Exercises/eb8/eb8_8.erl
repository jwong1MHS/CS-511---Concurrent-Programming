-module(eb8_8).
-compile(export_all).

start() ->
    spawn(?MODULE,loop,[]).

client(S) ->
    Ref = make_ref(),
    S!{self(),Ref,start},
    receive
        {Ref,Servlet,ok} ->
            client_loop(Servlet,0)
    end.

client_loop(Servlet,C) ->
    R=rand:uniform(100),
    Servlet!{guess,self(),R},
    receive
        {correct} ->
            io:format("~p guessed after ~p tries ~n",[self(),C]);
        {incorrect} ->
            client_loop(Servlet,C+1)
    end.

loop() ->
    receive
        {From,Ref,start} ->
            From!{Ref,ok},
            R = rand:uniform(100),
            S = spawn(?MODULE,loop_srvlet,[From,R]),
                From!{Ref,S,ok},
                loop()

    end.

loop_srvlet(Client,R) ->
    receive
        {guess,Client,N} when N==R ->
            Client!{correct};
        {guess,Client,N} when N/=R ->
            Client!{incorrect},
            loop_srvlet(Client,R)
    end.

%% [ spawn(gg,client,[S]) || _ <- lists:seq(1,100000)].