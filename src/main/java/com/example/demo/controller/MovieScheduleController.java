package com.example.demo.controller;

import com.example.demo.dao.MovieScheduleDAO;
import com.example.demo.vo.MovieScheduleVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class MovieScheduleController {

    private final MovieScheduleDAO movieScheduleDAO;

    @Autowired
    public MovieScheduleController(MovieScheduleDAO movieScheduleDAO) {
        this.movieScheduleDAO = movieScheduleDAO;
    }

    @GetMapping("/getMovieScheduleData")
    public List<MovieScheduleVO> getMovieScheduleData() {
        // 데이터베이스에서 영화 일정 데이터 가져오기
        List<MovieScheduleVO> movieScheduleList = movieScheduleDAO.getAllMovieSchedules();

        // 가져온 데이터를 JSON 형식으로 반환
        return movieScheduleList;
    }
}
