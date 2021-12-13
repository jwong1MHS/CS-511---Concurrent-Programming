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

		 /* CLAIM p3 */
	case 3: // STATE 1 - _spin_nvr.tmp:3 - [(!(((nr_leaders==0)||(nr_leaders==1))))] (6:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[2][1] = 1;
		if (!( !(((((int)now.nr_leaders)==0)||(((int)now.nr_leaders)==1)))))
			continue;
		/* merge: assert(!(!(((nr_leaders==0)||(nr_leaders==1)))))(0, 2, 6) */
		reached[2][2] = 1;
		spin_assert( !( !(((((int)now.nr_leaders)==0)||(((int)now.nr_leaders)==1)))), " !( !(((nr_leaders==0)||(nr_leaders==1))))", II, tt, t);
		/* merge: .(goto)(0, 7, 6) */
		reached[2][7] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 4: // STATE 10 - _spin_nvr.tmp:8 - [-end-] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported10 = 0;
			if (verbose && !reported10)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported10 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported10 = 0;
			if (verbose && !reported10)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported10 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[2][10] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC :init: */
	case 5: // STATE 1 - cr.pml:57 - [I = 1] (0:0:1 - 1)
		IfNotBlocked
		reached[1][1] = 1;
		(trpt+1)->bup.oval = ((int)((P1 *)_this)->I);
		((P1 *)_this)->I = 1;
