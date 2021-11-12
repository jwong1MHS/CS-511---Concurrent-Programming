class Barrier {
    // complete
    final int N=3;
    int c=0;

    synchronized void waitAtBarrier() {
        if (c<N) {
            c++;
            while(c<N) {
                wait();
            }
            notify(); // cascading signalling
        }
    }
}

Barrier b = new Barrier();

Thread.start { //T1
    print('a');
    b.waitAtBarrier();
    print(1);
}

Thread.start { //T2
    print('b');
    b.waitAtBarrier();
    print(2);
}

Thread.start { //T3
    print('c');
    b.waitAtBarrier();
    print(3);
}