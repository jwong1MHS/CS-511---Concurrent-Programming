byte c=0;

byte n = 0;
proctype P() {
    byte temp , i;
    for (i:1..10) {
        temp = n;
        n=temp+1
    }
}

proctype Q() {
    byte i=0;
    byte tmp=0;
    do
        :: i<10 ->
            tmp=c;
            c=tmp+1
            i++;
        :: else ->
            break
    od
}

init {
    atomic {
        run P();
        run Q();
    }
    (_nr_pr==1);
    printf("The value is %d\n", n);
    assert (c>2);
}