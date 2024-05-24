<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="ARTICLE DETAIL"></c:set>
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/toastUiEditorLib.jspf"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.demo.dao.CgvDAO" %>
<%@ page import="com.example.demo.vo.CgvVO" %>
<%@ page import="com.example.demo.service.CgvService" %>

<body class="detail" style="background-color: black; color: white; margin: 0; padding: 0;">
    <div style="text-align: left; padding: 20px;">
        <h1 style="font-size: 24px;">상세정보</h1>
        <%-- 영화 목록을 가져와서 JavaScript 배열로 변환 --%>
        <%
            List<CgvVO> movies = new CgvDAO().getMovies();
            int index = Integer.parseInt(request.getParameter("index")); // URL 매개변수에서 영화의 인덱스를 가져옴
            CgvVO movie = movies.get(index); // 해당 인덱스의 영화를 가져옴
        %>
        <div>
            <!-- 영화 이미지 -->
            <div style="float: left; margin-left:400px; margin-right: 100px;">
            
                <img src="<%= movie.getImage() %>" alt="<%= movie.getTitle() %>" style="width: 600px; height: auto;">
            </div>
            
            <!-- 제목, 장르, 감독 및 배우 -->
            <div style="overflow: hidden; margin-top: 20px; margin-bottom: 20px; margin-right:300px;font-size: 24px;">
                <p><strong>제목:</strong> <%= movie.getTitle() %></p>
                <br>
                <p><strong>장르: SF판타지</strong> <%= movie.getGenre() %></p>
                <br>
                <p><strong>감독:</strong> <%= movie.getDirector() %></p>
                <br>
                <p><strong>배우:</strong> <%= movie.getActors() %></p> <!-- 배우 정보 추가 -->
                <br>
                <!-- 기타 영화의 상세 정보를 표시할 수 있습니다 -->
                <div>
                    <p><strong>상세:</strong> <%= movie.getDetail() %></p> <!-- 상세 정보 추가 -->
                </div>
            </div>
            <br>
            <br>
            <br>
            <br>
            <br>
            
            
            <!-- 스틸컷 이미지 -->
            <div style="clear: both; margin-left:400px;">
               
                 <br>
            <br>
            <br>
            
           <div class="stillcut-gallery">
    <img src="https://img.cgv.co.kr/Movie/Thumbnail/StillCut/000088/88148/88148224378_727.jpg" alt="Stillcut 1">
    <img src="https://img.cgv.co.kr/Movie/Thumbnail/StillCut/000088/88148/88148225267_727.jpeg" alt="Stillcut 2">
    <img src="https://img.cgv.co.kr/Movie/Thumbnail/StillCut/000088/88148/88148225268_727.jpg" alt="Stillcut 3">
    <img src="https://img.cgv.co.kr/Movie/Thumbnail/StillCut/000088/88148/88148225266_727.jpg" alt="Stillcut 4">
    <img src="https://img.cgv.co.kr/Movie/Thumbnail/StillCut/000088/88148/88148225269_727.jpeg" alt="Stillcut 5">
    <img src="https://img.cgv.co.kr/Movie/Thumbnail/StillCut/000088/88148/88148225270_727.jpeg" alt="Stillcut 6">
</div>

<style>
    .stillcut-gallery {
        display: flex;
        flex-wrap: nowrap;
        overflow-x: auto;
        padding: 10px 0;
    }
    .stillcut-gallery img {
        margin-right: 10px;
        height: auto;
        width: 250px;
    }
    .stillcut-gallery img:last-child {
        margin-right: 0;
    }
</style>
                <div id="stillcutGallery" style="display: flex; flex-wrap: wrap;">
                    <%-- Display still-cut images --%>
                    <%
                    List<String> stillcutUrls = movie.getStillcuts(); // 수정된 부분
                        if (stillcutUrls != null) {
                            for (String stillcutUrl : stillcutUrls) {
                    %>
                                <img src="<%= stillcutUrl %>" alt="Stillcut Image" style="width: 200px; height: auto; margin: 5px;">
                    <%
                            }
                        }
                    %>
                </div>
            </div>
          <!-- Like and Dislike Buttons -->
