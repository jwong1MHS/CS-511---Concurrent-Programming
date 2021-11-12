import java.util.concurrent.locks.*

class TrainStation {
    boolean nt = false;
    boolean st = false;
    final Lock lock = new ReentrantLock();
    final Condition northTrack = lock.newCondition();
    final Condition southTrack = lock.newCondition();
    final Condition bothTracks = lock.newCondition();

    void acquireNorthTrackP() {
        lock.lock();
        try {
            while (nt) {
                northTrack.await();
            }
            nt=true;
        } finally {
            lock.unlock();
        }
    }

    void releaseNorthTrackP() {
        lock.lock();
        try {
            nt=false;
            northTrack.signal();  
            bothTracks.signal();  
        } finally {
            lock.unlock();
        }
    }

    void acquireSouthTrackP() {
        lock.lock();
        try {
            while (st) {
                southTrack.await();
            }
            st=true;
        } finally {
            lock.unlock();
        }
    }

    void releaseSouthTrackP() {
        lock.lock();
        try {
            st=false;
            southTrack.signal();  
            bothTracks.signal();  
        } finally {
            lock.unlock();
        }
    }

    void acquireTrackF() {
        lock.lock();
        try {
            while (nt || st) {
                bothTracks.await();
            }
            nt=true;
            st=true;
        } finally {
            lock.unlock();
        }
    }

    void releaseTrackF() {
        lock.lock();
        try {
            nt=false;
            st=false;
            northTrack.signal();
            southTrack.signal();    
        } finally {
            lock.unlock();
        }
    }
}

TrainStation s = new TrainStation();

10.times {
    int id = it;
    Thread.start { // Freight Train going in any direction
        s.acquireTrackF();
        print "FT ${id} "
        s.releaseTrackF();
    }
}

100.times {
    int id = it;
    Thread.start { // Passenger Train going North
        s.acquireNorthTrackP();
        print "NPT ${id} "
        s.releaseNorthTrackP();
    }
}

100.times {
    int id = it;
    Thread.start { // Passenger Train going South
        s.acquireSouthTrackP();
        print "SPT ${id} "
        s.releaseSouthTrackP();
    }
}