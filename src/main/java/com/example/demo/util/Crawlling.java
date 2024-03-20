package com.example.demo.util;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.util.Iterator;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import com.example.demo.vo.CgvVO;

public class Crawlling {
    public static void sample() {

        String cgvUrl = "http://www.cgv.co.kr/movies/?lt=1&ft=0"; // 크롤링하려는 페이지의 url
        Document doc = null; // Document 객체 생성
        URL url = null; // URL 객체생성
        InputStream in = null; // InputStream 객체 생성
        OutputStream out = null; // OutputStream 객체 생성

        try {
            doc = Jsoup.connect(cgvUrl).get(); // Jsoup 클래스로 url 연결하여 정보를 doc에 담음

        } catch (IOException e) {
            e.printStackTrace();
        }

        String title = "strong.title"; // 영화제목
        Elements eles1 = doc.select(title); // 해당 url에서 영화 제목 정보만 eles1에 담음

        String img = ".thumb-image > img"; // 이미지
        Elements eles2 = doc.select(img); // 해당 url에서 영화 이미지 정보만 eles2에 담음

        String category = "div.box-image>a"; // 장르
        Elements eles3 = doc.select(category); // 해당 url에서 영화 장르를 추출하기위한 정보를 eles3에 담음

        Iterator<Element> itr1 = eles1.iterator(); // 영화제목 정보를 요소 별로 분리
        Iterator<Element> itr2 = eles2.iterator(); // 이미지 정보를 요소 별로 분리
        Iterator<Element> itr3 = eles3.iterator(); // 장르 정보를 요소 별로 분리

        int N = 1; // png 파일에 붙을 숫자
        int num = 0;
        while (itr3.hasNext()) { // itr3의 정보를 모두 나타낼때까지 반복
            try {
                CgvVO vo = new CgvVO();
                CgvDAO cDAO = new CgvDAO();

                String img2 = itr2.next().attr("src"); // 영화 이미지 정보의 속성값인 src(이미지 주소)를 담음
                url = new URL(img2); // url 객체에 이미지 주소를 담음, 열림 1
                in = url.openStream(); // in 객체에 url 정보 담음(받고싶은 데이터 연결)
                out = new FileOutputStream(
                        "C:\\Users\\admin\\git\\2024_01_Spring_AM\\image_urls\\" + N + ".png"); // out 객체에 저장경로(저장을 원하는 위치) 입력
                N++;
                while (true) {
                    int data = in.read(); // in 객체로 해당 이미지를 읽어들임

                    if (data == -1) { // 더이상 읽을것이 없으면 멈춤
                        break;
                    }
                    out.write(data); // 읽어들인 데이터를 경로에 작성
                }
                in.close(); // 저장이 끝난후 사용한 객체는 close, 닫음 1
                out.close();

                String title2 = itr1.next().text(); // 태그를 제외한 영화 제목 정보를 담음
                String category2 = itr3.next().attr("href"); // 장르를 정제하기 위해 속성값 href(상세정보 페이지) 추출
                System.out.println(category2);
                String str = "https://www.cgv.co.kr/movies/detail-view/?" + category2.substring(21,
                        category2.length());
                // 추출한 주소에서 다시 한번 원하는 영화의 midindex 추출 (개별 영화의 상세정보 페이지)

                String cgvUrl2 = str; // 개별 영화의 상세정보 페이지
                Document doc2 = null;
                try {
                    doc2 = Jsoup.connect(cgvUrl2).get(); // 상세정보 페이지에 연결하여 정보를 담음

                } catch (IOException e) {
                    e.printStackTrace();
                }

                // 감독, 배우, 장르 등등 정보가 있는 요소 선택
             // 감독, 배우, 장르 등등 정보가 있는 요소 선택
                Elements categoryElements = doc2.select("div.spec");
                for (Element categoryElement : categoryElements) {
                    // categoryElement의 내용 출력
                    System.out.println("categoryElement 내용: " + categoryElement.text());

                    // 감독 정보 추출
                    String director = categoryElement.select("dt:contains(감독)").next().text();
                    System.out.println("감독: " + director);
                    vo.setDirector(director);

                    // 배우 정보 추출
                    String actors = categoryElement.select("dt:contains(배우)").next().text();
                    System.out.println("배우: " + actors);
                    vo.setActors(actors);

                    // 장르 정보 추출
                    String genre = null;
                    Element dtElement = categoryElement.select("dt:contains(장르)").first(); // 장르 정보를 포함하는 첫 번째 <dt> 태그 선택
                    if (dtElement != null) {
                        Element ddElement = dtElement.nextElementSibling(); // 선택된 <dt> 태그의 다음 형제 요소인 <dd> 태그 선택
                        if (ddElement != null) {
                            genre = ddElement.text(); // <dd> 태그의 텍스트를 장르로 설정
                            System.out.println("장르: " + genre);
                            vo.setGenre(genre);
                        }
                    }
                }


                // 영화소개 및 상세정보 부분
                String detail = doc2.select("div.sect-story-movie").text(); // 첫 번째 p 태그 선택
                System.out.println("상세정보: " + detail);
                vo.setDetail(detail);


                vo.setTitle(title2); // 객체에 영화제목 입력
                vo.setImage(img2); // 이미지 입력
                vo.setBookcnt(num); // 예매횟수 기본값 설정
                cDAO.insert(vo); // DAO의 insert 함수로 DB에 영화정보 추가
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    in.close();
                    out.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
