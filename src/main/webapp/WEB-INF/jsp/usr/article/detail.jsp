<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="ARTICLE DETAIL"></c:set>
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/toastUiEditorLib.jspf"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.demo.util.CgvDAO" %>
<%@ page import="com.example.demo.vo.CgvVO" %>
<%@ page import="com.example.demo.util.CgvService" %>



</section>  --%>
<body class="detail" style="background-color: black; color: white; margin: 0; padding: 0;">
    <div style="text-align: left; padding: 20px;">
        <h1 style="font-size: 24px;">영화 상세정보</h1>
        <%-- 영화 목록을 가져와서 JavaScript 배열로 변환 --%>
        <%
            List<CgvVO> movies = new CgvDAO().getMovies();
            int index = Integer.parseInt(request.getParameter("index")); // URL 매개변수에서 영화의 인덱스를 가져옴
            CgvVO movie = movies.get(index); // 해당 인덱스의 영화를 가져옴
        %>
        <div>
            <!-- 영화 이미지 -->
            <div style="float: left; margin-left:400px; margin-right: 20px;">
                <img src="<%= movie.getImage() %>" alt="<%= movie.getTitle() %>" style="width: 700px; height: auto;">
            </div>
            <!-- 제목, 장르, 감독 및 배우 -->
            <div style="overflow: hidden; margin-top: 20px; margin-bottom: 20px; margin-right:400px;font-size: 24px;">
                <p><strong>제목:</strong> <%= movie.getTitle() %></p>
                <p><strong>장르:</strong> <%= movie.getGenre() %></p>
                <p><strong>감독:</strong> <%= movie.getDirector() %></p>
                <p><strong>배우:</strong> <%= movie.getActors() %></p> <!-- 배우 정보 추가 -->
                <!-- 기타 영화의 상세 정보를 표시할 수 있습니다 -->
                <div >
                <p><strong>상세:</strong> <%= movie.getDetail() %></p> <!-- 상세 정보 추가 -->
                </div>
            </div>
            <!-- 스틸컷 이미지 -->
            <div style="clear: both; margin-left:400px;">
                <h2 style="font-size: 20px; margin-top: 20px;">스틸컷 이미지</h2>
                <div id="stillcutGallery" style="display: flex; flex-wrap: wrap;">
                    <!-- 이 곳에 스틸컷 이미지를 표시할 영역을 만들 것입니다. -->
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

    // 댓글 목록 로드 및 표시
    var commentList = document.getElementById("commentList");
    var comments = loadComments(movieIndex);
    comments.forEach(function (comment) {
        var li = document.createElement("li");
        li.textContent = comment;
        commentList.appendChild(li);
    });
    function saveComment(movieIndex, comment) {
        console.log("댓글 저장 함수 호출됨: 인덱스 =", movieIndex, "댓글 =", comment);
    }
 // 댓글 폼 제출 이벤트 리스너
    var commentForm = document.getElementById("commentForm");
    commentForm.addEventListener("submit", function (event) {
        event.preventDefault(); // 기본 제출 동작 방지
        var commentInput = document.getElementById("commentInput");
        var comment = commentInput.value.trim(); // 입력된 댓글 가져오기s
        if (comment !== "") {
            // 댓글 저장하고 UI에 표시
            saveComment(movieIndex, comment);
            var li = document.createElement("li");
            li.textContent = comment;
            commentList.appendChild(li);
            // 입력 필드 비우기
            commentInput.value = "";
        }
    });
 // 추가로 스틸컷 이미지를 가져와서 화면에 표시합니다.
/*     var stillcuts = loadStillcuts(movieIndex);
    displayStillcuts(stillcuts);

}); */
</script>

   
</body>









<%@ include file="../common/foot.jspf"%>