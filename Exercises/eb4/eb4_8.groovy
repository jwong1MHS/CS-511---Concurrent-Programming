import java.util.concurrent.Semaphore;

Semaphore A = new Semaphore(0);
Semaphore B = new Semaphore(1);

int n2=0;
int n=50;

Thread.start {
    while (n > 0) {
        A.acquire();
        n = n-1;
        B.release();
    }
    A.acquire();
    print(n2);
}

Thread.start {
    while (true) {
        B.acquire();
        n2 = n2 + 2*n + 1;
        A.release();
    }
}