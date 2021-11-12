import java.util.concurrent.Semaphore;

Semaphore A = new Semaphore(0);
Semaphore B = new Semaphore(0);
Semaphore C = new Semaphore(0);

Thread.start { // P
    print("R");
    A.release();
    C.acquire();
    print("OK");
}

Thread.start { // Q
    A.acquire();
    print("I");
    B.release();
    C.acquire();
    print("OK");
}

Thread.start { // R
    B.acquire();
    print("O");
    C.release();
    C.release();
    print("OK");
}