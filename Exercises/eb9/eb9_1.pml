byte turn=1;

active proctype P() {
	do
	 :: do
		  :: turn==1 -> break;
		  :: else
		od;
		printf("P went in \n");
		turn = 2
	od
}

active proctype Q() {
	do
	 :: do
		  :: turn==2 -> break;
		  :: else
		od;
		printf("Q went in \n");
		turn = 1
	od
}

init {
    atomic {
        run P();
        run Q()
    }
}