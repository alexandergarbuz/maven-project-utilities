package com.garbuz.integration.test;

import java.time.Duration;

import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.firefox.FirefoxOptions;
import org.openqa.selenium.support.ui.WebDriverWait;

import io.github.bonigarcia.wdm.WebDriverManager;

public class HomePageIT {
    
    protected WebDriver driver;
    protected WebDriverWait wait;

    protected static final String BASE_URL = "http://localhost:8080";
    protected static final Duration DEFAULT_TIMEOUT = Duration.ofSeconds(10);
	
    
    @BeforeClass
    public static void setupClass() {
        WebDriverManager.chromedriver().setup();
        WebDriverManager.firefoxdriver().setup();
    }
    @Before
    public void setUp() {
        this.driver = createWebDriver();
        this.wait = new WebDriverWait(driver, DEFAULT_TIMEOUT);

        this.driver.manage().window().maximize();
        this.driver.manage().timeouts().implicitlyWait(DEFAULT_TIMEOUT);
    }
    
    @After
    public void tearDown() {
        if (driver != null) {
            driver.quit();
        }
    }
    private WebDriver createWebDriver() {
        final String browser = System.getProperty("test.browser", "chrome");
        // By defaule we are running tests in normal mode so that we could debug them 
        // locally. When deployed to CI/CD the flag will be set.
        boolean headless = Boolean.parseBoolean(System.getProperty("headless", "false"));
        
        return switch (browser.toLowerCase()) {
            case "chrome" -> createChromeDriver(headless);
            case "firefox" -> createFirefoxDriver(headless);
            default -> throw new IllegalArgumentException("Unsupported browser: " + browser);
        };
    }
    private WebDriver createChromeDriver(boolean headless) {
        ChromeOptions options = new ChromeOptions();
        
        if (headless) {
            options.addArguments("--headless=new"); // For new versions of chrome
            //options.addArguments("--headless");  //For old versions of chrome
        }

        options.addArguments("--no-sandbox");
        options.addArguments("--disable-dev-shm-usage");
        options.addArguments("--disable-gpu");
        options.addArguments("--disable-extensions");
        options.addArguments("--window-size=1920,1080");
        
        options.setExperimentalOption("excludeSwitches", new String[]{"enable-automation"});
        options.setExperimentalOption("useAutomationExtension", false);
        
        return new ChromeDriver(options);
    }
    private WebDriver createFirefoxDriver(boolean headless) {
        FirefoxOptions options = new FirefoxOptions();
        
        if (headless) {
            options.addArguments("--headless");
        }
        
        options.addArguments("--width=1920");
        options.addArguments("--height=1080");
        
        return new FirefoxDriver(options);
    }
    protected void openPage(String path) {
        String url = path.startsWith("http") ? path : BASE_URL + path;
        driver.get(url);
    }
    protected void waitForPageLoad() {
        wait.until(driver -> 
            ((org.openqa.selenium.JavascriptExecutor) driver)
                .executeScript("return document.readyState").equals("complete"));
    }
 
    @Test
    public void shouldLoadHomePage() {
        openPage("/");
        waitForPageLoad();
        String pageTitle = driver.getTitle();
        Assert.assertEquals("Main Page", pageTitle);
    }
    
    @Test
    public void shouldLoadHomePage1() {
        openPage("/");
        waitForPageLoad();
        String pageTitle = driver.getTitle();
        Assert.assertEquals("Main Page", pageTitle);
    }
    
    @Test
    public void shouldLoadHomePage2() {
        openPage("/");
        waitForPageLoad();
        String pageTitle = driver.getTitle();
        Assert.assertEquals("Main Page", pageTitle);
    }
}
