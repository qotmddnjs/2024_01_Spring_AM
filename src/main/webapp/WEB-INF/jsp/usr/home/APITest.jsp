<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="API TEST"></c:set>

<%@ include file="../common/head.jspf"%>

 <!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>장소 검색 서비스</title>
    <style>
        /* CSS 코드 */
        .map_wrap {
            position: relative;
            width: 100%;
            height: 500px;
            margin: 20px auto; /* Center the map */
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* Add a shadow */
        }

        #map {
            width: 100%;
            height: 100%;
        }

        #menu_wrap {
            position: absolute;
            top: 10px;
            right: 10px;
            width: 300px;
            padding: 10px;
            background-color: rgba(255, 255, 255, 0.8);
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        #menu_wrap form {
            margin-bottom: 10px;
        }

        #menu_wrap input[type="text"] {
            width: calc(100% - 80px);
            padding: 5px;
            border-radius: 5px;
            border: 1px solid #ccc;
            font-size: 14px;
            outline: none;
        }

        #menu_wrap button {
            width: 70px;
            padding: 6px;
            border: none;
            border-radius: 5px;
            background-color: #007bff;
            color: #fff;
            font-size: 14px;
            cursor: pointer;
            outline: none;
        }

        #menu_wrap hr {
            border-color: #ddd;
        }

        #placesList {
            position: absolute;
            top: 10px;
            right: 10px;
            width: 300px;
            padding: 10px;
            background-color: rgba(255, 255, 255, 0.8);
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            z-index: 1; /* Ensure it's above the map */
            overflow-y: auto; /* Add scrollbar if needed */
        }

        #placesList .item {
            padding: 10px;
            border-bottom: 1px solid #eee;
            cursor: pointer;
        }

        #placesList .item:hover {
            background-color: #f9f9f9;
        }
    </style>
</head>
<body>
    <div class="map_wrap">
        <div id="map" style="width:800px;height:500px;position:relative;overflow:hidden;"></div>

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

    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b9a2c532db563d64e7bbbdc218fef94d&libraries=services"></script>
    <script>
        // JavaScript 코드
        // 이전의 JavaScript 코드 추가
        // 검색 결과 목록에 클릭 이벤트를 추가하는 함수입니다
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

        // 장소로부터 현재 위치까지의 경로를 찾아 표시하는 함수
        function findPath(place) {
            if (navigator.geolocation) {
                // 사용자의 현재 위치를 가져옵니다
                navigator.geolocation.getCurrentPosition(function(position) {
                    var startLat = position.coords.latitude;
                    var startLng = position.coords.longitude;
                    var startXy = new kakao.maps.LatLng(startLat, startLng);
                    var endXy = new kakao.maps.LatLng(place.y, place.x);
                    // 카카오맵의 길찾기 서비스를 이용하여 경로를 표시합니다
                    kakao.maps.services.Geocoder.coord2Address(startXy.getLng(), startXy.getLat(), function(startAddr, status) {
                        if (status === kakao.maps.services.Status.OK) {
                            var startAddress = startAddr[0].address.address_name;
                            var endName = place.place_name;
                            var endAddress = place.address_name;
                            var url = 'https://map.kakao.com/link/to/' + endName + ',' + place.y + ',' + place.x;
                            var infoWindowContent = '<div style="padding:5px;">' +
                                '<strong>' + endName + '</strong><br>' +
                                '출발지: ' + startAddress + '<br>' +
                                '도착지: ' + endAddress + '<br><br>' +
                                '<a href="' + url + '" target="_blank">길찾기</a>' +
                                '</div>';
                            var infoWindow = new kakao.maps.InfoWindow({
                                content: infoWindowContent,
                                removable: true
                            });
                            infoWindow.open(map, new kakao.maps.LatLng(place.y, place.x));
                        }
                    });
                });
            } else {
                alert('Geolocation이 지원되지 않습니다');
            }
        }

        // 검색 결과 목록에 클릭 이벤트를 추가합니다
        addListClickEvent();

        // 이전의 JavaScript 코드 추가
    </script>
</body>
</html>

<%@ include file="../common/foot.jspf"%>