monitor RW {
    int readers = 0;
    int writers = 0;
    condition OKtoRead, OKtoWrite;

    public void StartRead() {
        while (writers != 0 or not OKtoWrite.empty()) {
            OKtoRead.wait();
        }
        readers = readers + 1;
        OKtoRead.signal();
    }

    public void EndRead() {
        readers = readers - 1;
        if (readers==0) {
            OKtoWrite.signal();
        }
    }

    public void StartWrite() {
        while (writers != 0 or readers != 0) {
            OKtoWrite.wait();
        }
        writers = writers + 1;
    }

    public void EndWrite() {
        writers = writers - 1;
        if (OKtoRead.empty()) {
            OKtoWrite.signal();
        } else {
            OKtoRead.signal();  
        }
    }
}