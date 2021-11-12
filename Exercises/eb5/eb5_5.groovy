import java.util.concurrent.Semaphore;

Semaphore station0 = new Semaphore(1);
Semaphore station1 = new Semaphore(1);
Semaphore station2 = new Semaphore(1);
permToProcessCar = [new Semaphore(0), new Semaphore(0), new Semaphore(0)] // list of semaphores for machines
done = [new Semaphore(0), new Semaphore(0), new Semaphore(0)]

100.times {
    Thread.start { // Car
        // Go to station 0
        station0.acquire();
        permToProcessCar[0].release();
        // car is being processed in station 0
        done[0].acquire();

        // Move to station 1
        station1.acquire();
        station0.release();
        permToProcessCar[1].release();
        // car is being processed in station 1
        done[1].acquire();

        // Move to station 2
        station2.acquire();
        station1.release();
        permToProcessCar[1].release();
        // car is being processed in station 2
        done[1].acquire();

        station2.release();
    }
}

3.times {
    int id = it; // iteration variable
    Thread.start { // Machine at station id
        while (true) {
            // Wait for car to arrive
            permToProcessCar[id].acquire();
            // Process car when it arrived
            done[id].release();
        }
    }
}

return;