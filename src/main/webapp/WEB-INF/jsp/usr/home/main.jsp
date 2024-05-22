<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MAIN"></c:set>
<%@ include file="../common/head.jspf"%>

<meta charset="UTF-8">
<title>${pageTitle }</title>
<link rel="stylesheet" href="/resource/common.css" />
<script src="/resource/common.js" defer="defer"></script>
<!-- 테일윈드 불러오기 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.2.19/tailwind.min.css" />

<!-- daisy ui 불러오기 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/daisyui/4.6.1/full.css" />

<!-- 폰트어썸 불러오기 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css">

<!-- 제이쿼리 불러오기 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick.min.css" />
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick-theme.min.css" />
<body class="mainbody" style="background: black;">

	<hr style="border-top: 3px solid white;" />
	<div class="navbar1" style="display: flex; justify-content: center;">
<!-- 검색 창 -->
<div class="search-container" style="margin-right: 950px;">
    <form id="search-form">
        <input id="search-input" type="text" placeholder="검색..." name="search" style="width: 500px; height: 40px;">
        <button id="search-button" type="submit">검색</button> <!-- 검색 버튼에 id 추가 -->
    </form>
</div>

<!-- 결과를 표시할 영역 -->
<div id="movie-info" style="color: white;"></div>

<script>
document.getElementById("search-form").addEventListener("submit", function(event) {
    event.preventDefault(); // 기본 이벤트(페이지 새로고침) 방지

    var movieCd = document.getElementById("search-input").value; // 영화 코드 입력 받기

    // REST API 호출
    fetch("http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=522fdab6a16d6de0da302e15b84bcb2f&movieCd=" + movieCd)
        .then(response => response.json())
        .then(data => {
            // 가져온 데이터를 처리하여 원하는 형태로 표시
            var movieInfo = data.movieInfoResult.movieInfo;
            document.getElementById("movie-info").innerHTML = `
                <h2>${movieInfo.movieNm}</h2>
                <p>영화명(영문): ${movieInfo.movieNmEn}</p>
                <p>제작연도: ${movieInfo.prdtYear}</p>
                <p>상영시간: ${movieInfo.showTm}분</p>
                <p>감독: ${movieInfo.directors}</p>
                <p>배우: ${movieInfo.actors}</p>
                <!-- 기타 정보들도 필요에 따라 표시 -->
            `; 
        })
        .catch(error => {
            console.error("에러 발생:", error);
            // 에러 메시지 표시 등의 처리
        });
});
    // 검색 버튼에 클릭 이벤트 리스너 추가
    document.getElementById("search-button").addEventListener("click", function(event) {
        document.getElementById("search-form").dispatchEvent(new Event("submit"));
    });
</script>


		<c:if test="${not rq.isLogined() }">
			<div class="login-signup-links">
				<!-- 로그인 링크 -->
				<a class="hover:underline" href="../member/login" style="margin-right: 50px;">로그인</a>

				<!-- 회원가입 링크 -->
				<a class="hover:underline" href="../member/join" style="margin-right: 50px;">회원가입</a>
			</div>
		</c:if>
	</div>
	
	<script>
    document.addEventListener('DOMContentLoaded', function () {
        const form = document.querySelector('form');
        form.addEventListener('submit', function (e) {
            e.preventDefault(); // 기본 동작 방지 (페이지 새로고침 방지)
            const searchTerm = form.search.value;
            // API에 요청 보내는 함수 호출
            searchAPI(searchTerm);
        });
    });

    async function searchAPI(searchTerm) {
        const apiKey = '522fdab6a16d6de0da302e15b84bcb2f'; // 여기에 사용하려는 API의 키를 입력하세요
        const url = `YOUR_API_ENDPOINT?search=${searchTerm}&apiKey=${apiKey}`; // API 엔드포인트와 쿼리 매개변수 설정
        try {
            const response = await fetch(url);
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            const data = await response.json();
            // 여기에서 API 응답 데이터를 처리하고 결과를 표시하는 코드 작성
            console.log(data); // 예시로 콘솔에 데이터 출력
        } catch (error) {
            console.error('There was a problem with the fetch operation:', error);
        }
    }
</script>




	<hr style="border-top: 3px solid white;" />

	
	

		
	

	<script type="text/javascript">

