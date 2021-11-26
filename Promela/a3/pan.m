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
	case 3: // STATE 1 - a3.pml:16 - [wantQ = 1] (0:0:1 - 1)
		IfNotBlocked
		reached[1][1] = 1;
		(trpt+1)->bup.oval = ((int)now.wantQ);
		now.wantQ = 1;
#ifdef VAR_RANGES
		logval("wantQ", ((int)now.wantQ));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 4: // STATE 2 - a3.pml:18 - [((wantP==0))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][2] = 1;
		if (!((((int)now.wantP)==0)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 5: // STATE 8 - a3.pml:22 - [wantQ = 0] (0:0:1 - 3)
		IfNotBlocked
		reached[1][8] = 1;
		(trpt+1)->bup.oval = ((int)now.wantQ);
		now.wantQ = 0;
#ifdef VAR_RANGES
		logval("wantQ", ((int)now.wantQ));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 6: // STATE 12 - a3.pml:24 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[1][12] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC P */
	case 7: // STATE 1 - a3.pml:5 - [wantP = 1] (0:0:1 - 1)
		IfNotBlocked
		reached[0][1] = 1;
		(trpt+1)->bup.oval = ((int)now.wantP);
		now.wantP = 1;
#ifdef VAR_RANGES
		logval("wantP", ((int)now.wantP));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 8: // STATE 2 - a3.pml:7 - [((wantQ==0))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][2] = 1;
		if (!((((int)now.wantQ)==0)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 9: // STATE 8 - a3.pml:11 - [wantP = 0] (0:0:1 - 3)
		IfNotBlocked
		reached[0][8] = 1;
		(trpt+1)->bup.oval = ((int)now.wantP);
		now.wantP = 0;
#ifdef VAR_RANGES
		logval("wantP", ((int)now.wantP));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 10: // STATE 12 - a3.pml:13 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[0][12] = 1;
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

