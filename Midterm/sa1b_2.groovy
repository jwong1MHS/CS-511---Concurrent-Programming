import java.util.concurrent.lock.*

class TrainStation {
    boolean freighttrain = false;
    boolean isLoaded = false;
    final Lock lock = new ReentrantLock();
    final Condition tracks = lock.newCondition();
    final Condition loading = lock.newCOndition();

    void acquireTrackF() {
        lock.lock();
        try {
            freighttrain = true;
            loading.signal();
        } finaly {
            lock.unlock();
        }
    }

    void releaseTrackF() {
        lock.lock();
        try {
            while(!isLoaded) {
                tracks.await();
            }
            freighttrain = false;
            isLoaded = false;
        } finaly {
            lock.unlock();
        }
    }

    void load() {
        lock.lock();
        try {
            while(!freighttrain || isLoaded) {
                loading.await();
            }
        } finaly {
            lock.unlock();
        }
    }

    void done() {
        lock.lock();
        try {
            isLoaded = True;
            tracks.signal();
        } finaly {
            lock.unlock();
        }
    }
}