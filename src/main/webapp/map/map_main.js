// 전역 변수 선언
var markers = [];
var map;
var ps;
var selectedOverlay = null; // 현재 떠있는 오버레이를 추적하기 위한 변수

// 화면이 다 로딩된 후에 지도를 그리도록 설정
window.onload = function() {
    var mapContainer = document.getElementById('map'), 
        mapOption = {
            center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표 (서울시청)
            level: 3 // 지도의 확대 레벨
        };  

    // 1. 지도 생성
    map = new kakao.maps.Map(mapContainer, mapOption); 

    // 2. 장소 검색 객체 생성
    ps = new kakao.maps.services.Places();  

    // 3. 키워드로 장소를 검색합니다 (기본값: 강남 맛집)
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
    bounds = new kakao.maps.LatLngBounds();
    
    // 기존 목록 및 마커 제거
    removeAllChildNods(listEl);
    removeMarker();
    
    // 검색할 때마다 기존에 열려있던 오버레이를 닫아줍니다.
    closeOverlay();
    
    for ( var i=0; i<places.length; i++ ) {
        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
            marker = addMarker(placePosition, i), 
            itemEl = getListItem(i, places[i]); 

        bounds.extend(placePosition);

        // 마커와 리스트 항목 클릭 시 오버레이(커스텀) 띄우기
        (function(marker, place) {
            kakao.maps.event.addListener(marker, 'click', function() {
                displayCustomOverlay(marker, place);
            });

            itemEl.onclick =  function () {
                displayCustomOverlay(marker, place);
            };
        })(marker, places[i]);

        fragment.appendChild(itemEl);
    }

    listEl.appendChild(fragment);
    menuEl.scrollTop = 0;
    map.setBounds(bounds); 
}

// 커스텀 오버레이를 표시하는 함수 (HTML 문자열 생성)
function displayCustomOverlay(marker, place) {
    // 1. 기존에 열려있는 오버레이 닫기
    closeOverlay();

    // 2. 오버레이 내용(HTML) 구성 - 검색된 데이터(place)를 넣습니다.
    var content = '<div class="wrap">' + 
                '    <div class="info">' + 
                '        <div class="title">' + 
                            place.place_name + 
                '            <div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
                '        </div>' + 
                '        <div class="body">' + 
                '            <div class="img">' +
                //               이미지는 API에서 주지 않으므로 기본 이미지를 사용합니다. 필요 없으면 이 div를 지우세요.
                '                <img src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/thumnail.png" width="73" height="70">' +
                '           </div>' + 
                '            <div class="desc">' + 
                '                <div class="ellipsis">' + (place.road_address_name ? place.road_address_name : place.address_name) + '</div>' + 
                '                <div class="jibun ellipsis">(지번) ' + place.address_name + '</div>' + 
                '                <div><a href="' + place.place_url + '" target="_blank" class="link">상세보기</a></div>' + 
                '            </div>' + 
                '        </div>' + 
                '    </div>' +    
                '</div>';

    // 3. 커스텀 오버레이 생성
    var overlay = new kakao.maps.CustomOverlay({
        content: content,
        map: map,
        position: marker.getPosition()       
    });

    // 4. 지도 중심 이동 (부드럽게)
    map.panTo(marker.getPosition());

    // 5. 현재 열린 오버레이 저장
    selectedOverlay = overlay;
}

// 오버레이 닫기 (X 버튼 클릭 시 호출됨)
function closeOverlay() {
    if (selectedOverlay) {
        selectedOverlay.setMap(null);
        selectedOverlay = null;
    }
}

// 검색결과 항목을 Element로 반환하는 함수
function getListItem(index, places) {
    var el = document.createElement('li');
    var spriteOffset = 10 + (index * 46);
    
    var safeName = places.place_name.replace(/'/g, "\\'");
    var safeAddr = places.road_address_name ? places.road_address_name.replace(/'/g, "\\'") : "";
    
    var saveBtn = '<button class="jjim-btn" onclick="saveBookmark(\'' + 
                  safeName + '\', \'' + 
                  safeAddr + '\', \'' + 
                  places.place_url + '\', \'' + 
                  places.phone + '\')">♥ 찜하기</button>';

    var itemStr = '<span class="markerbg" style="background-position: 0 -' + spriteOffset + 'px;"></span>' +
                '<div class="info">' +
                '   <h5>' + places.place_name + '</h5>';

    if (places.road_address_name) {
        itemStr += '    <span>' + places.road_address_name + '</span>' +
                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
    } else {
        itemStr += '    <span>' +  places.address_name  + '</span>'; 
    }
                 
    itemStr += '  <span class="tel">' + places.phone  + '</span>' +
                '</div>' +
                saveBtn; // 버튼 추가

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

// 마커 제거 함수
function removeMarker() {
    for ( var i = 0; i < markers.length; i++ ) {
        markers[i].setMap(null);
    }   
    markers = [];
}

// 페이지네이션 함수
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

// 자식 노드 제거 함수
function removeAllChildNods(el) {   
    while (el.hasChildNodes()) {
        el.removeChild (el.lastChild);
    }
}

// 찜하기 버튼 클릭 시 실행될 함수
function saveBookmark(name, addr, url, phone) {
    if(!confirm(name + "을(를) 찜 목록에 추가하시겠습니까?")) return;

    $.ajax({
        type: "POST",
        url: "/bookmark/bookmark_action.jsp",
        data: {
            place_name: name,
            place_addr: addr,
            place_url: url,
            place_phone: phone
        },
        success: function(response) {
            if(response.trim() === "success") {
                alert("찜 목록에 저장되었습니다!");
            } else {
                alert("저장에 실패했습니다.");
            }
        },
        error: function() {
            alert("서버 통신 오류!");
        }
    });
}