class Grid {
    int noOfProducers = 0;
    int noOfConsumers = 0;
    
    synchronized void startProducing() {
        noOfProducers++;
        notify();
    }
    synchronized void stopProducing() {
        while(noOfConsumers == noOfProducers) {
            wait();
        }
        noOfProducers--;
    }
    synchronized void startConsuming() {
        while(noOfConsumers == noOfProducers) {
            wait();
        }
        noOfConsumers++;
    }
    synchronized void stopConsuming() {
        noOfConsumers--;
        notify();
    }
}