bool wantP = false; bool wantQ = false;

active proctype P() {
    do ::
        wantP = true;
        do
        :: wantQ== false -> break
        :: else
        od;
progress1:
        wantP = false
    od
}
active proctype Q() {
    do ::
        wantQ = true;
        do
        :: wantP ==false -> break
        :: else
        od;
progress2:
        wantQ = false
    od
}