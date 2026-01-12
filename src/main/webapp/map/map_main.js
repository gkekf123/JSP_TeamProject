// 전역 변수 선언
var markers = [];
var map;
var ps;
var infowindow;

// 화면이 다 로딩된 후에 지도를 그리도록 설정
window.onload = function() {
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
        mapOption = {
            center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표 (서울시청)
            level: 3 // 지도의 확대 레벨
        };  

    // 1. 지도 생성 (이제 map div를 찾을 수 있습니다!)
    map = new kakao.maps.Map(mapContainer, mapOption); 

    // 2. 장소 검색 객체 생성
    ps = new kakao.maps.services.Places();  

    // 3. 인포윈도우 생성
    infowindow = new kakao.maps.InfoWindow({zIndex:1});

    // 4. 키워드로 장소를 검색합니다 (기본값: 강남 맛집)
    searchPlaces();
};

// 키워드 검색을 요청하는 함수
function searchPlaces() {
    var keyword = document.getElementById('keyword').value;

    if (!keyword.replace(/^\s+|\s+$/g, '')) {
        alert('키워드를 입력해주세요!');
        return false;
    }

    // 장소검색 객체를 통해 키워드로 장소검색을 요청
    ps.keywordSearch(keyword, placesSearchCB); 
}

// 장소검색 완료 시 호출되는 콜백함수
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

// 검색 결과 목록과 마커를 표출하는 함수
function displayPlaces(places) {
    var listEl = document.getElementById('placesList'), 
    menuEl = document.getElementById('menu_wrap'),
    fragment = document.createDocumentFragment(), 
    bounds = new kakao.maps.LatLngBounds(), 
    listStr = '';
    
    removeAllChildNods(listEl);
    removeMarker();
    
    for ( var i=0; i<places.length; i++ ) {
        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
            marker = addMarker(placePosition, i), 
            itemEl = getListItem(i, places[i]); 

        bounds.extend(placePosition);

        (function(marker, title) {
            kakao.maps.event.addListener(marker, 'mouseover', function() {
                displayInfowindow(marker, title);
            });
            kakao.maps.event.addListener(marker, 'mouseout', function() {
                infowindow.close();
            });
            itemEl.onmouseover =  function () {
                displayInfowindow(marker, title);
            };
            itemEl.onmouseout =  function () {
                infowindow.close();
            };
        })(marker, places[i].place_name);

        fragment.appendChild(itemEl);
    }

    listEl.appendChild(fragment);
    menuEl.scrollTop = 0;
    map.setBounds(bounds); 
}

// 검색결과 항목을 Element로 반환하는 함수
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

// 마커를 생성하고 지도 위에 표시하는 함수
function addMarker(position, idx, title) {
    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', 
        imageSize = new kakao.maps.Size(36, 37),
        imgOptions =  {
            spriteSize : new kakao.maps.Size(36, 691), 
            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), 
            offset: new kakao.maps.Point(13, 37) 
        },
        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
            marker = new kakao.maps.Marker({
            position: position, 
            image: markerImage 
        });

    marker.setMap(map); 
    markers.push(marker);  
    return marker;
}

function removeMarker() {
    for ( var i = 0; i < markers.length; i++ ) {
        markers[i].setMap(null);
    }   
    markers = [];
}

function displayPagination(pagination) {
    var paginationEl = document.getElementById('pagination'),
        fragment = document.createDocumentFragment(),
        i; 

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