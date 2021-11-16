active proctype P() {
    byte N = 10;
    byte sum = 0;
    byte i;
    for (i : 1 .. N) {
        sum = sum +i;
    }
    printf("The sum of the first %d numbers = %d\n", N, sum);
}