package com.example.demo.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.example.demo.vo.CgvVO;

public class CgvDAO {
    // 데이터베이스 연결 객체
    private Connection conn;

    // 생성자: DatabaseUtil 클래스의 getConnection 메서드를 사용하여 데이터베이스 연결을 얻음
    public CgvDAO() {
        conn = DatabaseUtil.getConnection();
    }

    // 영화 정보를 데이터베이스에 삽입하는 메서드
    public void insert(CgvVO vo) {
        PreparedStatement pstmt = null;
        try {
            // SQL 문을 준비하여 실행
            String sql = "INSERT INTO movies (title, image, genre, director, actors, detail) VALUES (?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, vo.getTitle());
            pstmt.setString(2, vo.getImage());
            pstmt.setString(3, vo.getGenre());
            pstmt.setString(4, vo.getDirector()); // 감독 정보 삽입
            pstmt.setString(5, vo.getActors()); // 배우 정보 삽입
            pstmt.setString(6, vo.getDetail()); // 상세 정보 삽입
            pstmt.executeUpdate();

            // 영화의 스틸컷 이미지 URL을 저장하는 부분
            List<String> stillcuts = vo.getStillcuts();
            if (stillcuts != null && !stillcuts.isEmpty()) {
                for (String stillcut : stillcuts) {
                    insertStillcut(vo.getTitle(), stillcut);
                }
            }

            System.out.println("Inserted movie: " + vo.getTitle());
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // 자원 해제
            try {
                if (pstmt != null) {
                    pstmt.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // 영화의 스틸컷 이미지 URL을 데이터베이스에 삽입하는 메서드
    private void insertStillcut(String title, String stillcut) {
        PreparedStatement pstmt = null;
        try {
            String sql = "INSERT INTO stillcuts (title, stillcut_url) VALUES (?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, title);
            pstmt.setString(2, stillcut);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // 자원 해제
            try {
                if (pstmt != null) {
                    pstmt.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // 영화 목록 가져오기
    public List<CgvVO> getMovies() {
        List<CgvVO> movies = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            String sql = "SELECT title, image, genre, director, actors, detail FROM movies";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                CgvVO movie = new CgvVO();
                movie.setTitle(rs.getString("title"));
                movie.setImage(rs.getString("image"));
                movie.setGenre(rs.getString("genre"));
                movie.setDirector(rs.getString("director")); // 감독 정보 설정
                movie.setActors(rs.getString("actors")); // 배우 정보 설정
                movie.setDetail(rs.getString("detail")); // 상세 정보 설정

                // 영화의 스틸컷 이미지 URL을 가져와서 설정하는 부분
                List<String> stillcuts = getStillcuts(movie.getTitle());
                movie.setStillcuts(stillcuts);

                movies.add(movie);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // 자원 해제
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return movies;
    }

    // 영화의 스틸컷 이미지 URL 목록을 가져오는 메서드
    private List<String> getStillcuts(String title) {
        List<String> stillcuts = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            String sql = "SELECT stillcut_url FROM stillcuts WHERE title = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, title);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                stillcuts.add(rs.getString("stillcut_url"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // 자원 해제
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return stillcuts;
    }
}
