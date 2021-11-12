import java.util.concurrent.Semaphore;


Semaphore permToLoad = new Semaphore(0);
Semaphore doneLoading = new Semaphore(0);
// Additional semaphores
tracks = [new Semaphore(1,true), new Semaphore(1,true)]

100.times {
    int dir = (new Random()).nextInt(2);
    Thread.start { // PassengerTrain travelling in direction dir
        // complete
        tracks[myEndpoint].acquire();
        // passengers load in
        tracks[myEndpoint].release();
    }
}

100.times {
    int dir = (new Random()).nextInt(2);
    Thread.start { // Freight Train travelling in direction dir
        // complete
        tracks[0].acquire();
        tracks[1].acquire();
        permToLoad.release();
        doneLoading.acquire();
        tracks[0].release();
        tracks[1].release();
    }
}

Thread.start { // LoadingMachine
    while (true) {
        permToLoad.acquire();
        // load freight train
        doneLoading.release();
    }
}