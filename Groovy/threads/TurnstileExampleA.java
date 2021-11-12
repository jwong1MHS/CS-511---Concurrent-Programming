package threads;

public class TurnstileExampleA {
//    private static int counter;
    
    public static class Ctr {
    	private int counter;
    	
    	Ctr() {	
    		counter=0;
    	}
    	public void bump() { 
    		counter++;
    	}
    	public int read() {
    		return counter;
    	}
    }
	public static class Turnstile implements Runnable {
		
		private int max;
		private Ctr c;
		
		Turnstile(int max, Ctr c){
			this.max=max;
			this.c=c;
		}
		
		public void run() {
		     for (int i=0;i<max;i++) {
//		    	 counter++;
		    	 c.bump();
		     }
		}
	}
	
	public static void main(String[] args) {
		
		Ctr c = new Ctr();
		Thread t1 = new Thread(new Turnstile(10000,c));
		Thread t2 = new Thread(new Turnstile(10000,c));
		
		t1.start();
		t2.start();
		
		try {
			t1.join();
			t2.join();
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		System.out.println(c.read());
	}
}
