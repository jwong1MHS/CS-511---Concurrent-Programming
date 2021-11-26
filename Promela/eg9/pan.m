#define rand	pan_rand
#define pthread_equal(a,b)	((a)==(b))
#if defined(HAS_CODE) && defined(VERBOSE)
	#ifdef BFS_PAR
		bfs_printf("Pr: %d Tr: %d\n", II, t->forw);
	#else
		cpu_printf("Pr: %d Tr: %d\n", II, t->forw);
	#endif
#endif
	switch (t->forw) {
	default: Uerror("bad forward move");
	case 0:	/* if without executable clauses */
		continue;
	case 1: /* generic 'goto' or 'skip' */
		IfNotBlocked
		_m = 3; goto P999;
	case 2: /* generic 'else' */
		IfNotBlocked
		if (trpt->o_pm&1) continue;
		_m = 3; goto P999;

		 /* PROC Q */
	case 3: // STATE 1 - eg9.pml:19 - [printf('Non critical section Q\\n')] (0:0:0 - 1)
		IfNotBlocked
		reached[1][1] = 1;
		Printf("Non critical section Q\n");
		_m = 3; goto P999; /* 0 */
	case 4: // STATE 2 - eg9.pml:20 - [wantQ = 1] (0:0:1 - 1)
		IfNotBlocked
		reached[1][2] = 1;
		(trpt+1)->bup.oval = ((int)wantQ);
		wantQ = 1;
#ifdef VAR_RANGES
		logval("wantQ", ((int)wantQ));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 5: // STATE 3 - eg9.pml:21 - [critical = (critical+1)] (0:0:1 - 1)
		IfNotBlocked
		reached[1][3] = 1;
		(trpt+1)->bup.oval = ((int)now.critical);
		now.critical = (((int)now.critical)+1);
#ifdef VAR_RANGES
		logval("critical", ((int)now.critical));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 6: // STATE 4 - eg9.pml:22 - [assert((critical==1))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][4] = 1;
		spin_assert((((int)now.critical)==1), "(critical==1)", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 7: // STATE 5 - eg9.pml:23 - [critical = (critical-1)] (0:0:1 - 1)
		IfNotBlocked
		reached[1][5] = 1;
		(trpt+1)->bup.oval = ((int)now.critical);
		now.critical = (((int)now.critical)-1);
#ifdef VAR_RANGES
		logval("critical", ((int)now.critical));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 8: // STATE 6 - eg9.pml:24 - [printf('Critical section Q\\n')] (0:0:0 - 1)
		IfNotBlocked
		reached[1][6] = 1;
		Printf("Critical section Q\n");
		_m = 3; goto P999; /* 0 */
	case 9: // STATE 7 - eg9.pml:25 - [wantQ = 0] (0:0:1 - 1)
		IfNotBlocked
		reached[1][7] = 1;
		(trpt+1)->bup.oval = ((int)wantQ);
		wantQ = 0;
#ifdef VAR_RANGES
		logval("wantQ", ((int)wantQ));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 10: // STATE 11 - eg9.pml:27 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[1][11] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC P */
	case 11: // STATE 1 - eg9.pml:7 - [printf('Non critical section P\\n')] (0:0:0 - 1)
		IfNotBlocked
		reached[0][1] = 1;
		Printf("Non critical section P\n");
		_m = 3; goto P999; /* 0 */
	case 12: // STATE 2 - eg9.pml:8 - [wantP = 1] (0:0:1 - 1)
		IfNotBlocked
		reached[0][2] = 1;
		(trpt+1)->bup.oval = ((int)wantP);
		wantP = 1;
#ifdef VAR_RANGES
		logval("wantP", ((int)wantP));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 13: // STATE 3 - eg9.pml:9 - [critical = (critical+1)] (0:0:1 - 1)
		IfNotBlocked
		reached[0][3] = 1;
		(trpt+1)->bup.oval = ((int)now.critical);
		now.critical = (((int)now.critical)+1);
#ifdef VAR_RANGES
		logval("critical", ((int)now.critical));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 14: // STATE 4 - eg9.pml:10 - [assert((critical==1))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][4] = 1;
		spin_assert((((int)now.critical)==1), "(critical==1)", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 15: // STATE 5 - eg9.pml:11 - [critical = (critical-1)] (0:0:1 - 1)
		IfNotBlocked
		reached[0][5] = 1;
		(trpt+1)->bup.oval = ((int)now.critical);
		now.critical = (((int)now.critical)-1);
#ifdef VAR_RANGES
		logval("critical", ((int)now.critical));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 16: // STATE 6 - eg9.pml:12 - [printf('Critical section P\\n')] (0:0:0 - 1)
		IfNotBlocked
		reached[0][6] = 1;
		Printf("Critical section P\n");
		_m = 3; goto P999; /* 0 */
	case 17: // STATE 7 - eg9.pml:13 - [wantP = 0] (0:0:1 - 1)
		IfNotBlocked
		reached[0][7] = 1;
		(trpt+1)->bup.oval = ((int)wantP);
		wantP = 0;
#ifdef VAR_RANGES
		logval("wantP", ((int)wantP));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 18: // STATE 11 - eg9.pml:15 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[0][11] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */
	case  _T5:	/* np_ */
		if (!((!(trpt->o_pm&4) && !(trpt->tau&128))))
			continue;
		/* else fall through */
	case  _T2:	/* true */
		_m = 3; goto P999;
#undef rand
	}

