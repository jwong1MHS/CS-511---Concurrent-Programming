import java.util.concurrent.Semaphore;

Semaphore A = new Semaphore(1);

int y = 0, z = 0;

Thread.start { // P
    A.acquire();
    int x;
    x = y + z;
    A.release();
    print(x);
}

Thread.start { // Q
    A.acquire();
    y = 1;
    z = 2;
    A.release();
}