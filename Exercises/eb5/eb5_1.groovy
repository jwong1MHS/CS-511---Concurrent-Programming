import java.util.concurrent.Semaphore;

Semaphore ticket = new Semaphore(0);
Semaphore mutex = new Semaphore(1);
boolean itGotLate = false;

Thread.start { // Jets
    mutex.acquire();
    if (!itGotLate) {
        ticket.acquire();
        ticket.acquire();
    }
    mutex.release();
}

Thread.start { // Patriots
    ticket.release();
}

def itGotLate() {
    itGotLate = true;
    ticket.release();
    ticket.release();
}

return