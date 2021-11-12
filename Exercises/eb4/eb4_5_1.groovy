import java.util.concurrent.Semaphore;

Semaphore A = new Semaphore(0);

Thread.start { // P
    5.times {
        print("A");
        A.release();
        print("B");
        print("C");
        print("D");
    }
}

Thread.start { // Q
    5.times {
        print("E");
        A.acquire();
        print("F");
        print("G");
    }
}

Thread.start { // Q
    5.times {
        print("H");
        print("I");
    }
}