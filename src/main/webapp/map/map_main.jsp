<%@page import="com.team.project.dto.BookmarkDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.team.project.dao.BookmarkDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String ctxPath = request.getContextPath();
    request.setCharacterEncoding("UTF-8");

    // 1. 로그인 확인
    String myId = (String) session.getAttribute("member_id");

    // 2. 내 찜 목록 가져오기 (카카오 ID 수집용)
    StringBuilder myBookmarkIds = new StringBuilder();
    
    if (myId != null) {
        BookmarkDAO dao = new BookmarkDAO();
        List<BookmarkDTO> list = dao.selectMyBookmarkList(myId);
        
        for (BookmarkDTO dto : list) {
            if (dto.getKakaoId() != null && !dto.getKakaoId().isEmpty()) {
                if (myBookmarkIds.length() > 0) myBookmarkIds.append(",");
                myBookmarkIds.append("\"").append(dto.getKakaoId()).append("\"");
            }
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>맛집지도 - 검색</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="<%= ctxPath %>/map/map_main.css?v=4">
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4d6ec00692a6f465a841ee2f2e06d862&libraries=services"></script>
    
    <script>
        // 서버 데이터를 JS 변수로 변환
        const myJjimSet = new Set([<%= myBookmarkIds.toString() %>]);
        const ctxPath = "<%= ctxPath %>"; 
    </script>
    
    <script src="<%= ctxPath %>/map/map_main.js?v=<%= System.currentTimeMillis() %>" defer></script>
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