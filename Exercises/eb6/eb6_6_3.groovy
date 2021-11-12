class Grid {
    int noOfProducers = 0;
    int noOfConsumers = 0;
    int N = 20;
    
    void startProducing() {
        while (noOfProducers >= N) {
            wait();
        }
        noOfProducers++;
        notifyAll();
    }
    void stopProducing() {
        while(noOfConsumers <= noOfProducers) {
            wait();
        }
        noOfProducers--;
        notifyAll();
    }
    void startConsuming() {
        while(noOfConsumers >= noOfProducers) {
            wait();
        }
        noOfConsumers++;
    }
    void stopConsuming() {
        noOfConsumers--;
        notifyAll();
    }
}