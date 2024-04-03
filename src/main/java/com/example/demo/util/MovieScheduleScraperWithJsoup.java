package com.example.demo.util;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.io.IOException;

public class MovieScheduleScraperWithJsoup {
    public static void main(String[] args) {
        try {
            // 웹 페이지 열기
            Document doc = Jsoup.connect("https://www.kobis.or.kr/kobis/business/mast/thea/findTheaterSchedule.do").get();

            // 페이지 소스코드 가져오기
            String htmlSource = doc.html();

            // Jsoup을 사용하여 페이지 파싱
            Document parsedDoc = Jsoup.parse(htmlSource);

            // 모든 step에 대해 순차적으로 정보 가져오기
            Elements steps = parsedDoc.select(".schedule .step");
            for (Element step : steps) {
                // 각 step의 라벨 텍스트 가져오기
                String labelText = step.select("label").text();
                System.out.println(labelText);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
