package com.example.demo.repository;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.io.IOException;

public class MovieCrawler {
    public static void main(String[] args) {
        String url = "https://www.kobis.or.kr/kobis/business/mast/mvie/searchMovieList.do#none";

        try {
            Document doc = Jsoup.connect(url).get();
            Elements movieList = doc.select("div.movie_list");

            for (Element movie : movieList) {
                String title = movie.select("a").text();
                String releaseDate = movie.select("span").text();
                System.out.println("Title: " + title);
                System.out.println("Release Date: " + releaseDate);
                System.out.println("------------------------");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
