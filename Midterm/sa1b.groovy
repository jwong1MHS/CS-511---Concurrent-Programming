import java.util.concurrent.semaphore;

Semaphore atm = new Semaphore(7, true);

Thread.start { // ATM
    atm.acquire();
    atm.release();
}

Thread.start { // Employees
    
}