import java.util.concurrent.Semaphore;

Semaphore A = new Semaphore(0);

Thread.start { // P
    5.times {
        print("A");
        print("B");
        print("C");
        print("D");
    }
}

Thread.start { // Q
    5.times {
        print("E");
        A.release();
        print("F");
        print("G");
    }
}

Thread.start { // Q
    5.times {
        A.acquire();
        print("H");
        print("I");
    }
}