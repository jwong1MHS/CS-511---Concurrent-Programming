byte ticket = 0;
byte mutex = 1;

byte nJets = 0;
byte nPats = 0;

inline acquire(sem) {
    atomic {
        sem>0 -> sem--
    }
}

inline release(sem) {
    sem++
}

active [20] proctype Jets() {
    acquire(mutex);
    acquire(ticket);
    acquire(ticket);
    release(mutex);
    nJets++;
    printf("J: %d, P: %d\n", nJets, nPats);
    assert (2*nJets <= nPats);
}

active [20] proctype Patriots() {
    nPats++;
    release(ticket);
    printf("J: %d, P: %d\n", nJets, nPats);
}