<div style="clear: both; margin-left:400px; margin-top: 20px;">
    <button id="likeButton" style="font-size: 20px; margin-right: 10px; background-color: #4CAF50; color: white; border: none; padding: 10px 20px; border-radius: 5px; cursor: pointer;">좋아요</button>
    <button id="dislikeButton" style="font-size: 20px; background-color: #f44336; color: white; border: none; padding: 10px 20px; border-radius: 5px; cursor: pointer;">싫어요</button>
    <p id="likeCount" style="font-size: 16px;">좋아요: 0</p>
    <p id="dislikeCount" style="font-size: 16px;">싫어요: 0</p>
</div>
            <!-- Comment Form -->
            <div style="clear: both; margin-left:400px; margin-top: 20px;">
                <h2 style="font-size: 20px;">댓글</h2>
                <form id="commentForm" style="margin-top: 10px;">
                    <textarea id="commentText" rows="4" cols="50" placeholder="댓글을 입력하세요..." style="font-size: 16px;"></textarea><br>
                    <button type="button" id="submitComment" style="font-size: 16px; margin-top: 10px;">댓글 달기</button>
                </form>
                <div id="commentSection" style="margin-top: 20px; font-size: 16px;">
                    <!-- Comments will be displayed here -->
                </div>
            </div>
        </div>
    </div>
</body>
<script>
document.addEventListener("DOMContentLoaded", function () {
    var movieIndex = <%= index %>; // JSP 변수로부터 영화의 인덱스를 가져옴

    function loadStillcuts(movieIndex) {
        var stillcutUrls = []; // 스틸컷 이미지 URL을 저장할 배열

        // AJAX 요청을 보냅니다.
        var xhr = new XMLHttpRequest();
        xhr.open('GET', '/getStillcuts?index=' + movieIndex, true); // 서버에 영화 인덱스를 전달하여 이미지 URL을 가져옵니다.
        xhr.onreadystatechange = function () {
            if (xhr.readyState == 4 && xhr.status == 200) {
                // 요청이 성공하고 응답을 받았을 때,
                var response = JSON.parse(xhr.responseText); // 서버로부터 받은 JSON 형태의 응답을 파싱합니다.
                stillcutUrls = response.stillcutUrls; // 서버에서 받은 이미지 URL들을 배열에 저장합니다.
                displayStillcuts(stillcutUrls); // 가져온 이미지 URL들을 표시하는 함수를 호출합니다.
            }
        };
        xhr.send();

        return stillcutUrls; // 이미지 URL 배열을 반환합니다.
    }

    // 가져온 이미지 URL들을 화면에 표시하는 함수
    function displayStillcuts(stillcutUrls) {
        var stillcutGallery = document.getElementById("stillcutGallery");
        stillcutGallery.innerHTML = ""; // 이미지를 표시하기 전에 기존의 내용을 모두 지웁니다.

        stillcutUrls.forEach(function (stillcutUrl) {
            var img = document.createElement("img");
            img.src = stillcutUrl;
            img.style.width = "200px";
            img.style.height = "auto";
            img.style.margin = "5px";
            stillcutGallery.appendChild(img);
        });
    }

    // 추가로 스틸컷 이미지를 가져와서 화면에 표시합니다.
    var stillcuts = loadStillcuts(movieIndex);
    displayStillcuts(stillcuts);

    // Handle like and dislike button clicks
    var likeCount = 0;
    var dislikeCount = 0;

    document.getElementById("likeButton").addEventListener("click", function() {
        likeCount++;
        document.getElementById("likeCount").innerText = "Likes: " + likeCount;
    });

    document.getElementById("dislikeButton").addEventListener("click", function() {
        dislikeCount++;
        document.getElementById("dislikeCount").innerText = "Dislikes: " + dislikeCount;
    });

    // Handle comment submission
    document.getElementById("submitComment").addEventListener("click", function() {
        var commentText = document.getElementById("commentText").value;
        if (commentText.trim() !== "") {
            var commentSection = document.getElementById("commentSection");
            var comment = document.createElement("p");
            comment.innerText = commentText;
            commentSection.appendChild(comment);
            document.getElementById("commentText").value = ""; // Clear the textarea
        }
    });
});
</script>

<%@ include file="../common/foot.jspf"%>