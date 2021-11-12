import java.util.concurrent.Semaphore;

// Declare all necessary semaphores here

final int N = 20; // Ferry capacity
permToBoard = [ new Semaphore(0), new Semaphore(0)];
// List with two semaphores
// other semaphores will be necessary!
permToContinue = new Semaphore(0);
permToDisembark = new Semaphore(0);

Thread.start {
    int coast=0;
    while (true) {

        // allow passengers on
        N.times { permToBoard[coast].release() };
        N.times { permToContinue.acquire() };
        // move to opposite coast
        coast = 1-coast;
        // wait for all passengers to get off
        N.times { permToDisembark.release() };
        N.times { permToContinue.acquire() };

    }
}

100.times {
    int my_coast = (new Random()).nextInt(1);
    Thread.start { // Passengers
        // get on
        permToBoard[my_coast].acquire();
        permToContinue.release();
        // get off at opposite coast
        permToDisembark.acquire();
        permToContinue.release();
    }
}

return;