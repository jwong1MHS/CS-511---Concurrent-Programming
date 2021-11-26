byte last = 1;
byte critical = 0;
bool wantP = false;
bool wantQ = false;

active proctype P() {
    do ::
        last = 1;
        wantP = true;
        do
        :: wantQ == false -> break;
        :: last == 2 -> break;
        :: else
        od;
        critical++;
        assert (critical == 1);
        critical--;
        wantP = false
    od
}
active proctype Q() {
    do ::
        last = 2;
        wantQ = true;
        do
        :: wantP == false -> break;
        :: last == 1 -> break;
        :: else
        od;
        critical++;
        assert (critical == 1);
        critical--;
        wantQ=false
    od
}