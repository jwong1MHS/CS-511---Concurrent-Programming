/*
Quiz 4A - 6 Oct 2021
Name: Jason Wong
Partner: Kevin Ha
 */
import java.util.concurrent.Semaphore;

Semaphore station0 = new Semaphore(1);
Semaphore station1 = new Semaphore(1);
Semaphore station2 = new Semaphore(1);
List<Semaphore> permToProcess = [new Semaphore(0), new Semaphore(0), new Semaphore(0)] // list of semaphores for machines
List<Semaphore> doneProcessing = [new Semaphore(0), new Semaphore(0), new Semaphore(0)] // list of semaphores for machines

100.times {
    Thread.start { // Car
        // Go to station 0
        station0.acquire();
        permToProcess[0].release();
        doneProcessing[0].acquire();
        station1.acquire();

        // Move to station 1
        station0.release();
        permToProcess[1].release();
        doneProcessing[1].acquire();
        station2.acquire();

        // Move to station 2
        station1.release();
        permToProcess[2].release();
        doneProcessing[2].acquire();
        station2.release();
      }
}

3.times { 
    int id = it; // iteration variable
    Thread.start { // Machine at station id
        while (true) {
            // Wait for car to arrive
	        permToProcess[id].acquire();
            // Process car when it has arrived
	        doneProcessing[id].release();
        }
    }
} 

return;
