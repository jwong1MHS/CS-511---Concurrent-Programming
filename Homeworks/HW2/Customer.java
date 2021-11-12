/**
 * Name: Jason Wong
 * Partner: Kevin Ha
 * Class: CS 511-A
 * Pledge: I pledge my honor that I have abided by the Stevens Honor System.
 */

import java.util.Arrays;
import java.util.List;
import java.util.Random;
import java.util.ArrayList;

public class Customer implements Runnable {
    private Bakery bakery;
    private Random rnd;
    private List<BreadType> shoppingCart;
    private int shopTime;
    private int checkoutTime;

    /**
     * Initialize a customer object and randomize its shopping cart
     */
    public Customer(Bakery bakery) {
        // TODO
        this.bakery = bakery;
        rnd = new Random();
        shoppingCart = new ArrayList<BreadType>();
        shopTime = 1+rnd.nextInt(2000);
        checkoutTime = 1+rnd.nextInt(2000);
        fillShoppingCart();
    }

    /**
     * Run tasks for the customer
     */
    public void run() {
        // TODO

        System.out.println(toString());

        // taking the bread from the shelves
        try {
            Thread.sleep(shopTime);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        for (BreadType b : shoppingCart) {
            try {
                bakery.breadMutex[b.ordinal()].acquire();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            bakery.takeBread(b);
            System.out.println("Customer " + hashCode() + ": took " + b.name() + " from shelf.");
            bakery.breadMutex[b.ordinal()].release();
        }
        
        // adding to the sales
        try {
            Thread.sleep(checkoutTime);
            bakery.cashierMutex.acquire();
            bakery.salesMutex.acquire();
        } catch (InterruptedException e1) {
            e1.printStackTrace();
        }
        System.out.println("Customer " + hashCode() + ": at checkout.");
        bakery.addSales(getItemsValue());

        bakery.salesMutex.release();
        bakery.cashierMutex.release();
        System.out.println("Customer " + hashCode() + ": left the bakery.");
        bakery.customerPerm.release();
    }

    /**
     * Return a string representation of the customer
     */
    public String toString() {
        return "Customer " + hashCode() + ": shoppingCart=" + Arrays.toString(shoppingCart.toArray()) + ", shopTime=" + shopTime + ", checkoutTime=" + checkoutTime;
    }

    /**
     * Add a bread item to the customer's shopping cart
     */
    private boolean addItem(BreadType bread) {
        // do not allow more than 3 items, chooseItems() does not call more than 3 times
        if (shoppingCart.size() >= 3) {
            return false;
        }
        shoppingCart.add(bread);
        return true;
    }

    /**
     * Fill the customer's shopping cart with 1 to 3 random breads
     */
    private void fillShoppingCart() {
        int itemCnt = 1 + rnd.nextInt(3);
        while (itemCnt > 0) {
            addItem(BreadType.values()[rnd.nextInt(BreadType.values().length)]);
            itemCnt--;
        }
    }

    /**
     * Calculate the total value of the items in the customer's shopping cart
     */
    private float getItemsValue() {
        float value = 0;
        for (BreadType bread : shoppingCart) {
            value += bread.getPrice();
        }
        return value;
    }
}