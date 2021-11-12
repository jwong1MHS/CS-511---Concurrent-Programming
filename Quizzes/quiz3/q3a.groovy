
/*
Quiz 3A - 29 Sep 2021

You may not add print statements nor additional semaphores.
Add ONLY acquire and release operations to the following code so that the output is:

Name: Jason Wong
Partner: Kevin Ha
Section: A

aabaabaab....

*/

import java.util.concurrent.Semaphore;
Semaphore a = new Semaphore(0);
Semaphore b = new Semaphore(2);



Thread.start {
    
    while (true) {
   
        b.acquire();
	    print("a");
        a.release();
          
    }
}

Thread.start {

    while (true) {
    
        a.acquire();
        a.acquire();
        print("b");
        b.release();
        b.release();
	
    }
}