import java.util.concurrent.Semaphore;

// Declare semaphore here
mice = 0;
felines = 0;
Semaphore felinesMutex = new Semaphore(1);
Semaphore miceMutex = new Semaphore(1);
Semaphore mutex = new Semaphore(1,true);
Semaphore feedingLot = new Semaphore(2);

20.times {    // Felines
    // access feeding lot
    mutex.acquire();
    felinesMutex.acquire();
    if (felines==0) {
        miceMutex.acquire();
    }
    felines++;
    felinesMutex.release();
    mutex.release();
    
    feedingLot.acquire();
    // eat
    feedlingLot.release();
    
    // exit feeding lot
    felinesMutex.acquire();
    if (felines==1) {
        miceMutex.release();
    }
    felines--;
    felinesMutex.release();
}

20.times { // Mice
    // access feeding lot
    mutex.acquire();
    miceMutex.acquire();
    if (mice==0) {
        felinesMutex.acquire();
    }
    mice++;
    miceMutex.release();
    mutex.release();
    
    feedingLot.acquire();
    // eat
    feedingLot.release();
    
    // exit feeding lot
    miceMutex.acquire();
    if (mice==1) {
        felinesMutex.release();
    }
    mice--;
    miceMutex.release();
}