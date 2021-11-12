import java.util.concurrent.Semaphore;

Semaphore A = new Semaphore(0);
Semaphore B = new Semaphore(0);

Thread.start { // P
    A.acquire();
    print("A");
    print("C");
    B.release();
}

Thread.start { // Q
    print("R")
    A.release();
    B.acquire();
    print("E");
    print("S");
}