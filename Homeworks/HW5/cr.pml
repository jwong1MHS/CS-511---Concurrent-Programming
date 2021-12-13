// Jason Wong
// I pledge my honor that I have abided by the Stevens Honor System.

#define N	4
#define L	10

byte nr_leaders;

// ltl p1 { <>(nr_leaders > 0) };
// ltl p2 { <>([](nr_leaders == 1)) };
ltl p3 { [](nr_leaders == 0 || nr_leaders == 1) };

mtype = { one, winner };
chan q[N] = [L] of {mtype, byte};

proctype nnode (chan inp, out; byte mynumber)
{
  byte nr, neighbor;

  xr inp; /* channel assertion: exclusive recv access to channel in */
  xs out; /* channel assertion: exclusive send access to channel out */
  
  printf("NNode: %d\n", mynumber);
  
  out ! one(mynumber);
  
  end: do
      :: inp ? one(nr) ->
	        /* complete here */
          if
            :: nr == mynumber ->
                // printf("NNode leader: %d\n", mynumber);
                nr_leaders = nr_leaders + 1;
                out ! winner(nr)
            :: nr > mynumber -> out ! one(nr)
            :: nr < mynumber -> skip
          fi
      :: inp ? winner(nr) -> 
	        /* complete here */
          if
            :: nr != mynumber ->
                // printf("NNode %d confirms NNode %d is the leader\n", mynumber, nr);
                out ! winner(nr)
            :: else -> skip
          fi;
	 break;
  od
  do /* dummy loop to ensure non-termination */
    :: true -> skip
  od
}

init {
  byte Ini[6];
  byte I;
  
  for (I : 1 .. N) {
     if
       :: Ini[0] == 0 && N >= 1 -> Ini[0] = I 
       :: Ini[1] == 0 && N >= 2 -> Ini[1] = I 
       :: Ini[2] == 0 && N >= 3 -> Ini[2] = I 
       :: Ini[3] == 0 && N >= 4 -> Ini[3] = I 
       :: Ini[4] == 0 && N >= 5 -> Ini[4] = I 
       :: Ini[5] == 0 && N >= 6 -> Ini[5] = I 
    fi;
  }		
  atomic {
    int proc;
    for (proc : 1 .. N ) {
       run nnode (q[proc-1],q[proc%N], Ini[proc-1]);
       printf("Initializing %d %d %d \n", q[proc-1],q[proc%N], Ini[proc-1])
    }
  }
	
}