#ifdef VAR_RANGES
		logval(":init::I", ((int)((P1 *)_this)->I));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 6: // STATE 2 - cr.pml:57 - [((I<=4))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][2] = 1;
		if (!((((int)((P1 *)_this)->I)<=4)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 7: // STATE 3 - cr.pml:59 - [(((Ini[0]==0)&&(4>=1)))] (20:0:2 - 1)
		IfNotBlocked
		reached[1][3] = 1;
		if (!(((((int)((P1 *)_this)->Ini[0])==0)&&(4>=1))))
			continue;
		/* merge: Ini[0] = I(20, 4, 20) */
		reached[1][4] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = ((int)((P1 *)_this)->Ini[0]);
		((P1 *)_this)->Ini[0] = ((int)((P1 *)_this)->I);
#ifdef VAR_RANGES
		logval(":init::Ini[0]", ((int)((P1 *)_this)->Ini[0]));
#endif
		;
		/* merge: .(goto)(20, 16, 20) */
		reached[1][16] = 1;
		;
		/* merge: I = (I+1)(20, 17, 20) */
		reached[1][17] = 1;
		(trpt+1)->bup.ovals[1] = ((int)((P1 *)_this)->I);
		((P1 *)_this)->I = (((int)((P1 *)_this)->I)+1);
#ifdef VAR_RANGES
		logval(":init::I", ((int)((P1 *)_this)->I));
#endif
		;
		/* merge: .(goto)(0, 21, 20) */
		reached[1][21] = 1;
		;
		_m = 3; goto P999; /* 4 */
	case 8: // STATE 5 - cr.pml:60 - [(((Ini[1]==0)&&(4>=2)))] (20:0:2 - 1)
		IfNotBlocked
		reached[1][5] = 1;
		if (!(((((int)((P1 *)_this)->Ini[1])==0)&&(4>=2))))
			continue;
		/* merge: Ini[1] = I(20, 6, 20) */
		reached[1][6] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = ((int)((P1 *)_this)->Ini[1]);
		((P1 *)_this)->Ini[1] = ((int)((P1 *)_this)->I);
#ifdef VAR_RANGES
		logval(":init::Ini[1]", ((int)((P1 *)_this)->Ini[1]));
#endif
		;
		/* merge: .(goto)(20, 16, 20) */
		reached[1][16] = 1;
		;
		/* merge: I = (I+1)(20, 17, 20) */
		reached[1][17] = 1;
		(trpt+1)->bup.ovals[1] = ((int)((P1 *)_this)->I);
		((P1 *)_this)->I = (((int)((P1 *)_this)->I)+1);
#ifdef VAR_RANGES
		logval(":init::I", ((int)((P1 *)_this)->I));
#endif
		;
		/* merge: .(goto)(0, 21, 20) */
		reached[1][21] = 1;
		;
		_m = 3; goto P999; /* 4 */
	case 9: // STATE 7 - cr.pml:61 - [(((Ini[2]==0)&&(4>=3)))] (20:0:2 - 1)
		IfNotBlocked
		reached[1][7] = 1;
		if (!(((((int)((P1 *)_this)->Ini[2])==0)&&(4>=3))))
			continue;
		/* merge: Ini[2] = I(20, 8, 20) */
		reached[1][8] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = ((int)((P1 *)_this)->Ini[2]);
		((P1 *)_this)->Ini[2] = ((int)((P1 *)_this)->I);
#ifdef VAR_RANGES
		logval(":init::Ini[2]", ((int)((P1 *)_this)->Ini[2]));
#endif
		;
		/* merge: .(goto)(20, 16, 20) */
		reached[1][16] = 1;
		;
		/* merge: I = (I+1)(20, 17, 20) */
		reached[1][17] = 1;
		(trpt+1)->bup.ovals[1] = ((int)((P1 *)_this)->I);
		((P1 *)_this)->I = (((int)((P1 *)_this)->I)+1);
#ifdef VAR_RANGES
		logval(":init::I", ((int)((P1 *)_this)->I));
#endif
		;
		/* merge: .(goto)(0, 21, 20) */
		reached[1][21] = 1;
		;
		_m = 3; goto P999; /* 4 */
	case 10: // STATE 9 - cr.pml:62 - [(((Ini[3]==0)&&(4>=4)))] (20:0:2 - 1)
		IfNotBlocked
		reached[1][9] = 1;
		if (!(((((int)((P1 *)_this)->Ini[3])==0)&&(4>=4))))
			continue;
		/* merge: Ini[3] = I(20, 10, 20) */
		reached[1][10] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = ((int)((P1 *)_this)->Ini[3]);
		((P1 *)_this)->Ini[3] = ((int)((P1 *)_this)->I);
#ifdef VAR_RANGES
		logval(":init::Ini[3]", ((int)((P1 *)_this)->Ini[3]));
#endif
		;
		/* merge: .(goto)(20, 16, 20) */
		reached[1][16] = 1;
		;
		/* merge: I = (I+1)(20, 17, 20) */
		reached[1][17] = 1;
		(trpt+1)->bup.ovals[1] = ((int)((P1 *)_this)->I);
		((P1 *)_this)->I = (((int)((P1 *)_this)->I)+1);
#ifdef VAR_RANGES
		logval(":init::I", ((int)((P1 *)_this)->I));
#endif
		;
		/* merge: .(goto)(0, 21, 20) */
		reached[1][21] = 1;
		;
		_m = 3; goto P999; /* 4 */
	case 11: // STATE 11 - cr.pml:63 - [(((Ini[4]==0)&&(4>=5)))] (20:0:2 - 1)
		IfNotBlocked
		reached[1][11] = 1;
		if (!(((((int)((P1 *)_this)->Ini[4])==0)&&(4>=5))))
			continue;
		/* merge: Ini[4] = I(20, 12, 20) */
		reached[1][12] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = ((int)((P1 *)_this)->Ini[4]);
		((P1 *)_this)->Ini[4] = ((int)((P1 *)_this)->I);
#ifdef VAR_RANGES
		logval(":init::Ini[4]", ((int)((P1 *)_this)->Ini[4]));
#endif
		;
		/* merge: .(goto)(20, 16, 20) */
		reached[1][16] = 1;
		;
		/* merge: I = (I+1)(20, 17, 20) */
		reached[1][17] = 1;
		(trpt+1)->bup.ovals[1] = ((int)((P1 *)_this)->I);
		((P1 *)_this)->I = (((int)((P1 *)_this)->I)+1);
#ifdef VAR_RANGES
		logval(":init::I", ((int)((P1 *)_this)->I));
#endif
		;
		/* merge: .(goto)(0, 21, 20) */
		reached[1][21] = 1;
		;
		_m = 3; goto P999; /* 4 */
	case 12: // STATE 13 - cr.pml:64 - [(((Ini[5]==0)&&(4>=6)))] (20:0:2 - 1)
		IfNotBlocked
		reached[1][13] = 1;
		if (!(((((int)((P1 *)_this)->Ini[5])==0)&&(4>=6))))
			continue;
		/* merge: Ini[5] = I(20, 14, 20) */
		reached[1][14] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = ((int)((P1 *)_this)->Ini[5]);
		((P1 *)_this)->Ini[5] = ((int)((P1 *)_this)->I);
#ifdef VAR_RANGES
		logval(":init::Ini[5]", ((int)((P1 *)_this)->Ini[5]));
#endif
		;
		/* merge: .(goto)(20, 16, 20) */
		reached[1][16] = 1;
		;
		/* merge: I = (I+1)(20, 17, 20) */
		reached[1][17] = 1;
		(trpt+1)->bup.ovals[1] = ((int)((P1 *)_this)->I);
		((P1 *)_this)->I = (((int)((P1 *)_this)->I)+1);
#ifdef VAR_RANGES
		logval(":init::I", ((int)((P1 *)_this)->I));
#endif
		;
		/* merge: .(goto)(0, 21, 20) */
		reached[1][21] = 1;
		;
		_m = 3; goto P999; /* 4 */
	case 13: // STATE 17 - cr.pml:57 - [I = (I+1)] (0:20:1 - 7)
		IfNotBlocked
		reached[1][17] = 1;
		(trpt+1)->bup.oval = ((int)((P1 *)_this)->I);
		((P1 *)_this)->I = (((int)((P1 *)_this)->I)+1);
#ifdef VAR_RANGES
		logval(":init::I", ((int)((P1 *)_this)->I));
#endif
		;
		/* merge: .(goto)(0, 21, 20) */
		reached[1][21] = 1;
		;
		_m = 3; goto P999; /* 1 */
	case 14: // STATE 23 - cr.pml:69 - [proc = 0] (0:31:2 - 1)
		IfNotBlocked
		reached[1][23] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = ((P1 *)_this)->_4_2_proc;
		((P1 *)_this)->_4_2_proc = 0;
#ifdef VAR_RANGES
		logval(":init::proc", ((P1 *)_this)->_4_2_proc);
#endif
		;
		/* merge: proc = 1(31, 24, 31) */
		reached[1][24] = 1;
		(trpt+1)->bup.ovals[1] = ((P1 *)_this)->_4_2_proc;
		((P1 *)_this)->_4_2_proc = 1;
#ifdef VAR_RANGES
		logval(":init::proc", ((P1 *)_this)->_4_2_proc);
#endif
		;
		/* merge: .(goto)(0, 32, 31) */
		reached[1][32] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 15: // STATE 25 - cr.pml:69 - [((proc<=4))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][25] = 1;
		if (!((((P1 *)_this)->_4_2_proc<=4)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 16: // STATE 26 - cr.pml:70 - [(run nnode(q[(proc-1)],q[(proc%4)],Ini[(proc-1)]))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][26] = 1;
		if (!(addproc(II, 1, 0, now.q[ Index((((P1 *)_this)->_4_2_proc-1), 4) ], now.q[ Index((((P1 *)_this)->_4_2_proc%4), 4) ], ((int)((P1 *)_this)->Ini[ Index((((P1 *)_this)->_4_2_proc-1), 6) ]))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 17: // STATE 27 - cr.pml:71 - [printf('Initializing %d %d %d \\n',q[(proc-1)],q[(proc%4)],Ini[(proc-1)])] (0:31:1 - 1)
		IfNotBlocked
		reached[1][27] = 1;
		Printf("Initializing %d %d %d \n", now.q[ Index((((P1 *)_this)->_4_2_proc-1), 4) ], now.q[ Index((((P1 *)_this)->_4_2_proc%4), 4) ], ((int)((P1 *)_this)->Ini[ Index((((P1 *)_this)->_4_2_proc-1), 6) ]));
		/* merge: proc = (proc+1)(31, 28, 31) */
		reached[1][28] = 1;
		(trpt+1)->bup.oval = ((P1 *)_this)->_4_2_proc;
		((P1 *)_this)->_4_2_proc = (((P1 *)_this)->_4_2_proc+1);
#ifdef VAR_RANGES
		logval(":init::proc", ((P1 *)_this)->_4_2_proc);
#endif
		;
		/* merge: .(goto)(0, 32, 31) */
		reached[1][32] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 18: // STATE 35 - cr.pml:75 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[1][35] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC nnode */
	case 19: // STATE 1 - cr.pml:23 - [printf('NNode: %d\\n',mynumber)] (0:0:0 - 1)
		IfNotBlocked
		reached[0][1] = 1;
		Printf("NNode: %d\n", ((int)((P0 *)_this)->mynumber));
		_m = 3; goto P999; /* 0 */
	case 20: // STATE 2 - cr.pml:25 - [out!one,mynumber] (0:0:0 - 1)
		IfNotBlocked
		reached[0][2] = 1;
		
#if !defined(XUSAFE) && !defined(NOREDUCE)
		if (q_claim[((P0 *)_this)->out]&2)
		{	q_S_check(((P0 *)_this)->out, II);
		}
#endif
		if (q_full(((P0 *)_this)->out))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P0 *)_this)->out);
		sprintf(simtmp, "%d", 2); strcat(simvals, simtmp);		strcat(simvals, ",");
		sprintf(simtmp, "%d", ((int)((P0 *)_this)->mynumber)); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P0 *)_this)->out, 0, 2, ((int)((P0 *)_this)->mynumber), 2);
		_m = 2; goto P999; /* 0 */
	case 21: // STATE 3 - cr.pml:28 - [inp?one,nr] (0:0:1 - 1)
		reached[0][3] = 1;
		
