import java.util.concurrent.semaphore;

// declare semaphore
Semaphore cleanRags = new Semaphore(10);
Semaphore dirtyRags = new Semaphore(90);

100.times {
    Thread.start { // WORKER
        cleanRags.acquire();
        // work
        dirtyRags.release();
    }
}
20.times {
    Thread.start{ // Washer
        while(true) {
            dirtyRags.acquire();
            // clean
            cleanRags.release();
        }
    }
}