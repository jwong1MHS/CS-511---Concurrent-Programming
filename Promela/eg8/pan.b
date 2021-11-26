	switch (t->back) {
	default: Uerror("bad return move");
	case  0: goto R999; /* nothing to undo */

		 /* PROC Finish */
;
		;
		;
		;
		;
		;
		
	case 6: // STATE 4
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC P */

	case 7: // STATE 1
		;
		((P0 *)_this)->i = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 9: // STATE 3
		;
		((P0 *)_this)->temp = trpt->bup.oval;
		;
		goto R999;

	case 10: // STATE 4
		;
		now.n = trpt->bup.oval;
		;
		goto R999;

	case 11: // STATE 5
		;
		((P0 *)_this)->i = trpt->bup.oval;
		;
		goto R999;

	case 12: // STATE 11
		;
		now.finished = trpt->bup.oval;
		;
		goto R999;

	case 13: // STATE 12
		;
		p_restor(II);
		;
		;
		goto R999;
	}

