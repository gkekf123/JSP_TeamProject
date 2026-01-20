// 전역 변수 선언
var markers = [];
var map;
var ps;
var selectedOverlay = null;

// 페이지 로드 완료 시 실행
window.onload = function() {
    var mapContainer = document.getElementById('map'), 
        mapOption = {
            center: new kakao.maps.LatLng(37.566826, 126.9786567), // 기본 위치 (서울시청)
            level: 3 // 지도의 확대 레벨
        };  

    // 1. 지도 생성
    map = new kakao.maps.Map(mapContainer, mapOption); 

    // 2. 장소 검색 객체 생성
    ps = new kakao.maps.services.Places();  

    // 3. 키워드로 장소를 검색합니다 (기본값)
    searchPlaces();
};

// 키워드 검색 요청
function searchPlaces() {
    var keyword = document.getElementById('keyword').value;

    if (!keyword.replace(/^\s+|\s+$/g, '')) {
        alert('키워드를 입력해주세요!');
        return false;
    }

    // 장소검색 객체를 통해 키워드로 장소검색을 요청
    ps.keywordSearch(keyword, placesSearchCB); 
}

// 장소검색 완료 콜백
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

// 검색 결과 목록과 마커 표출
function displayPlaces(places) {
    var listEl = document.getElementById('placesList'), 
    menuEl = document.getElementById('menu_wrap'),
    fragment = document.createDocumentFragment(), 
    bounds = new kakao.maps.LatLngBounds();
    
    // 기존 데이터 초기화
    removeAllChildNods(listEl);
    removeMarker();
    closeOverlay();
    
    for ( var i=0; i<places.length; i++ ) {
        // 좌표 생성
        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
            marker = addMarker(placePosition, i), 
            itemEl = getListItem(i, places[i]); // 리스트 아이템 생성

        // 검색된 장소 위치를 기준으로 지도 범위 재설정하기위해 LatLngBounds 객체에 좌표를 추가
        bounds.extend(placePosition);

        // 마커와 리스트 항목 클릭 이벤트 (오버레이)
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

// 리스트 아이템 생성 및 하트 표시 (ID 기준)
function getListItem(index, places) {
    var el = document.createElement('li');
    var spriteOffset = 10 + (index * 46);
    
    // 특수문자 처리
    var safeName = places.place_name.replace(/'/g, "\\'");
    var safeAddr = places.road_address_name ? places.road_address_name.replace(/'/g, "\\'") : "";
    
    // 1. 내 찜 목록(Set)에 해당 ID가 있는지 확인
    var isBookmarked = false;
    if(typeof myJjimSet !== 'undefined') {
        isBookmarked = myJjimSet.has(places.id);
    }
    var heartShape = isBookmarked ? '♥' : '♡';

    // 2. 토글 버튼 생성
    var saveBtn = '<button class="jjim-btn" onclick="toggleBookmark(this, \'' + 
                  safeName + '\', \'' + 
                  safeAddr + '\', \'' + 
                  places.place_url + '\', \'' + 
                  places.phone + '\', \'' + 
                  places.id + '\'); event.stopPropagation();">' + heartShape + '</button>';

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
                saveBtn; 

    el.innerHTML = itemStr;
    el.className = 'item';

    return el;
}

// 찜하기 토글 함수 (카카오 ID 처리 추가)
function toggleBookmark(btn, name, addr, url, phone, kakaoId) {
    var currentText = $(btn).text().trim();
    var isEmpty = (currentText === '♡');
    
    // 1. 화면 먼저 변경 (UX)
    if(isEmpty) {
        $(btn).text('♥');
        $(btn).css({transform: "scale(1.3)", transition: "0.2s"});
        setTimeout(() => $(btn).css("transform", "scale(1)"), 200);
    } else {
        $(btn).text('♡');
    }

    // 2. 서버 요청
    $.ajax({
        type: "POST",
        url: ctxPath + "/bookmark/bookmark_action.jsp",
        data: {
            store_idx: 0,
            place_name: name,
            place_addr: addr,
            place_url: url,
            place_phone: phone,
            kakao_id: kakaoId // ★ 필수 전송
        },
        success: function(response) {
            var res = response.trim();
            
            if(res === "login_needed") {
                alert("로그인이 필요합니다.");
                location.href = ctxPath + "/login/login.jsp";
                $(btn).text(isEmpty ? '♡' : '♥'); // 실패 시 롤백
            } 
            else if(res === "added") {
                // 성공: Set에도 ID 추가 (새로고침 없이 상태 유지)
                if(typeof myJjimSet !== 'undefined') myJjimSet.add(kakaoId);
            }
            else if(res === "removed") {
                // 성공: Set에서 ID 제거
                if(typeof myJjimSet !== 'undefined') myJjimSet.delete(kakaoId);
            }
            else if(res === "error") {
                alert("오류가 발생했습니다.");
                $(btn).text(isEmpty ? '♡' : '♥'); // 롤백
            }
        },
        error: function() {
            alert("서버 통신 오류");
            $(btn).text(isEmpty ? '♡' : '♥'); // 롤백
        }
    });
}

// 마커 생성 함수
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

// 페이지네이션
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

// 자식 노드 제거
function removeAllChildNods(el) {   
    while (el.hasChildNodes()) {
        el.removeChild (el.lastChild);
    }
}

// 커스텀 오버레이 표시
function displayCustomOverlay(marker, place) {
    closeOverlay(); // 기존 오버레이 닫기

    var content = '<div class="wrap">' + 
                '    <div class="info">' + 
                '        <div class="title">' + 
                            place.place_name + 
                '            <div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
                '        </div>' + 
                '        <div class="body">' + 
                '            <div class="img">' +
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

    var overlay = new kakao.maps.CustomOverlay({
        content: content,
        map: map,
        position: marker.getPosition()       
    });

    map.panTo(marker.getPosition());
    selectedOverlay = overlay;
}

// 오버레이 닫기 함수
function closeOverlay() {
    if (selectedOverlay) {
        selectedOverlay.setMap(null);
        selectedOverlay = null;
    }
}