// 조회할 날짜를 계산
	var dt = new Date();

	var m = dt.getMonth() + 1;
	if (m < 10) {
		var month = "0" + m;
	} else {
		var month = m + "";
	}

	var d = dt.getDate() - 1;
	if (d < 10) {
		var day = "0" + d;
	} else {
		var day = d + "";
	}

	var y = dt.getFullYear();
	var year = y + "";

	var result = year + month + day;
	$(function() {
		$.ajax({
			//"키입력" 부분에 발급받은 키를 입력
			//&itemPerPage: 1-10위 까지의 데이터가 출력되도록 설정
					url : "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.xml?key=edf2f390fd84d8a500bfd4f6c2536a47&targetDt="
							+ result + "&itemPerPage=10",
					dataType : "xml",
					success : function(data) {
						var $data = $(data)
								.find("boxOfficeResult>dailyBoxOfficeList>dailyBoxOffice");
						//데이터를 테이블 구조에 저장. html의 table태그, class는 table로 하여 부트스트랩 적용
						if ($data.length > 0) {
							var table = $("<table/>").attr("class", "table");
							//<table>안에 테이블의 컬럼 타이틀 부분인 thead 태그
							var thead = $("<thead/>").append($("<tr/>"))
									.append(
											//추출하고자 하는 컬럼들의 타이틀 정의
											$("<th/>").html("&nbsp;순위"),
											$("<th/>").html("&nbsp;&nbsp;영화 제목"),
											$("<th/>").html("&nbsp;&nbsp;영화 개봉일"),
											$("<th/>").html("&nbsp;&nbsp;누적 매출액"),
											$("<th/>").html("&nbsp;&nbsp;누적 관객수"));
							var tbody = $("<tbody/>");
							$.each($data, function(i, o) {

								//오픈 API에 정의된 변수와 내가 정의한 변수 데이터 파싱
								var $rank = $(o).find("rank").text(); // 순위
								var $movieNm = $(o).find("movieNm").text(); //영화명
								var $openDt = $(o).find("openDt").text();// 영화 개봉일
								var $salesAcc = $(o).find("salesAcc").text();//누적 매출액
								var $audiAcc = $(o).find("audiAcc").text(); //누적 관객수
								
								//<tbody><tr><td>태그안에 파싱하여 추출된 데이터 넣기
								var row = $("<tr/>").addClass("white-text").append(
										
										$("<td/>").text($rank),
										$("<td/>").text($movieNm),
										$("<td/>").text($openDt),
										$("<td/>").text($salesAcc),
										$("<td/>").text($audiAcc));

								tbody.append(row);

							});// end of each 

							table.append(thead);
							table.append(tbody);
							$(".wrap").append(table);
						}
					},
					//에러 발생시 "실시간 박스오피스 로딩중"메시지가 뜨도록 한다.
					error : function() {
						alert("실시간 박스오피스 로딩중...");
					}
				});
	});
	

</script>

	<!-- 박스오피스 테이블에 마우스를 올렸을때 hover효과 -->
	<style type="text/css">
tbody>tr>td:hover {
	background: #ccc;
	cursor;
}
</style>
</head>

<div class="box-office-wrapper" style="margin-top: 50px; background-color: #000;">
    <div class="poster-container" >
        <!-- 포스터 -->
        <div class="custom-card">
            <div class="custom-card-header">
                <img src="https://img.cgv.co.kr/Movie/Thumbnail/StillCut/000086/86312/86312225702_727.jpg">
          </div>
        </div>
    </div>
    
    <div class="wrap container"> 
    <h3 class="ofice"></h3>
    </div>
</div>

<style>
    .box-office-wrapper {
        display: flex;
        align-items: center;
        justify-content: space-between;
        color: white;
    }

    .poster-container {
        margin-right: 20px; /* 포스터와 박스오피스 목록 사이의 간격을 설정합니다. */
        display: flex;
        align-items: center;
    }

    .wrap.container {
        display: flex;
        align-items: center;
        width: 55%; /* 박스오피스 목록의 너비를 설정합니다. */
    }

    .custom-card {
        display: flex;
        margin-left: 250px; /* 오타 수정: margin-reft -> margin-left */
    }

    .custom-card-header {
        margin-right: 10px;
    }

    .box-office-list ul {
        list-style-type: none;
        padding: 0;
    }

    .box-office-list ul li {
        margin-bottom: 10px;
    }
</style>

<br>
<br>
	<hr style="border-top: 3px solid white;" />









