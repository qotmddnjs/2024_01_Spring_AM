package com.example.demo.util;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;

public class movietime {
    public static void movietimelist () {
        // Chrome WebDriver 경로 설정
    	System.setProperty("webdriver.chrome.driver", "C:\\work\\chromedriver.exe");

        // Chrome 브라우저 인스턴스 생성
        WebDriver driver = new ChromeDriver();

        // 크롤링할 웹 페이지의 URL
        String url = "https://www.kobis.or.kr/kobis/business/mast/thea/findTheaterSchedule.do";

        // 웹 페이지로 이동
        driver.get(url);


        // ONCLICK 이벤트가 발생하는 요소를 찾고 클릭하여 내용 가져오기
        WebElement element = driver.findElement(By.cssSelector(".fl.step1.on ul li"));
        element.click();

        // 동적으로 변하는 내용 가져오기
        String dynamicContent = driver.findElement(By.cssSelector(".fl.step2.on ul li")).getText(); // YOUR_DYNAMIC_XPATH에 적절한 XPath를 지정하세요.
        System.out.println(dynamicContent);

        // WebDriver 종료
        driver.quit();
    }
}


