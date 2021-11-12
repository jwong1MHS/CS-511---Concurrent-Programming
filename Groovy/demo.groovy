int x = 0

def P = Thread.start { // P
    10.times {
        x = x + 1
    }
}

def Q = Thread.start { // Q
    10.times {
        x = x + 1
    }
}

P.join()
Q.join()

println(x)