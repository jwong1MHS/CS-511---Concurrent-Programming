import java.util.concurrent.Semaphore;

Semaphore A = new Semaphore(1);
Semaphore B = new Semaphore(1);

Thread.start { // P
    5.times {
        A.acquire();
        print("A");
        B.release();
    }
}

Thread.start { // Q
    5.times {
        B.acquire();
        print("B");
        A.release();
    }
}