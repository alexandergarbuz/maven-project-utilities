package com.garbuz.core;
/**
 * Simnle class to demonstrate a multi-module build setup.
 */
public class Main {

    /**
     * Main method to run the application.
     * @param args command line arguments.
     */
    public static void main(String[] args) {
        Main main = new Main();
        System.out.println(main.sayHello("Alex"));
    }

    /**
     * Returns a greeting message.
     * @param name the
     * @return a greeting message.
     */
    public String sayHello(final String name) {
        return "Hello, " + name + " from the core module!";
    }
}
