	switch (t->back) {
	default: Uerror("bad return move");
	case  0: goto R999; /* nothing to undo */

		 /* CLAIM p3 */
;
		
	case 3: // STATE 1
		goto R999;

	case 4: // STATE 10
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC :init: */

	case 5: // STATE 1
		;
		((P1 *)_this)->I = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 7: // STATE 17
		;
		((P1 *)_this)->I = trpt->bup.ovals[1];
		((P1 *)_this)->Ini[0] = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;

	case 8: // STATE 17
		;
		((P1 *)_this)->I = trpt->bup.ovals[1];
		((P1 *)_this)->Ini[1] = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;

	case 9: // STATE 17
		;
		((P1 *)_this)->I = trpt->bup.ovals[1];
		((P1 *)_this)->Ini[2] = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;

	case 10: // STATE 17
		;
		((P1 *)_this)->I = trpt->bup.ovals[1];
		((P1 *)_this)->Ini[3] = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;

	case 11: // STATE 17
		;
		((P1 *)_this)->I = trpt->bup.ovals[1];
		((P1 *)_this)->Ini[4] = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;

	case 12: // STATE 17
		;
		((P1 *)_this)->I = trpt->bup.ovals[1];
		((P1 *)_this)->Ini[5] = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;

	case 13: // STATE 17
		;
		((P1 *)_this)->I = trpt->bup.oval;
		;
		goto R999;

	case 14: // STATE 24
		;
		((P1 *)_this)->_4_2_proc = trpt->bup.ovals[1];
		((P1 *)_this)->_4_2_proc = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;
;
		;
		
	case 16: // STATE 26
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 17: // STATE 28
		;
		((P1 *)_this)->_4_2_proc = trpt->bup.oval;
		;
		goto R999;

	case 18: // STATE 35
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC nnode */
;
		;
		
	case 20: // STATE 2
		;
		_m = unsend(((P0 *)_this)->out);
		;
		goto R999;

	case 21: // STATE 3
		;
		XX = 1;
		unrecv(((P0 *)_this)->inp, XX-1, 0, 2, 1);
		unrecv(((P0 *)_this)->inp, XX-1, 1, ((int)((P0 *)_this)->nr), 0);
		((P0 *)_this)->nr = trpt->bup.oval;
		;
		;
		goto R999;
;
		;
		
	case 23: // STATE 5
		;
		now.nr_leaders = trpt->bup.oval;
		;
		goto R999;

	case 24: // STATE 6
		;
		_m = unsend(((P0 *)_this)->out);
		;
		goto R999;
;
		;
		
	case 26: // STATE 8
		;
		_m = unsend(((P0 *)_this)->out);
		;
		goto R999;

	case 27: // STATE 9
		;
	/* 0 */	((P0 *)_this)->nr = trpt->bup.oval;
		;
		;
		goto R999;

	case 28: // STATE 13
		;
		XX = 1;
		unrecv(((P0 *)_this)->inp, XX-1, 0, 1, 1);
		unrecv(((P0 *)_this)->inp, XX-1, 1, ((int)((P0 *)_this)->nr), 0);
		((P0 *)_this)->nr = trpt->bup.oval;
		;
		;
		goto R999;

	case 29: // STATE 14
		;
	/* 0 */	((P0 *)_this)->mynumber = trpt->bup.oval;
		;
		;
		goto R999;

	case 30: // STATE 15
		;
		_m = unsend(((P0 *)_this)->out);
		;
		goto R999;

	case 31: // STATE 29
		;
		p_restor(II);
		;
		;
		goto R999;
	}