</html>
<%@ page import="java.util.List"%>
<!-- List 클래스 import -->
<%@ page import="com.example.demo.util.CgvDAO"%>
<%@ page import="com.example.demo.vo.CgvVO"%>
<%@ page import="com.example.demo.util.CgvService"%>
<html>

<div style="margin-top: 0px;">
	<div class="wrapper">

		<div class="carousel">
			<div class="card">
				<div class="card-header">
					<img>
				</div>
			</div>
			<div class="card">
				<div class="card-header">
					<img>
				</div>
			</div>
			<div class="card">
				<div class="card-header">
					<img>
				</div>
			</div>
			<div class="card">
				<div class="card-header">
					<img>
				</div>
			</div>
			<div class="card">
				<div class="card-header">
					<img>
				</div>
			</div>
			<div class="card">
				<div class="card-header">
					<img>
				</div>
			</div>
		</div>
	</div>
	</body>
</div>
<script>
    // 영화 목록을 가져와서 JavaScript 배열로 변환
    var movieList = [
        <%List<CgvVO> movies = new CgvDAO().getMovies();%>
        <%for (int i = 0; i < movies.size(); i++) {%>
            <%CgvVO movie = movies.get(i);%>
            {
                title: "<%=movie.getTitle()%>",
                image: "<%=movie.getImage()%>",
                genre: "<%=movie.getGenre()%>"
            }
            <%if (i < movies.size() - 1) {%>,<%}%>
        <%}%>
    ];

    // 이미지 URL 배열 초기화
    var imageUrls = [];

    // 영화 목록의 이미지 URL을 imageUrls 배열에 추가
    for (var i = 0; i < movieList.length; i++) {
        imageUrls.push(movieList[i].image);
    }

    // 카드 요소 가져오기
    var cardElements = document.querySelectorAll(".card");

    // 이미지 URL을 카드에 설정하고 클릭 이벤트 리스너 추가
    for (var i = 0; i < cardElements.length; i++) {
        if (i < imageUrls.length) {
            var imgElement = cardElements[i].querySelector("img");
            imgElement.src = imageUrls[i];
            cardElements[i].addEventListener("click", handleCardClick); // 클릭 이벤트 리스너 추가
            cardElements[i].setAttribute("data-index", i); // 각 카드에 인덱스 속성 추가
        } else {
            console.error("이미지 URL이 부족합니다.");
        }
    }

    // handleCardClick 함수 정의
    function handleCardClick(event) {
        var index = event.currentTarget.getAttribute("data-index"); // 클릭한 카드의 인덱스 가져오기
        // "detail.jsp" 페이지로 이동하면서 index를 전달
        window.location.href = "../article/detail?index=" + index;
    }

    // 여기서 영화 정보를 추가하면 됩니다. 이미지 URL을 새로운 URL로 바꿔야 합니다.
    movieList.push({ title: "새로운 영화", image: "새로운 이미지 URL", genre: "새로운 장르" });
    // 위에서 추가한 영화 정보에 대한 이미지 URL을 새로운 URL로 설정합니다.
    imageUrls.push("새로운 이미지 URL");
    
    var imgElements = document.querySelectorAll(".card img");

 // 모든 이미지 요소에 너비와 높이를 적용합니다.
 imgElements.forEach(function(imgElement) {
     imgElement.style.width = "300px"; // 너비를 200px로 설정합니다.
     imgElement.style.height = "500px%"; // 높이를 300px로 설정합니다.
 });
</script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick.min.js"></script>
<script>
		$(document).ready(function() {
			$('.carousel').slick({
				speed : 300,
				slidesToShow : 4,
				slidesToScroll : 1,
				autoplay : true,
				autoplaySpeed : 3000,
				dots : true,
				centerMode : true,
				responsive : [ {
					breakpoint : 1024,
					settings : {
						slidesToShow : 3,
						slidesToScroll : 1,
					}
				}, {
					breakpoint : 800,
					settings : {
						slidesToShow : 2,
						slidesToScroll : 2,
					}
				}, {
					breakpoint : 480,
					settings : {
						slidesToShow : 1,
						slidesToScroll : 1,
					}
				} ]
			});
		});
	</script>
