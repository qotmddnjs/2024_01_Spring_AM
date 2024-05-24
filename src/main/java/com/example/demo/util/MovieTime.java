package com.example.demo.util;

import com.example.demo.dao.MovieScheduleDAO;
import com.example.demo.vo.MovieScheduleVO;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;

public class MovieTime {
    public static void movieTimeList() {
        // Chrome WebDriver 경로 설정
        System.setProperty("webdriver.chrome.driver", "C:\\work\\chromedriver.exe");

        // Chrome 브라우저 인스턴스 생성
        WebDriver driver = new ChromeDriver();

        // 크롤링할 웹 페이지의 URL
        String url = "https://www.kobis.or.kr/kobis/business/mast/thea/findTheaterSchedule.do";

        // DAO 인스턴스 생성
        MovieScheduleDAO movieScheduleDAO = new MovieScheduleDAO();

        try {
            // 웹 페이지로 이동
            driver.get(url);

            // 각 광역 코드와 기초 코드의 모든 조합에 대해 반복
            for (int wideAreaIndex = 1; wideAreaIndex <= 17; wideAreaIndex++) {
                // 광역 클릭
                WebElement wideAreaElement = driver.findElement(By.cssSelector("#content > div.schedule > div.fl.step1.on > ul > li:nth-child(" + wideAreaIndex + ")"));
                wideAreaElement.click();
                Thread.sleep(1000); // 1초 대기

                // 기초 목록 가져오기
                java.util.List<WebElement> baseAreaElements = driver.findElements(By.cssSelector("#content > div.schedule > div.fl.step2.on > ul > li"));
                for (WebElement baseAreaElement : baseAreaElements) {
                    // 기초 클릭
                    baseAreaElement.click();
                    Thread.sleep(1000); // 1초 대기

                    // 상영관 목록 가져오기
                    java.util.List<WebElement> theaterElements = driver.findElements(By.cssSelector("#content > div.schedule > div.fl.step3.on > ul > li"));
                    for (WebElement theaterElement : theaterElements) {
                        // 상영관 클릭
                        theaterElement.click();
                        Thread.sleep(1000); // 1초 대기

                        // 동적으로 변하는 내용 가져오기 (예: 상영 시간)
                        WebElement scheduleElement = driver.findElement(By.cssSelector("#content > div.schedule > div.ovf.step4.on"));

                        // Extracting movie titles and screening times
                        java.util.List<WebElement> movies = scheduleElement.findElements(By.tagName("li"));
                        for (WebElement movie : movies) {
                            try {
                                // Extract movie title
                                WebElement titleElement = movie.findElement(By.cssSelector("div.tit"));
                                String movieTitle = titleElement.getText();

                                // Extract screening times
                                WebElement timesElement = movie.findElement(By.cssSelector("div.times"));
                                String screeningTimes = timesElement.getText();

                                // Check if movie title or screening times is empty
                                if (movieTitle.isEmpty() || screeningTimes.isEmpty()) {
                                    // If either movie title or screening times is empty, continue to the next iteration
                                    continue;
                                }

                                // Print movie title and screening times
                                System.out.println("Movie: " + movieTitle);
                                System.out.println("Screening Times: " + screeningTimes);
                                System.out.println();

                                // VO 생성
                                MovieScheduleVO movieSchedule = new MovieScheduleVO(wideAreaIndex, baseAreaElement.getText(), theaterElement.getText(), movieTitle, screeningTimes);

                                // DAO를 통해 데이터베이스에 삽입
                                movieScheduleDAO.insertMovieSchedule(movieSchedule);
                            } catch (Exception e) {
                                // NoSuchElementException이 발생하면 해당 요소를 찾지 못했음을 알리고 다음으로 넘어감
                                System.out.println("Movie information not found.");
                                continue;
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // WebDriver 종료
            driver.quit();
        }
    }
}