#if !defined(XUSAFE) && !defined(NOREDUCE)
		if (q_claim[((P0 *)_this)->inp]&1)
		{	q_R_check(((P0 *)_this)->inp, II);
		}
#endif
		if (q_len(((P0 *)_this)->inp) == 0) continue;

		XX=1;
		if (2 != qrecv(((P0 *)_this)->inp, 0, 0, 0)) continue;
		(trpt+1)->bup.oval = ((int)((P0 *)_this)->nr);
		;
		((P0 *)_this)->nr = qrecv(((P0 *)_this)->inp, XX-1, 1, 1);
#ifdef VAR_RANGES
		logval("nnode:nr", ((int)((P0 *)_this)->nr));
#endif
		;
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P0 *)_this)->inp);
		sprintf(simtmp, "%d", 2); strcat(simvals, simtmp);		strcat(simvals, ",");
		sprintf(simtmp, "%d", ((int)((P0 *)_this)->nr)); strcat(simvals, simtmp);		}
#endif
		;
		_m = 4; goto P999; /* 0 */
	case 22: // STATE 4 - cr.pml:31 - [((nr==mynumber))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][4] = 1;
		if (!((((int)((P0 *)_this)->nr)==((int)((P0 *)_this)->mynumber))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 23: // STATE 5 - cr.pml:33 - [nr_leaders = (nr_leaders+1)] (0:0:1 - 1)
		IfNotBlocked
		reached[0][5] = 1;
		(trpt+1)->bup.oval = ((int)now.nr_leaders);
		now.nr_leaders = (((int)now.nr_leaders)+1);
#ifdef VAR_RANGES
		logval("nr_leaders", ((int)now.nr_leaders));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 24: // STATE 6 - cr.pml:34 - [out!winner,nr] (0:0:0 - 1)
		IfNotBlocked
		reached[0][6] = 1;
		
#if !defined(XUSAFE) && !defined(NOREDUCE)
		if (q_claim[((P0 *)_this)->out]&2)
		{	q_S_check(((P0 *)_this)->out, II);
		}
#endif
		if (q_full(((P0 *)_this)->out))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P0 *)_this)->out);
		sprintf(simtmp, "%d", 1); strcat(simvals, simtmp);		strcat(simvals, ",");
		sprintf(simtmp, "%d", ((int)((P0 *)_this)->nr)); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P0 *)_this)->out, 0, 1, ((int)((P0 *)_this)->nr), 2);
		_m = 2; goto P999; /* 0 */
	case 25: // STATE 7 - cr.pml:35 - [((nr>mynumber))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][7] = 1;
		if (!((((int)((P0 *)_this)->nr)>((int)((P0 *)_this)->mynumber))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 26: // STATE 8 - cr.pml:35 - [out!one,nr] (0:0:0 - 1)
		IfNotBlocked
		reached[0][8] = 1;
		
#if !defined(XUSAFE) && !defined(NOREDUCE)
		if (q_claim[((P0 *)_this)->out]&2)
		{	q_S_check(((P0 *)_this)->out, II);
		}
#endif
		if (q_full(((P0 *)_this)->out))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P0 *)_this)->out);
		sprintf(simtmp, "%d", 2); strcat(simvals, simtmp);		strcat(simvals, ",");
		sprintf(simtmp, "%d", ((int)((P0 *)_this)->nr)); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P0 *)_this)->out, 0, 2, ((int)((P0 *)_this)->nr), 2);
		_m = 2; goto P999; /* 0 */
	case 27: // STATE 9 - cr.pml:36 - [((nr<mynumber))] (0:0:1 - 1)
		IfNotBlocked
		reached[0][9] = 1;
		if (!((((int)((P0 *)_this)->nr)<((int)((P0 *)_this)->mynumber))))
			continue;
		if (TstOnly) return 1; /* TT */
		/* dead 1: nr */  (trpt+1)->bup.oval = ((P0 *)_this)->nr;
