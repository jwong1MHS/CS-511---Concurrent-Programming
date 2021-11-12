import java.util.concurrent.Semaphore;

Semaphore A = new Semaphore(0);

Thread.start { // A
    print("opA");
    A.release();
}

Thread.start { // B
    print("opB");
    A.release();
}

Thread.start { // Q
    A.acquire();
    A.acquire();
    print("opC");
}