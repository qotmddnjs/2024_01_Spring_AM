<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="ARTICLE DETAIL"></c:set>
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/toastUiEditorLib.jspf"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.demo.util.CgvDAO" %>
<%@ page import="com.example.demo.vo.CgvVO" %>
<%@ page import="com.example.demo.util.CgvService" %>

 <!-- <iframe src="http://localhost:8082/usr/article/doIncreaseHitCountRd?id=372" frameborder="0"></iframe> --> 
<!-- 변수 -->
<%--  <script>
	const params = {};
	params.id = parseInt('${param.id}');
	params.memberId = parseInt('${loginedMemberId}');
	
	console.log(params);
	console.log(params.memberId);
	
	var isAlreadyAddGoodRp = ${isAlreadyAddGoodRp};
	var isAlreadyAddBadRp = ${isAlreadyAddBadRp};
	
	
</script>

<!-- 조회수 -->
<script>
	function ArticleDetail__doIncreaseHitCount() {
		const localStorageKey = 'article__' + params.id + '__alreadyView';

		if (localStorage.getItem(localStorageKey)) {
			return;
		}

		localStorage.setItem(localStorageKey, true);

		$.get('../article/doIncreaseHitCountRd', {
			id : params.id,
			ajaxMode : 'Y'
		}, function(data) {
			$('.article-detail__hit-count').empty().html(data.data1);
		}, 'json');
	}

	$(function() {
		// 		ArticleDetail__doIncreaseHitCount();
		setTimeout(ArticleDetail__doIncreaseHitCount, 2000);
	});
</script>

<!-- 좋아요 싫어요  -->
<script>
<!-- 	<!-- 좋아요 싫어요 버튼	-->
	function checkRP() {
		if(isAlreadyAddGoodRp == true){
			$('#likeButton').toggleClass('btn-outline');
		}else if(isAlreadyAddBadRp == true){
			$('#DislikeButton').toggleClass('btn-outline');
		}else {
			return;
		}
	}
	
	function doGoodReaction(articleId) {
		if(isNaN(params.memberId) == true){
			if(confirm('로그인 해야해. 로그인 페이지로 가실???')){
				var currentUri = encodeURIComponent(window.location.href);
				window.location.href = '../member/login?afterLoginUri=' + currentUri; // 로그인 페이지에 원래 페이지의 uri를 같이 보냄
			}
			return;
		}
		
		$.ajax({
			url: '/usr/reactionPoint/doGoodReaction',
			type: 'POST',
			data: {relTypeCode: 'article', relId: articleId},
			dataType: 'json',
			success: function(data){
				console.log(data);
				console.log('data.data1Name : ' + data.data1Name);
				console.log('data.data1 : ' + data.data1);
				console.log('data.data2Name : ' + data.data2Name);
				console.log('data.data2 : ' + data.data2);
				if(data.resultCode.startsWith('S-')){
					var likeButton = $('#likeButton');
					var likeCount = $('#likeCount');
					var DislikeButton = $('#DislikeButton');
					var DislikeCount = $('#DislikeCount');
					
					if(data.resultCode == 'S-1'){
						likeButton.toggleClass('btn-outline');
						likeCount.text(data.data1);
					}else if(data.resultCode == 'S-2'){
						DislikeButton.toggleClass('btn-outline');
						DislikeCount.text(data.data2);
						likeButton.toggleClass('btn-outline');
						likeCount.text(data.data1);
					}else {
						likeButton.toggleClass('btn-outline');
						likeCount.text(data.data1);
					}
					
				}else {
					alert(data.msg);
				}
		
			},
			error: function(jqXHR,textStatus,errorThrown) {
				alert('좋아요 오류 발생 : ' + textStatus);

			}
			
		});
	}
	
	
	
	function doBadReaction(articleId) {
		
		if(isNaN(params.memberId) == true){
			if(confirm('로그인 해야해. 로그인 페이지로 가실???')){
				var currentUri = encodeURIComponent(window.location.href);
				window.location.href = '../member/login?afterLoginUri=' + currentUri; // 로그인 페이지에 원래 페이지의 uri를 같이 보냄
			}
			return;
		}
		
	 $.ajax({
			url: '/usr/reactionPoint/doBadReaction',
			type: 'POST',
			data: {relTypeCode: 'article', relId: articleId},
			dataType: 'json',
			success: function(data){
				console.log(data);
				console.log('data.data1Name : ' + data.data1Name);
				console.log('data.data1 : ' + data.data1);
				console.log('data.data2Name : ' + data.data2Name);
				console.log('data.data2 : ' + data.data2);
				if(data.resultCode.startsWith('S-')){
					var likeButton = $('#likeButton');
					var likeCount = $('#likeCount');
					var DislikeButton = $('#DislikeButton');
					var DislikeCount = $('#DislikeCount');
					
					if(data.resultCode == 'S-1'){
						DislikeButton.toggleClass('btn-outline');
						DislikeCount.text(data.data2);
					}else if(data.resultCode == 'S-2'){
						likeButton.toggleClass('btn-outline');
						likeCount.text(data.data1);
						DislikeButton.toggleClass('btn-outline');
						DislikeCount.text(data.data2);
		
					}else {
						DislikeButton.toggleClass('btn-outline');
						DislikeCount.text(data.data2);
					}
			
				}else {
					alert(data.msg);
				}
			},
			error: function(jqXHR,textStatus,errorThrown) {
				alert('싫어요 오류 발생 : ' + textStatus);
			}
			
		});
	}
	
	$(function() {
		checkRP();
	});
