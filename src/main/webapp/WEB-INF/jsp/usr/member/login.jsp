<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="LOGIN"></c:set>
<%@ include file="../common/head.jspf"%>


<%-- <section class="mt-8 text-xl px-4">
	<div class="mx-auto">
		<form action="../member/doLogin" method="POST">
			<input type="hidden" name="afterLoginUri" value="${param.afterLoginUri }" />
			<table class="login-box table-box-1" border="1">
				<tbody>
					<tr>
						<th>아이디</th>
						<td>
							<input class="input input-bordered input-primary w-full max-w-xs" autocomplete="off" type="text"
								placeholder="아이디를 입력해주세요" name="loginId" />
						</td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td>
							<input class="input input-bordered input-primary w-full max-w-xs" autocomplete="off" type="text"
								placeholder="비밀번호를 입력해주세요" name="loginPw" />
						</td>
					</tr>
					<tr>
						<th></th>
						<td>
							<input class="btn btn-outline btn-info" type="submit" value="로그인" />
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		<div class="btns">
			<button class="btn btn-outline" type="button" onclick="history.back();">뒤로가기</button>
		</div>
	</div> --%>
</section>
<div class="login-container">
    <div class="loginimg"></div> <!-- 배경 이미지가 적용될 요소 -->
    <div class="login-form-container">
        <form action="../member/doLogin" method="POST" class="loginform">
            <input type="hidden" name="afterLoginUri" value="${param.afterLoginUri }" />
            <h1><span>Movie</span> Time</h1>
            <input placeholder="Username" type="text" name="loginId"/>
            <input placeholder="Password" type="password" name="loginPw"/>
            <button class="btn btn-outline btn-info" type="submit" value="로그인">Log in</button>
            <h6>또는?</h6>
            <div class="social">
                <!-- 카카오 로그인 버튼 -->
                <a id="kakao-login-btn" >
                    <img src=/>
                </a>
                <!-- 구글 로그인 버튼 -->
                <a href="C:\BSW\img\signin-assets\signin-assets\Web (mobile + desktop)\png@1x\dark">
                <img src=/>
                </a>
            </div>	
        </form>
        <footer>
            <h5>처음이신가요? <a target="_blank" href="../member/join">회원가입</a></h5>
        </footer>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>
    // 카카오 로그인 버튼을 클릭했을 때 실행될 함수
    function kakaoLogin() {
        // 카카오 로그인 API를 호출
        Kakao.Auth.login({
            success: function(authObj) {
                // 로그인 성공 시 필요한 처리를 여기에 작성
                console.log('로그인 성공', authObj);
            },
            fail: function(err) {
                // 로그인 실패 시 필요한 처리를 여기에 작성
                console.error('로그인 실패', err);
            }
        });
    }

    // 페이지 로드 후 실행될 함수
    document.addEventListener('DOMContentLoaded', function() {
        // 카카오 SDK 초기화
        Kakao.init('efa075476b540c33dce8d7c80228c3b4');

        // 카카오 로그인 버튼에 이벤트 리스너 등록
        document.getElementById('kakao-login-btn').addEventListener('click', function() {
            kakaoLogin(); // 클릭 시 카카오 로그인 함수 호출
        });
    });
    success: function(authObj) {
        // 로그인 성공 시 필요한 처리를 여기에 작성
        console.log('로그인 성공', authObj);

        // 로그인 버튼 대신 로그아웃 버튼으로 변경
        var logoutBtn = document.createElement('button');
        logoutBtn.textContent = '로그아웃';
        logoutBtn.onclick = function() {
            // 로그아웃 기능 수행
            Kakao.Auth.logout(function() {
                console.log('로그아웃 완료');
                // 사용자 인터페이스 업데이트 (예: 로그인 버튼으로 변경)
            });
        };
        document.getElementById('kakao-login-btn').parentNode.replaceChild(logoutBtn, document.getElementById('kakao-login-btn'));
    },
 
</script>

<script>
$(document).ready(function(e){
   $('h6').on('click',function(){
      $('.social').stop().slideToggle();
   });
})
</script>


<%@ include file="../common/foot.jspf"%>