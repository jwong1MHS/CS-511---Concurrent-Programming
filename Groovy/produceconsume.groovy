import java.util.concurrent.locks.*

class PC {
    Lock lock = new ReentrantLock();
    Condition full = lock.newCondition();
    Condition empty = lock.newCondition();

    Object buffer;

    synchronized void produce(Object o) {
        lock.lock();
        try {
            while (buffer!=null) {
                empty.await();
            }
            buffer=o;
            full.signal();
        } finally {
            lock.unlock();
        }
    }

    synchronized Object consume() {
        while (buffer==null) {
            full.await();
        }
        Object temp = buffer;
        buffer = null;
        empty.signal();
        return temp
    }
}

PC b = new PC();

10.times { // producers
    int id = it;
    Thread.start {
        b.produce((new Random()).nextInt(33))
        println "$id produced"
    }
}