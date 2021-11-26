bool wantp = false, wantq = false;
byte turn = 1;

active proctype P() {
    do
    ::  wantp = true;
        do
        :: !wantq -> break;
        :: else ->
            if
            :: (turn == 1) /* no statements , leaves if */
            :: (turn == 2) ->
                wantp = false;
                (turn == 1);
                wantp = true
            fi
        od;
        wantp = false;
        turn = 2
    od
}