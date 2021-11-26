byte last = 1;
bool wantP = false;
bool wantQ = false;

active proctype P() {
    do ::
        wantP = true;
        last = 1;
        do
        :: wantQ == false -> break;
        :: last == 2 -> break;
        :: else
        od;
        wantP = false
    od
}
active proctype Q() {
    do ::
        wantQ = true;
        last = 2;
        do
        :: wantP == false -> break;
        :: last == 1 -> break;
        :: else
        od;
        wantQ = false
    od
}