#ifdef HAS_CODE
		if (!readtrail)
#endif
			((P0 *)_this)->nr = 0;
		_m = 3; goto P999; /* 0 */
	case 28: // STATE 13 - cr.pml:38 - [inp?winner,nr] (0:0:1 - 1)
		reached[0][13] = 1;
		
#if !defined(XUSAFE) && !defined(NOREDUCE)
		if (q_claim[((P0 *)_this)->inp]&1)
		{	q_R_check(((P0 *)_this)->inp, II);
		}
#endif
		if (q_len(((P0 *)_this)->inp) == 0) continue;

		XX=1;
		if (1 != qrecv(((P0 *)_this)->inp, 0, 0, 0)) continue;
		(trpt+1)->bup.oval = ((int)((P0 *)_this)->nr);
		;
		((P0 *)_this)->nr = qrecv(((P0 *)_this)->inp, XX-1, 1, 1);
#ifdef VAR_RANGES
		logval("nnode:nr", ((int)((P0 *)_this)->nr));
#endif
		;
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P0 *)_this)->inp);
		sprintf(simtmp, "%d", 1); strcat(simvals, simtmp);		strcat(simvals, ",");
		sprintf(simtmp, "%d", ((int)((P0 *)_this)->nr)); strcat(simvals, simtmp);		}