</script> -->

<!-- 댓글 -->
<script>
		var ReplyWrite__submitDone = false;

		function ReplyWrite__submit(form) {
			if (ReplyWrite__submitDone) {
				alert('이미 처리중입니다');
				return;
			}
			console.log(123);
			
			console.log(form.body.value);
			
			if (form.body.value.length < 3) {
				alert('댓글은 3글자 이상 입력해');
				form.body.focus();
				return;
			}

			ReplyWrite__submitDone = true;
			form.submit();

		}
</script>
<!-- 댓글 수정 -->
<script>
function toggleModifybtn(replyId) {
	
	console.log(replyId);
	
	$('#modify-btn-'+replyId).hide();
	$('#save-btn-'+replyId).show();
	$('#reply-'+replyId).hide();
	$('#modify-form-'+replyId).show();
}

function doModifyReply(replyId) {
	 console.log(replyId); // 디버깅을 위해 replyId를 콘솔에 출력
	    
	    // form 요소를 정확하게 선택
	    var form = $('#modify-form-' + replyId);
	    console.log(form); // 디버깅을 위해 form을 콘솔에 출력

	    // form 내의 input 요소의 값을 가져옵니다
	    var text = form.find('input[name="reply-text-' + replyId + '"]').val();
	    console.log(text); // 디버깅을 위해 text를 콘솔에 출력

	    // form의 action 속성 값을 가져옵니다
	    var action = form.attr('action');
	    console.log(action); // 디버깅을 위해 action을 콘솔에 출력
	
    $.post({
    	url: '/usr/reply/doModify', // 수정된 URL
        type: 'POST', // GET에서 POST로 변경
        data: { id: replyId, body: text }, // 서버에 전송할 데이터
        success: function(data) {
        	$('#modify-form-'+replyId).hide();
        	$('#reply-'+replyId).text(data);
        	$('#reply-'+replyId).show();
        	$('#save-btn-'+replyId).hide();
        	$('#modify-btn-'+replyId).show();
        },
        error: function(xhr, status, error) {
            alert('댓글 수정에 실패했습니다: ' + error);
        }
	})
}

