import java.util.concurrent.Semaphore;

// Semaphores declaration here:
int magazines = 20;
Semaphore bedPerm = new Semaphore(4, True);
Semaphore magazinePerm = new Semaphore(magazines);
Semaphore mutex = new Semaphore(1);

100.times {
    int id = it;
    Thread.start { // Donor
        boolean hasBed = false;

        Thread.start {
            // Role: Competing for beds
            bedPerm.acquire();
            hasBed = true;
            // transfusion
            bedPerm.release();
        }
        Thread.start {
            // Role: Competing for magazines    
            while (!hasBed) {
                magazinePerm.acquire();
                // read magazine
                magazinePerm.release();
            }  
        }
    }
}