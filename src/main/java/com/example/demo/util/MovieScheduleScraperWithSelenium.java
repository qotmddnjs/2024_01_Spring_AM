package com.example.demo.util;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import java.util.List;

public class MovieScheduleScraperWithSelenium {
    public static void main() {
        // Chrome WebDriver 경로 설정
        System.setProperty("webdriver.chrome.driver", "C:\\Users\\admin\\Desktop\\chromedriver-win64\\chromedriver-win64\\chromedriver.exe");

        // Chrome 브라우저 열기
        WebDriver driver = new ChromeDriver();

        // 웹 페이지 열기
        driver.get("https://www.kobis.or.kr/kobis/business/mast/thea/findTheaterSchedule.do");

        // 특정 요소 클릭
        WebElement element = driver.findElement(By.id("your-element-id"));
        element.click();

        // 클릭 이후 나타나는 모든 내용 가져오기
        List<WebElement> allElements = driver.findElements(By.cssSelector("*"));
        for (WebElement el : allElements) {
            System.out.println(el.getText());
        }

        // WebDriver 종료
        driver.quit();
    }
}
