package craw;

import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;

public class CrawlingTest {

    public static void main(String[] args) {
        // 1. WebDriver와 ChromeDriver 설정
        System.setProperty("webdriver.chrome.driver", "C:\\Users\\admin\\Desktop\\chromedriver_win32\\chromedriver.exe");
        WebDriver driver = new ChromeDriver();

        // 2. 웹 페이지 접속
        String baseUrl = "https://www.kobis.or.kr/kobis/business/main/main.do";
        driver.get(baseUrl);

        // 3. 데이터 추출
        ArrayList<Movie> movie_data = new ArrayList<>();

        try {
            WebElement movie_container = driver.findElement(By.cssSelector(".info_ovf"));
            List<WebElement> movie_links = movie_container.findElements(By.cssSelector(".tit_item>a"));

            for (int i = 0; i < movie_links.size(); i++) {
                String link = movie_links.get(i).getAttribute("href");
                driver.get(link);

                // 영화 정보 추출
                String title = driver.findElement(By.cssSelector(".block_tite")).getText();
                String star = driver.findElement(By.cssSelector(".emph_grade")).getText();
                String learning_time = driver.findElement(By.cssSelector(".info_tit")).getText();
                String content = driver.findElement(By.cssSelector(".ovf_cont_bdbtm_pd15")).getText();

                // 이미지 URL 추출
                WebElement movie_image = driver.findElement(By.cssSelector(".img_thumb > img"));
                String image_url = movie_image.getAttribute("src");

                // 영화 정보 출력
                System.out.println((i + 1) + ". " + title + " (" + star + ")");
                System.out.println("   Image URL: " + image_url);

                // 영화 객체 생성 및 리스트에 추가
                Movie movie = new Movie(title, star, learning_time, content, image_url);
                movie_data.add(movie);

                // 이미지 URL을 파일에 저장
                try {
                    FileWriter writer = new FileWriter("C:\\Users\\admin\\Desktop\\image_urls.txt", true);
                    writer.write(image_url + "\n");
                    writer.close();
                    System.out.println("이미지 URL이 파일에 저장되었습니다.");
                } catch (IOException e) {
                    System.out.println("파일에 이미지 URL을 저장하는 동안 오류가 발생했습니다: " + e.getMessage());
                }

                // 콘솔에 영화 정보 출력
                System.out.println("영화 정보:");
                System.out.println("제목: " + title);
                System.out.println("평점: " + star);
                System.out.println("러닝 타임: " + learning_time);
                System.out.println("내용: " + content);

                driver.navigate().back();
            }
        } catch (org.openqa.selenium.NoSuchElementException e) {
            // NoSuchElementException이 발생한 경우 처리할 코드 작성
            System.out.println("영화 정보를 가져오는 중에 오류가 발생했습니다: " + e.getMessage());
        }

        // 4. WebDriver 종료
        driver.quit();
    }
}
