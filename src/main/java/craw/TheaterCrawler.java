//import org.openqa.selenium.By;
//import org.openqa.selenium.WebDriver;
//import org.openqa.selenium.WebElement;
//import org.openqa.selenium.chrome.ChromeDriver;
//import org.openqa.selenium.chrome.ChromeOptions;
//import org.openqa.selenium.PageLoadStrategy;
//import org.openqa.selenium.PageLoadStrategy;
//import org.openqa.selenium.chrome.ChromeOptions;
//
//import java.util.List;
//
//public class TheaterCrawler {
//    public static void main() {
//        // Selenium WebDriver 인스턴스 생성
//        System.setProperty("webdriver.chrome.driver", "C:\\Users\\admin\\Desktop\\chromedriver-win64\\chromedriver-win64\\chromedriver.exe");
//        
//        // Chrome 옵션 설정 - 페이지 로드 전략을 eager로 변경
//        ChromeOptions options = new ChromeOptions();
//        options.setPageLoadStrategy(PageLoadStrategy.EAGER);
//        
//        // WebDriver 인스턴스 생성 시 ChromeOptions 전달
//        WebDriver driver = new ChromeDriver(options);
//
//        // 웹 페이지로 이동
//        driver.get("https://www.kobis.or.kr/kobis/business/mast/thea/findTheaterSchedule.do");
//        
//        // 광역 기초 영화 상영관 정보 출력
//        List<WebElement> theaterElements = driver.findElements(By.cssSelector(".contents_board1 > table tbody tr"));
//        if (!theaterElements.isEmpty()) {
//            for (WebElement theaterElement : theaterElements) {
//                // 도시를 선택하는 각 요소를 찾아 클릭
//                List<WebElement> cityElements = theaterElement.findElements(By.cssSelector("li"));
//                for (WebElement cityElement : cityElements) {
//                    cityElement.click();
//                    // 해당 도시 정보 출력
//                    System.out.println("도시: " + cityElement.getText());
//                    // 이후 원하는 작업을 추가하면 됩니다.
//                }
//            }
//        } else {
//            System.out.println("광역 기초 영화 상영관 정보를 찾을 수 없습니다.");
//        }
//        
//        // WebDriver 종료
//        driver.quit();
//    }
//}
