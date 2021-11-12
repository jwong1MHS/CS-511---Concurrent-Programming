import java.util.concurrent.Semaphore;

Semaphore A = new Semaphore(0);
Semaphore B = new Semaphore(0);

Thread.start { // P
    print("A");
    A.release();
    print("B");
    B.acquire();
    print("C");
}

Thread.start { // Q
    print("E");
    A.acquire();
    print("F");
    B.release();
    print("G");
}