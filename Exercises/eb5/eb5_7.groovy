import java.util.concurrent.Semaphore;

// Declare semaphores here
Semaphore useCrossing = new Semaphore(1);
Semaphore endpointMutexList = [new Semaphore(1, true), new Semaphore(1, true)]; // Strong sem.
noOfCarsCrossing = [0,0]; // list of ints
r = new Random();

100.times {
    int myEndpoint = r.nextInt(2); // pick a random direction
    Thread.start { // Car
        // entry protocol
        endpointMutexList[myEndpoint].acquire();
        if (noOfCarsCrossing[myEndpoint] == 0) {
            useCrossing.acquire();
        }
        noOfCarsCrossing[myEndpoint]++;
        endpointMutexList[myEndpoint].release();

        // cross crossing
        println ("car $it crossing in direction "+myEndpoint + " current totals "+noOfCarsCrossing);

        // exit protocol
        endpointMutexList[myEndpoint].acquire();
        noOfCarsCrossing[myEndpoint]--;
        if (noOfCarsCrossing[myEndpoint] == 0) {
            useCrossing.release();
        }
        endpointMutexList[myEndpoint].release();
    }
}