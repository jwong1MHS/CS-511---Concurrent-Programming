#define N 3 /* Number of Washing Machines */
#define C 10 /* Number of Washing Machines */

byte permToProcess[N]
byte doneProcessing[N]
byte station0 = 1
byte station1 = 1
byte station2 = 1


inline acquire(s) {
    atomic {
        s>0 -> s--
    }
}

inline release(s) {
    s++
}

proctype Car() {
    /* complete */
    // Go to station 0
    acquire(station0);
    release(permToProcess[0]);
    release(doneProcessing[0]);
    acquire(station1);

    // Move to station 1
    release(station0);
    release(permToProcess[1]);
    acquire(doneProcessing[1]);
    acquire(station2);

    // Move to station 2
    release(station1);
    release(permToProcess[2]);
    release(doneProcessing[2]);
    release(station2);
}

proctype Machine(int i) {
    /* complete */

}

init {
    byte i;

    for (i:0..(N-1)) {
        permToProcess[i]=0;
        doneProcessing[i]=0;
    }

    atomic {
        for (i:1..(C)) {
            run Car();
        }
        for (i:0..(N-1)) {
            run Machine(i);
        }
    }
}