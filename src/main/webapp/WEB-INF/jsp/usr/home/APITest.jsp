<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="API TEST"></c:set>

<%@ include file="../common/head.jspf"%>


<head>
    <title>영화관 위치</title>
    <style>
        .map_wrap {
            position: relative;
            overflow: hidden;
            width: 800px;
            height: 500px;
        }
        #map {
            width: 100%;
            height: 100%;
        }
    </style>
</head>
<body>
<div class="map_wrap">
    <div id="map"></div>
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

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=449476482f8855f4bfd10babe33956cf&libraries=services"></script>
<script>
    function initMap() {
        var markers = [];
        var mapContainer = document.getElementById('map');
        var mapOption = {
            center: new kakao.maps.LatLng(37.566826, 126.9786567),
            level: 3
        };
        var map = new kakao.maps.Map(mapContainer, mapOption);
        var ps = new kakao.maps.services.Places();
        var infowindow = new kakao.maps.InfoWindow({zIndex:1});

        searchPlaces();

        function searchPlaces() {
            var keyword = document.getElementById('keyword').value;
            if (!keyword.replace(/^\s+|\s+$/g, '')) {
                alert('키워드를 입력해주세요!');
                return false;
            }
            ps.keywordSearch(keyword, placesSearchCB);
        }

        function placesSearchCB(data, status, pagination) {
            if (status === kakao.maps.services.Status.OK) {
                displayPlaces(data);
                displayPagination(pagination);
            } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
                alert('검색 결과가 존재하지 않습니다.');
                return;
            } else if (status === kakao.maps.services.Status.ERROR) {
                alert('검색 결과 중 오류가 발생했습니다.');
                return;
            }
        }

        function displayPlaces(places) {
            var listEl = document.getElementById('placesList');
            var bounds = new kakao.maps.LatLngBounds();
            removeAllChildNods(listEl);
            removeMarker();
            for (var i = 0; i < places.length; i++) {
                var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x);
                var marker = addMarker(placePosition, i, places[i].place_name);
                bounds.extend(placePosition);
                (function(marker, title) {
                    kakao.maps.event.addListener(marker, 'click', function() {
                        displayInfowindow(marker, title);
                    });
                    var itemEl = document.createElement('li');
                    itemEl.innerHTML = '<span class="markerbg marker_' + (i+1) + '"></span>' +
                        '<div class="info">' +
                        '   <h5>' + places[i].place_name + '</h5>' +
                        '    <span>' + places[i].address_name + '</span>' +
                        '  <span class="tel">' + places[i].phone + '</span>' +
                        '</div>';
                    itemEl.className = 'item';
                    itemEl.addEventListener('click', function() {
                        findPath(places[i]);
                    });
                    listEl.appendChild(itemEl);
                })(marker, places[i].place_name);
            }
            map.setBounds(bounds);
        }

        function addMarker(position, idx, title) {
            var marker = new kakao.maps.Marker({
                position: position,
            });
            marker.setMap(map);
            markers.push(marker);
            return marker;
        }

        function removeMarker() {
            for (var i = 0; i < markers.length; i++) {
                markers[i].setMap(null);
            }
            markers = [];
        }

        function displayInfowindow(marker, title) {
            var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';
            infowindow.setContent(content);
            infowindow.open(map, marker);
        }

        function removeAllChildNods(el) {
            while (el.hasChildNodes()) {
                el.removeChild (el.lastChild);
            }
        }

        function displayPagination(pagination) {
            var paginationEl = document.getElementById('pagination');
            var fragment = document.createDocumentFragment();
            removeAllChildNods(paginationEl);
            for (var i=1; i<=pagination.last; i++) {
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

        function findPath(place) {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(function(position) {
                    var startLat = position.coords.latitude;
                    var startLng = position.coords.longitude;
                    var startXy = new kakao.maps.LatLng(startLat, startLng);
                    var roadview = new kakao.maps.Roadview();
                    roadview.getNearestPanoId(startXy, function(panoId) {
                        if (panoId) {
                            var url = 'https://map.kakao.com/link/to/' + place.place_name + ',' + place.y + ',' + place.x;
                            var infoWindowContent = '<div style="padding:5px;">' +
                                '<strong>' + place.place_name + '</strong><br>' +
                                '출발지: 현재 위치<br>' +
                                '도착지: ' + place.address_name + '<br><br>' +
                                '<a href="' + url + '" target="_blank">길찾기</a>' +
                                '</div>';
                            var infoWindow = new kakao.maps.InfoWindow({
                                content: infoWindowContent,
                                removable: true
                            });
                            infoWindow.open(map, new kakao.maps.LatLng(place.y, place.x));
                        } else {
                            alert('도로뷰 정보를 찾을 수 없습니다.');
                        }
                    });
                });
            } else {
                alert('Geolocation이 지원되지 않습니다');
            }
        }

        // 클릭 이벤트 처리
        kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
            // 클릭 이벤트가 발생했을 때 실행되는 콜백 함수 내용
        });
    }

    // 페이지 로드 시 initMap 호출
    window.onload = initMap;
</script>
</body>
</html>
