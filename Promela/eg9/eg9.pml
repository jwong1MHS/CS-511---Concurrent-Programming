bool wantP = false, wantQ = false;
byte critical = 0;


active proctype P() {
    do ::
        printf("Non critical section P\n");
        wantP = true;
        critical++;
        assert (critical == 1);
        critical--;
        printf("Critical section P\n");
        wantP = false
    od
}

active proctype Q() {
    do ::
        printf("Non critical section Q\n");
        wantQ = true;
        critical++;
        assert (critical == 1);
        critical--;
        printf("Critical section Q\n");
        wantQ = false
    od
}