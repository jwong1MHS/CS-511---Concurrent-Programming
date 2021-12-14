#define N	4
#define L	10

byte nr_leaders;

/* ltl p1 { your_ltl_formula_1_here }; */
/* ltl p2 { your_ltl_formula_2_here }; */
/* ltl p3 { your_ltl_formula_3_here }; */

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
      :: inp ? winner(nr) -> 
	 /* complete here */
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