</script>


 <section class="mt-8 text-xl px-4 ">
	<div class="">
		<table class="table-box-1 " border="1">
			<tbody>
				<tr>
					<th>번호</th>
					<td>${article.id }${goodRP}${badRP}</td>
				</tr>
				<tr>
					<th>작성날짜</th>
					<td>${article.regDate }</td>
				</tr>
				<tr>
					<th>수정날짜</th>
					<td>${article.updateDate }</td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>${article.extra__writer }</td>
				</tr>
				<tr>
					<th>좋아요</th>
					<td id="likeCount">${article.goodReactionPoint }</td>
				</tr>
				<tr>
					<th>싫어요</th>
					<td id="DislikeCount">${article.badReactionPoint }</td>
				</tr>
				<tr>
					<th>추천 ${usersReaction }</th>
					<td>
						<!-- href="/usr/reactionPoint/doGoodReaction?relTypeCode=article&relId=${param.id }&replaceUri=${rq.currentUri}" -->
						<button id="likeButton" class="btn btn-outline btn-success" onclick="doGoodReaction(${param.id})">좋아요</button>

						<button id="DislikeButton" class="btn btn-outline btn-error" onclick="doBadReaction(${param.id})">싫어요</button>
					</td>
				</tr>
				<tr>
					<th>조회수</th>
					<td>
						<span class="article-detail__hit-count">${article.hitCount }</span>
					</td>
				</tr>
				<tr>
					<th>제목</th>
					<td>${article.title }</td>
				</tr>
				<tr>
					<th>첨부 이미지</th>
					<td>
						<img class="w-full rounded-xl" src="${rq.getImgUri(article.id)}" onerror="${rq.profileFallbackImgOnErrorHtml}"
							alt="" />
						<div>${rq.getImgUri(article.id)}</div>
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<div class="toast-ui-viewer">
							<script type="text/x-template">${article.body}</script>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="btns mt-5">
			<button class="btn btn-outline" type="button" onclick="history.back();">뒤로가기</button>
			<c:if test="${article.userCanModify }">
				<a class="btn btn-outline" href="../article/modify?id=${article.id }">수정</a>
			</c:if>
			<c:if test="${article.userCanDelete }">
				<a class="btn btn-outline" onclick="if(confirm('정말 삭제하시겠습니까?') == false) return false;"
					href="../article/doDelete?id=${article.id }">삭제</a>
			</c:if>
		</div>
	</div>
</section>

<section class="mt-5 px-3">
	<c:if test="${rq.isLogined() }">
		<form action="../reply/doWrite" method="POST" onsubmit="ReplyWrite__submit(this); return false;">
			<input type="hidden" name="relTypeCode" value="article" />
			<input type="hidden" name="relId" value="${article.id }" />
			<table class="write-box table-box-1" border="1">
				<tbody>
					<tr>
						<th>내용</th>
						<td>
							<textarea class="input input-bordered input-primary w-full max-w-xs" autocomplete="off" placeholder="내용을 입력해주세요"
								name="body"> </textarea>
						</td>
					</tr>
					<tr>
						<th></th>
						<td>
							<input class="btn btn-outline btn-info" type="submit" value="댓글 작성" />
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</c:if>
	<c:if test="${!rq.isLogined() }">
		<a class="btn btn-outline btn-ghost" href="${rq.loginUri }">LOGIN</a> 하고 댓글 써
	</c:if>
	<div class="mx-auto">
		<h2>댓글 리스트(${repliesCount })</h2>
		<table class="table-box-1 table" border="1">
			<colgroup>
				<col style="width: 10%" />
				<col style="width: 20%" />
				<col style="width: 60%" />
				<col style="width: 10%" />
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th>날짜</th>
					<th>내용</th>
					<th>작성자</th>
					<th>좋아요</th>
					<th>싫어요</th>
					<th>수정</th>
					<th>삭제</th>
				</tr>
			</thead>
			<tbody>

				<c:forEach var="reply" items="${replies }">
					<tr class="hover">
						<td>${reply.id }</td>
						<td>${reply.regDate.substring(0,10) }</td>
						<td>
							<span id="reply-${reply.id }">${reply.body }</span>
							<form method="POST" id="modify-form-${reply.id }" style="display: none;" action="/usr/reply/doModify">
								<input type="text" value="${reply.body }" name="reply-text-${reply.id }" />
							</form>
						</td>
						<td>${reply.extra__writer }</td>
						<td>${reply.goodReactionPoint }</td>
						<td>${reply.badReactionPoint }</td>
						<td>
							<c:if test="${reply.userCanModify }">
															href="../reply/modify?id=${reply.id }"
								<button onclick="toggleModifybtn('${reply.id}');" id="modify-btn-${reply.id }" style="white-space: nowrap;"
									class="btn btn-outline">수정</button>
								<button onclick="doModifyReply('${reply.id}');" style="white-space: nowrap; display: none;"
									id="save-btn-${reply.id }" class="btn btn-outline">저장</button>
							</c:if>
						</td>
						<td>
							<c:if test="${reply.userCanDelete }">
								<a style="white-space: nowrap;" class="btn btn-outline"
									onclick="if(confirm('정말 삭제하시겠습니까?') == false) return false;" href="../reply/doDelete?id=${reply.id }">삭제</a>
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div> 

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
    var stillcuts = loadStillcuts(movieIndex);
    displayStillcuts(stillcuts);

});
</script>

   
</body>









<%@ include file="../common/foot.jspf"%>