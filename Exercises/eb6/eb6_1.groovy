class Bar {
    // your code
    int p=0;
    int jc=0;
    int pc=0;

    synchronized void patriots() {
        p++;
        notify();
        pc++;
        printState();
    }

    synchronized void jets() {
        while (p<2) {
            wait();
        }
        p=p-2;
        jc++;
        printState();
    }

    synchronized void printState() {
        println "--> jf "+jc+" pf "+pc+"
        -- "jc/pc
    }

}

Bar b = new Bar();
50.times {
    Thread.start {//jets
        b.jets();
    }
}

100.times {
    Thread.start {//jets
        b.patriots();
    }
}