#endif
		;
		_m = 4; goto P999; /* 0 */
	case 29: // STATE 14 - cr.pml:41 - [((nr!=mynumber))] (0:0:1 - 1)
		IfNotBlocked
		reached[0][14] = 1;
		if (!((((int)((P0 *)_this)->nr)!=((int)((P0 *)_this)->mynumber))))
			continue;
		if (TstOnly) return 1; /* TT */
		/* dead 1: mynumber */  (trpt+1)->bup.oval = ((P0 *)_this)->mynumber;
#ifdef HAS_CODE
		if (!readtrail)
#endif
			((P0 *)_this)->mynumber = 0;
		_m = 3; goto P999; /* 0 */
	case 30: // STATE 15 - cr.pml:43 - [out!winner,nr] (0:0:0 - 1)
		IfNotBlocked
		reached[0][15] = 1;
		
#if !defined(XUSAFE) && !defined(NOREDUCE)
		if (q_claim[((P0 *)_this)->out]&2)
		{	q_S_check(((P0 *)_this)->out, II);
		}
#endif
		if (q_full(((P0 *)_this)->out))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P0 *)_this)->out);
		sprintf(simtmp, "%d", 1); strcat(simvals, simtmp);		strcat(simvals, ",");
		sprintf(simtmp, "%d", ((int)((P0 *)_this)->nr)); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P0 *)_this)->out, 0, 1, ((int)((P0 *)_this)->nr), 2);
		_m = 2; goto P999; /* 0 */
	case 31: // STATE 29 - cr.pml:51 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[0][29] = 1;
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