<hr style="border-top: 3px solid white;" />
<div class="board-container">
	<div class="board">
		<h2>인기 영화</h2>
		<ul class="post-list">
			<li class="post"></li>
			<li class="post"></li>
			<li class="post"></li>
		</ul>
	</div>

	<div class="board">
		<h2>인기 글</h2>
		<ul class="post-list">
			<li class="post"></li>
			<li class="post"></li>
			<li class="post"></li>
		</ul>
	</div>
</div>
		<script type="text/javascript">
	function mainTopMenuTopView(divName) {
		var frm = document.getElementById(divName);
		if(frm.style.display != "block") frm.style.display = "block";
		else frm.style.display = "none";
	}
	
	function fn_changeSearch() {
		SetCookie("sel_s_type", $("#sel_s_type").val());
		var pForm = document.searchMainTopMovie;
		
		if($("#sel_s_type").val() == "M") {
			pForm.action="/kobis/business/mast/mvie/searchMovieList.do";
			$("#inp_solrSearch").attr("name", "sMovName");
		} else {
			pForm.action="/kobis/business/comm/search/search.do";
			$("#inp_solrSearch").attr("name", "queryString");
		}
	}
	
	function fn_mainTopMovieSearch(){
		var pForm = document.searchMainTopMovie;
		pForm.submit();
	}
	
	$(document).ready(function() { 
	    if(GetCookie("sel_s_type") == "T") {
	    	$("#sel_s_type").val("T");
	    	
	    	var pForm = document.searchMainTopMovie;
	    	pForm.action="/kobis/business/comm/search/search.do";
	    	
	    	$("#inp_solrSearch").attr("name", "queryString"); 
	    }
	    $("ul.list_nav > li > a").click(function(){
	    
	    		
	    	if($(this).parent().find(".bg_sub ul.nav_sub > li:eq(0)  li.depth3:eq(0)").length >0){
	    		$(this).parent().find(".bg_sub ul.nav_sub > li:eq(0)  li.depth3:eq(0) a").click();
	    		goDirectPage($(this).parent().find(".bg_sub ul.nav_sub > li:eq(0)  li.depth3:eq(0) a").attr("href"));
	    	}else{
	    		$(this).parent().find(".bg_sub ul.nav_sub > li:eq(0) a").click();
	    		goDirectPage($(this).parent().find(".bg_sub ul.nav_sub > li:eq(0) a").attr("href"));
	    	}
	    	
	    	
	    	if($(this).parent().hasClass("nav5")){
	    		/* $(this).attr("href","/kobis/business/stat/online/onlinefindDailyBoxOfficeList.do"); */
	    		/* location.href="/kobis/business/stat/online/onlineMain.do"; */
	    		location.href="/kobis/business/stat/online/onlineintro.do";
	    		
	    	}
	    });
	}); 
	function goDirectPage(page){
		location.href=page;
	}
</script>
		<hr style="border-top: 3px solid white;" />

		<title>영화관 위치</title>
		<style>

</style>

		<div>
			<div class="map_wrap">
				<div id="map" style="width: 800px; height: 500px; position: relative; overflow: hidden; margin-top:30px; margin-left:250px;"></div>

				<div id="menu_wrap" class="bg_white">
					<div class="option">
						<div>
							<form onsubmit="searchPlaces(); return false;">
								키워드 : <input type="text" value="대전 영화관" id="keyword" size="15">
								<button type="submit">검색하기</button>
							</form>
						</div>
					</div>
					<hr>
					<ul id="placesList"></ul>
					<div id="pagination"></div>
				</div>
			</div>

		</div>

		<script type="text/javascript"
			src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b9a2c532db563d64e7bbbdc218fef94d&libraries=services"></script>
		<script>
// 마커를 담을 배열입니다
var markers = [];

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places();  

// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({zIndex:1});

// 키워드로 장소를 검색합니다
searchPlaces();

// 키워드 검색을 요청하는 함수입니다
function searchPlaces() {

    var keyword = document.getElementById('keyword').value;

    if (!keyword.replace(/^\s+|\s+$/g, '')) {
        alert('키워드를 입력해주세요!');
        return false;
    }

    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
    ps.keywordSearch( keyword, placesSearchCB); 
}

// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
function placesSearchCB(data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {

        // 정상적으로 검색이 완료됐으면
        // 검색 목록과 마커를 표출합니다
        displayPlaces(data);

        // 페이지 번호를 표출합니다
        displayPagination(pagination);

    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

        alert('검색 결과가 존재하지 않습니다.');
        return;

    } else if (status === kakao.maps.services.Status.ERROR) {

        alert('검색 결과 중 오류가 발생했습니다.');
        return;

    }
}

