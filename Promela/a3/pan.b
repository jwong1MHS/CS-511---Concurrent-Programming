	switch (t->back) {
	default: Uerror("bad return move");
	case  0: goto R999; /* nothing to undo */

		 /* PROC Q */

	case 3: // STATE 1
		;
		now.wantQ = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 5: // STATE 8
		;
		now.wantQ = trpt->bup.oval;
		;
		goto R999;

	case 6: // STATE 12
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC P */

	case 7: // STATE 1
		;
		now.wantP = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 9: // STATE 8
		;
		now.wantP = trpt->bup.oval;
		;
		goto R999;

	case 10: // STATE 12
		;
		p_restor(II);
		;
		;
		goto R999;
	}

