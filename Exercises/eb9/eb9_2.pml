bool wantP=false;
bool wantQ=false;

active proctype P() {
    do
        :: wantP=true;
        do
            :: !wantQ -> break;
            :: else
        od;
// progress1:
        printf("P went in \n");
        wantP=false
    od
}

active proctype Q() {
    do
        :: wantQ=true;
        do
            :: !wantP -> break;
            :: else
        od;
// progress2:
        printf("Q went in \n");
        wantQ=false
    od
}

init {
    atomic {
        run P();
        run Q()
    }
}