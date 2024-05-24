package com.example.demo.dao;

import com.example.demo.util.DatabaseUtil;
import com.example.demo.vo.MovieScheduleVO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;


@Repository
public class MovieScheduleDAO {

    public void insertMovieSchedule(MovieScheduleVO movieSchedule) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = DatabaseUtil.getConnection();
            if (connection != null) {
                String insertQuery = "INSERT INTO movie_schedule (wide_area, base_area, theater, title, screening_times) VALUES (?, ?, ?, ?, ?)";
                preparedStatement = connection.prepareStatement(insertQuery);
                preparedStatement.setInt(1, movieSchedule.getWideAreaIndex());
                preparedStatement.setString(2, movieSchedule.getBaseArea());
                preparedStatement.setString(3, movieSchedule.getTheater());
                preparedStatement.setString(4, movieSchedule.getTitle());
                preparedStatement.setString(5, movieSchedule.getScreeningTimes());
                preparedStatement.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public List<MovieScheduleVO> getAllMovieSchedules() {
        List<MovieScheduleVO> movieSchedules = new ArrayList<>();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseUtil.getConnection();
            if (connection != null) {
                String selectQuery = "SELECT * FROM movie_schedule";
                preparedStatement = connection.prepareStatement(selectQuery);
                resultSet = preparedStatement.executeQuery();
                while (resultSet.next()) {
                    int wideAreaIndex = resultSet.getInt("wide_area");
                    String baseArea = resultSet.getString("base_area");
                    String theater = resultSet.getString("theater");
                    String title = resultSet.getString("title");
                    String screeningTimes = resultSet.getString("screening_times");
                    MovieScheduleVO movieSchedule = new MovieScheduleVO(wideAreaIndex, baseArea, theater, title, screeningTimes);
                    movieSchedules.add(movieSchedule);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return movieSchedules;
    }
}
