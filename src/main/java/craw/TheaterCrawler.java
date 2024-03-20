package craw;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.ExpectedCondition;
import org.openqa.selenium.support.ui.FluentWait;
import org.openqa.selenium.support.ui.Wait;

import java.time.Duration;
import java.util.List;

public class TheaterCrawler {
	public static void main(String[] args) {
	 
	
        // Selenium WebDriver 인스턴스 생성
    	System.setProperty("webdriver.chrome.driver", "C:\\Users\\admin\\Desktop\\chromedriver-win64\\chromedriver-win64\\chromedriver.exe");
    	WebDriver driver = new ChromeDriver();

        // 웹 페이지로 이동
        driver.get("https://www.kobis.or.kr/kobis/business/mast/thea/findTheaterSchedule.do");

        // FluentWait 인스턴스 생성
        Wait<WebDriver> wait = new FluentWait<>(driver)
                .withTimeout(Duration.ofSeconds(10)) // 최대 대기 시간
                .pollingEvery(Duration.ofMillis(500)) // 폴링 간격
                .ignoring(Exception.class); // 무시할 예외

        // 광역 기초 영화 상영관 정보를 담을 리스트
        List<WebElement> theaterElements = null;

        try {
            // 광역 기초 영화 상영관 정보가 포함된 요소들을 가져오기 위해 대기
            theaterElements = wait.until((ExpectedCondition<List<WebElement>>) driver1 ->
                    driver1.findElements(By.cssSelector(".contents_board1 > table tbody tr")));
        } finally {
            // WebDriver 종료
            driver.quit();
        }

        // 광역 기초 영화 상영관 정보 출력
        if (theaterElements != null) {
            for (WebElement theaterElement : theaterElements) {
                System.out.println(theaterElement.getText());
            }
        } else {
            System.out.println("광역 기초 영화 상영관 정보를 찾을 수 없습니다.");
        }
    }
}
