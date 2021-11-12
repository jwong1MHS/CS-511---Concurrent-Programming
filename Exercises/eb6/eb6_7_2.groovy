class Pizza {
    int sp = 0;
    int lp = 0;
    final Lock lock = new ReentrantLock();
    final Condition smallPizza = lock.newCondition();
    final Condition bothPizzas = lock.newCondition();
    final Condition counter = lock.newCondition();

    void produceLargePizza() {
        lock.lock();
        try {
            while (lp + sp == 20) {
                counter.await();
            }
            lp++;
            bothPizzas.signal();
        } finally {
            lock.unlock();
        }
    }

    void produceSmallPizza() {
        lock.lock();
        try {
            while (lp + sp == 20) {
                counter.await();
            }
            sp++;
            smallPizza.signal();
            bothPizzas.signal();
        } finally {
            lock.unlock();
        }
    }

    void consumeLargePizza() {
        lock.lock();
        try {
            while (lp == 0 || sp < 2) {
                bothPizzas.await();
            }
            if (lp > 0) {
                lp--;
            } else {
                sp-=2;
            }
            counter.signalAll();
        } finally {
            lock.unlock();
        }
    }

    void consumeSmallPizza() {
        lock.lock();
        try {
            while (sp <= 0) {
                smallPizza.await();
            }
            counter.signal();
        } finally {
            lock.unlock();
        }
    }
}