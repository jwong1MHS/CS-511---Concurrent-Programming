package threads;

public class TurnstileExampleB {
   private static int counter;
    
    
	public static class Turnstile implements Runnable {
		
		private int max;
		
		Turnstile(int max){
			this.max=max;
		}
		
		public void run() {
		     for (int i=0;i<max;i++) {
		    	 counter++;
		     }
		}
	}
	
	public static void main(String[] args) {
		
		Thread t1 = new Thread(new Turnstile(10000));
		Thread t2 = new Thread(new Turnstile(10000));
		
		t1.start();
		t2.start();
		
		try {
			t1.join();
			t2.join();
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		System.out.println(counter);
	}
}
