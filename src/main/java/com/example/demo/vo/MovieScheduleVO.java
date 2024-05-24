package com.example.demo.vo;

public class MovieScheduleVO {
    private int wideAreaIndex;
    private String baseArea;
    private String theater;
    private String title;
    private String screeningTimes;

    // Constructor
    public MovieScheduleVO(int wideAreaIndex, String baseArea, String theater, String title, String screeningTimes) {
        this.wideAreaIndex = wideAreaIndex;
        this.baseArea = baseArea;
        this.theater = theater;
        this.title = title;
        this.screeningTimes = screeningTimes;
    }

    // Getters and Setters
    public int getWideAreaIndex() {
        return wideAreaIndex;
    }

    public void setWideAreaIndex(int wideAreaIndex) {
        this.wideAreaIndex = wideAreaIndex;
    }

    public String getBaseArea() {
        return baseArea;
    }

    public void setBaseArea(String baseArea) {
        this.baseArea = baseArea;
    }

    public String getTheater() {
        return theater;
    }

    public void setTheater(String theater) {
        this.theater = theater;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getScreeningTimes() {
        return screeningTimes;
    }

    public void setScreeningTimes(String screeningTimes) {
        this.screeningTimes = screeningTimes;
    }
}
