package com.garbuz.core;

import org.junit.Assert;
import org.junit.Test;

public class MainTest {

    @Test
    public void testSayHello() {
        Main main = new Main();
        String result = main.sayHello("Alex");
        Assert.assertEquals("Hello, Alex from the core module!", result);
    }

}
