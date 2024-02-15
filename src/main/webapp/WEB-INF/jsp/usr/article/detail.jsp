<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="ARTICLE DETAIL"></c:set>
<%@ include file="../common/head.jspf"%>

<!-- <iframe src="http://localhost:8081/usr/article/doIncreaseHitCountRd?id=372" frameborder="0"></iframe> -->
<script>
	const params = {};
	params.id = parseInt('${param.id}');
</script>

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
	})
</script>
<script>
	$(function() {
		ArticleDetail__increaseHitCount();
	})

	function checkAddRpBefore() {
    <!-- 변수값에 따라 각 id가 부여된 버튼에 클래스 추가(이미 눌려있다는 색상 표시) -->
		if (isAlreadyAddGoodRp == true) {
			$("#add-goodRp-btn").addClass("already-added");
		} else if (isAlreadyAddBadRp == true) {
			$("#add-badRp-btn").addClass("already-added");
		} else {
			return;
		}
		$(function() {
			checkAddRpBefore();
		});
	};
</script>
<script>
	$(document).ready(function() {
		<!-- 각 id가 부여된 버튼 클릭 시 로그인 요청 메시지 발송 -->
        $("#request-login-good").click(function() {
			alert('로그인 후 이용해주세요!');
			return;
		});
		$("#request-login-bad").click(function() {
			alert('로그인 후 이용해주세요!');
			return;
		});
        
        <!-- jsp 실행 이전의 리액션 여부 체크 및 버튼 색상 표현 -->
		$(function() {
			checkAddRpBefore();
		});
        
        <!-- 좋아요 버튼 클릭 이벤트 및 ajax 실행 -->
		$("#add-goodRp-btn").click(function() {
			
            <!-- 이미 싫어요가 눌려 있는 경우 반려 -->
            if (isAlreadyAddBadRp == true) {
				alert('이미 싫어요를 누르셨습니다.');
				return;
			}
            
            <!-- 좋아요가 눌려 있지 않은 경우 좋아요 1 추가 -->
			if (isAlreadyAddGoodRp == false) {
				$.ajax({
					url : "/usr/reactionPoint/increaseGoodRp",
					type : "POST",
					data : {
						id : params.id
					},
					success : function(goodReactionPoint) {
						$("#add-goodRp-btn").addClass("already-added");
						$(".add-goodRp").html(goodReactionPoint);
						isAlreadyAddGoodRp = true;
					},
					error : function() {
						alert('서버 에러, 다시 시도해주세요.');
					}
				});
                
              <!-- 이미 좋아요가 눌려 있는 경우 좋아요 1 감소 -->  
			} else if (isAlreadyAddGoodRp == true){
				$.ajax({
					url : "/usr/reactionPoint/decreaseGoodRp",
					type : "POST",
					data : {
						id : params.id
					},
					success : function(goodReactionPoint) {
						$("#add-goodRp-btn").removeClass("already-added");
						$(".add-goodRp").html(goodReactionPoint);
						isAlreadyAddGoodRp = false;
					},
					error : function() {
						alert('서버 에러, 다시 시도해주세요.');
					}
				});
			} else {
				return;
			}
		});
        
        <!-- 싫어요 버튼 클릭 이벤트 및 ajax 실행 -->
		$("#add-badRp-btn").click(function() {
			
            <!-- 이미 좋아요가 눌려 있는 경우 반려 -->
            if (isAlreadyAddGoodRp == true) {
				alert('이미 좋아요를 누르셨습니다.');
				return;
			}
            
            <!-- 싫어요가 눌려 있지 않은 경우 싫어요 1 추가 -->
			if (isAlreadyAddBadRp == false) {
				$.ajax({
					url : "/usr/reactionPoint/increaseBadRp",
					type : "POST",
					data : {
						id : params.id
					},
					success : function(badReactionPoint) {
						$("#add-badRp-btn").addClass("already-added");
						$(".add-badRp").html(badReactionPoint);
						isAlreadyAddBadRp = true;
					},
					error : function() {
						alert('서버 에러, 다시 시도해주세요.');
					}
				});
                
              <!-- 이미 싫어요가 눌려 있는 경우 싫어요 1 감소 --> 
			} else if (isAlreadyAddBadRp == true) {
				$.ajax({
					url : "/usr/reactionPoint/decreaseBadRp",
					type : "POST",
					data : {
						id : params.id
					},
					success : function(badReactionPoint) {
						$("#add-badRp-btn").removeClass("already-added");
						$(".add-badRp").html(badReactionPoint);
						isAlreadyAddBadRp = false;
					},
					error : function() {
						alert('서버 에러, 다시 시도해주세요.');
					}
				});
			} else {
				return;
			}
		});
	});
</script>
<style type="text/css">
.already-added {
	background-color: #0D3EA3;
	color: white;
}
</style>

<section class="mt-8 text-xl px-4">
	<div class="mx-auto">
		<table class="table-box-1" border="1">
			<tbody>
				<tr>
					<th>번호</th>
					<td>${article.id }</td>
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
					<th>제목</th>
					<td>${article.title }</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>${article.body }</td>
				</tr>
				<tr>
					<th>조회수</th>
					<td><span class="article-detail__hit-count">${article.hitCount }</span></td>
				</tr>
			</tbody>
		</table>
		<div class="btns mt-5">
			<button class="btn btn-outline" type="button" onclick="history.back();">뒤로가기</button>
			<button class="btn btn-outline" type="button" onclick="">좋아요👍</button> 
			<button class="btn btn-outline" type="button" onclick="">싫어요👎</button>
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



<%@ include file="../common/foot.jspf"%>