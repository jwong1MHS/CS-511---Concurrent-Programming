class TWS {
    private int state=1;

    synchronized void first() {
        while (state!=1) {
            wait();
        }
        state=2;
        notifyAll();
    }
    synchronized void second() {
        while (state!=2) {
            wait();
        }
        state=3;
        notifyAll();
    }
    synchronized void third() {
        while (state!=3) {
            wait();
        }
        state=1;
        notifyAll();
    }
}