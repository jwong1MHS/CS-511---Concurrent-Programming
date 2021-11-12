/**
 * Name: Jason Wong
 * Partner: Kevin Ha
 * Class: CS 511-A
 * Pledge: I pledge my honor that I have abided by the Stevens Honor System.
 */

/* start the simulation */
public class Assignment2 {
    public static void main(String[] args) {
        Thread thread = new Thread(new Bakery());
        thread.start();

        try {
            thread.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}