//검색 결과 목록과 마커를 표출하는 함수입니다
function displayPlaces(places) {
    var listEl = document.getElementById('placesList'),
        menuEl = document.getElementById('menu_wrap'),
        fragment = document.createDocumentFragment(),
        bounds = new kakao.maps.LatLngBounds(),
        listStr = '';

    // 검색 결과 목록에 클릭 이벤트를 추가하기 위해 함수 호출
    addListClickEvent(); 

    // 검색 결과 목록을 표출하기 전에 초기화
    removeAllChildNods(listEl);
    removeMarker();

    // 검색 결과 목록에 장소 정보 추가
    for (var i = 0; i < places.length; i++) {
    	console.log(places[i]); // 콘솔에 places[i] 출력
        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
            marker = addMarker(placePosition, i, places[i].place_name),
            itemEl = getListItem(i, places[i]);

        bounds.extend(placePosition);

        // 마커와 검색 결과 항목에 클릭 이벤트 추가
        (function(marker, title) {
            kakao.maps.event.addListener(marker, 'click', function() {
                displayInfowindow(marker, title);
            });

            itemEl.addEventListener('click', function() {
                // 클릭된 장소의 경로를 찾아 표시하는 함수 호출
                findPath(places[i]);
            });
        })(marker, places[i].place_name);

        fragment.appendChild(itemEl);
    }

    listEl.appendChild(fragment);
    menuEl.scrollTop = 0;

    map.setBounds(bounds);
}


// 검색결과 항목을 Element로 반환하는 함수입니다
function getListItem(index, places) {

    var el = document.createElement('li'),
    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
                '<div class="info">' +
                '   <h5>' + places.place_name + '</h5>';

    if (places.road_address_name) {
        itemStr += '    <span>' + places.road_address_name + '</span>' +
                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
    } else {
        itemStr += '    <span>' +  places.address_name  + '</span>'; 
    }
                 
      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
                '</div>';           

    el.innerHTML = itemStr;
    el.className = 'item';

    return el;
}

// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
function addMarker(position, idx, title) {
    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
        imgOptions =  {
            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
        },
        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
            marker = new kakao.maps.Marker({
            position: position, // 마커의 위치
            image: markerImage 
        });

    marker.setMap(map); // 지도 위에 마커를 표출합니다
    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

    return marker;
}

// 지도 위에 표시되고 있는 마커를 모두 제거합니다
function removeMarker() {
    for ( var i = 0; i < markers.length; i++ ) {
        markers[i].setMap(null);
    }   
    markers = [];
}

// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
function displayPagination(pagination) {
    var paginationEl = document.getElementById('pagination'),
        fragment = document.createDocumentFragment(),
        i; 

    // 기존에 추가된 페이지번호를 삭제합니다
    while (paginationEl.hasChildNodes()) {
        paginationEl.removeChild (paginationEl.lastChild);
    }

    for (i=1; i<=pagination.last; i++) {
        var el = document.createElement('a');
        el.href = "#";
        el.innerHTML = i;

        if (i===pagination.current) {
            el.className = 'on';
        } else {
            el.onclick = (function(i) {
                return function() {
                    pagination.gotoPage(i);
                }
            })(i);
        }

        fragment.appendChild(el);
    }
    paginationEl.appendChild(fragment);
}

// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
// 인포윈도우에 장소명을 표시합니다
function displayInfowindow(marker, title) {
    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

    infowindow.setContent(content);
    infowindow.open(map, marker);
}

 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
function removeAllChildNods(el) {   
    while (el.hasChildNodes()) {
        el.removeChild (el.lastChild);
    }
}
//전역 변수로 places 배열을 정의합니다
var places = [];

// 검색 결과 목록에 클릭 이벤트를 추가합니다
function addListClickEvent() {
    var placesList = document.getElementById('placesList');
    placesList.addEventListener('click', function(e) {
        var target = e.target;
        if (target.tagName === 'LI') {
            var index = Array.prototype.indexOf.call(placesList.children, target);
            var place = places[index];
            // 클릭된 장소의 경로를 찾아 표시하는 함수를 호출합니다
            findPath(place);
        }
    });
}
// 검색 결과 목록에 클릭 이벤트를 추가합니다
addListClickEvent();
</script>
		<%@ include file="../common/foot.jspf"%>