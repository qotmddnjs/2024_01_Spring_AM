package com.example.demo.vo;

public class CgvVO {
    private String title;
    private String image;
    private String genre;
    private String director; // 감독 정보 추가
    private String actors; // 배우 정보 추가
    private int bookcnt;
    private String detail;
    private String stillcut; // 스틸컷 이미지 URL 추가

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getBookcnt() {
        return bookcnt;
    }

    public void setBookcnt(int bookcnt) {
        this.bookcnt = bookcnt;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    // 감독 정보 설정
    public String getDirector() {
        return director;
    }

    public void setDirector(String director) {
        this.director = director;
    }

    // 배우 정보 설정
    public String getActors() {
        return actors;
    }

    public void setActors(String actors) {
        this.actors = actors;
    }

    // 스틸컷 이미지 URL 설정
    public String getStillcut() {
        return stillcut;
    }

    public void setStillcut(String stillcut) {
        this.stillcut = stillcut;
    }
}
