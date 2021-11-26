	switch (t->back) {
	default: Uerror("bad return move");
	case  0: goto R999; /* nothing to undo */

		 /* PROC Q */
;
		;
		
	case 4: // STATE 2
		;
		wantQ = trpt->bup.oval;
		;
		goto R999;

	case 5: // STATE 3
		;
		now.critical = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 7: // STATE 5
		;
		now.critical = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 9: // STATE 7
		;
		wantQ = trpt->bup.oval;
		;
		goto R999;

	case 10: // STATE 11
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC P */
;
		;
		
	case 12: // STATE 2
		;
		wantP = trpt->bup.oval;
		;
		goto R999;

	case 13: // STATE 3
		;
		now.critical = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 15: // STATE 5
		;
		now.critical = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 17: // STATE 7
		;
		wantP = trpt->bup.oval;
		;
		goto R999;

	case 18: // STATE 11
		;
		p_restor(II);
		;
		;
		goto R999;
	}

