<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>맛집지도 - 검색</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="<%= ctxPath %>/map/map_main.css?v=2">
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4d6ec00692a6f465a841ee2f2e06d862&libraries=services"></script>
    <script src="<%= ctxPath %>/map/map_main.js?v=3" defer></script>
</head>
<body>

    <jsp:include page="/header/header.jsp" />

    <main class="map_wrap">
        <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>

        <div id="menu_wrap" class="bg_white">
            <div class="option">
                <div>
                    <form onsubmit="searchPlaces(); return false;">
                        <b>키워드 : </b><input type="text" value="강남 맛집" id="keyword" size="15"> 
                        <button type="submit">검색하기</button>
                    </form>
                </div>
            </div>
            <br>
            <hr>
            <ul id="placesList"></ul>
            <div id="pagination"></div>
        </div>
    </main>
</body>
</html>