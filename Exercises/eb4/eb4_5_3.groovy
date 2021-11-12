import java.util.concurrent.Semaphore;

Semaphore A = new Semaphore(0);

Thread.start { // P
    5.times {
        print("A");
        print("B");
        A.acquire();
        print("C");
        print("D");
    }
}

Thread.start { // Q
    5.times {
        print("E");
        print("F");
        print("G");
        A.release();
    }
}

Thread.start { // Q
    5.times {
        print("H");
        print("I");
    }
}