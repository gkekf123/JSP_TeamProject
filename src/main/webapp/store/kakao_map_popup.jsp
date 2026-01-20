<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>가게 검색</title>
    <style>
        body { font-family: sans-serif; padding: 20px; }
        .search-wrap { display: flex; gap: 5px; margin-bottom: 10px; }
        input { flex: 1; padding: 10px; }
        button { padding: 10px; background: #FEE500; border: none; font-weight: bold; cursor: pointer; }
        ul { list-style: none; padding: 0; margin: 0; border: 1px solid #ddd; }
        li { padding: 10px; border-bottom: 1px solid #ddd; cursor: pointer; }
        li:hover { background: #f9f9f9; }
        li h4 { margin: 0 0 5px; }
        li p { margin: 0; font-size: 13px; color: #666; }
    </style>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4d6ec00692a6f465a841ee2f2e06d862&libraries=services"></script>
</head>
<body>
    <h3>카카오 주소 검색</h3>
    <div class="search-wrap">
        <input type="text" id="keyword" placeholder="예: 강남역 맛집, 지번 및 도로명 주소" onkeydown="if(event.keyCode==13) search();">
        <button onclick="search()">검색</button>
    </div>
    <ul id="list"></ul>

    <script>
        var ps = new kakao.maps.services.Places();

        function search() {
            var keyword = document.getElementById('keyword').value;
            if (!keyword.trim()) { alert("키워드를 입력하세요"); return; }
            ps.keywordSearch(keyword, placesSearchCB);
        }

        function placesSearchCB(data, status, pagination) {
            if (status === kakao.maps.services.Status.OK) {
                displayPlaces(data);
            } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
                alert('검색 결과가 없습니다.');
            } else if (status === kakao.maps.services.Status.ERROR) {
                alert('오류가 발생했습니다.');
            }
        }

        function displayPlaces(places) {
            var listEl = document.getElementById('list');
            listEl.innerHTML = "";

            for (var i = 0; i < places.length; i++) {
                (function(place) {
                    var item = document.createElement('li');
                    var addr = place.road_address_name || place.address_name;
                    
                    item.innerHTML = '<h4>' + place.place_name + '</h4><p>' + addr + '</p>';
                    
                    item.onclick = function() {
                        if (opener) {
                            // 부모창(store_write.jsp)으로 데이터 전송
                            // 순서: 이름, 주소, 전화, 위도(y), 경도(x), 카카오ID, URL
                            opener.kakaoCallBack(
                                place.place_name,
                                addr,
                                place.phone,
                                place.y,      // latitude
                                place.x,      // longitude
                                place.id,     // kakao_id
                                place.place_url
                            );
                            window.close();
                        }
                    };
                    listEl.appendChild(item);
                })(places[i]);
            }
        }
    </script>
</body>
</html>