package com.example.demo.vo;

import java.util.List;

public class CgvVO {
    private String title;
    private String image;
    private String genre;
    private String director;
    private String actors;
    private int bookcnt;
    private String detail;
    private List<String> stillcuts; // List to store multiple still-cut URLs

    // Getters and Setters

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

    public String getDirector() {
        return director;
    }

    public void setDirector(String director) {
        this.director = director;
    }

    public String getActors() {
        return actors;
    }

    public void setActors(String actors) {
        this.actors = actors;
    }

    public List<String> getStillcuts() {
        return stillcuts;
    }

    public void setStillcuts(List<String> stillcuts) {
        this.stillcuts = stillcuts;
    }
}
