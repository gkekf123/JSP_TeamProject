<%@page import="com.team.project.dto.BookmarkDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.team.project.dao.BookmarkDAO"%>
<%@page import="com.team.project.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String ctxPath = request.getContextPath();
    request.setCharacterEncoding("UTF-8");

    // 1. 로그인 확인
    String myId = null;
    Object loginObj = session.getAttribute("loginMember");
    if (loginObj instanceof MemberDTO) {
        myId = ((MemberDTO) loginObj).getMemberId();
    } else if (loginObj instanceof String) {
        myId = (String) loginObj;
    }

    // 2. 내 찜 목록(외부 가게) 가져오기 -> JS에서 쓰기 위해 문자열 생성
    StringBuilder myBookmarkUrls = new StringBuilder();
    if (myId != null) {
        BookmarkDAO dao = new BookmarkDAO();
        List<BookmarkDTO> list = dao.selectMyBookmarkList(myId);
        
        for (BookmarkDTO dto : list) {
            // 외부 가게(store_idx == 0)이고 URL이 있는 경우
            if (dto.getStoreIdx() == 0 && dto.getPlaceUrl() != null) {
                if (myBookmarkUrls.length() > 0) myBookmarkUrls.append(",");
                myBookmarkUrls.append("\"").append(dto.getPlaceUrl()).append("\"");
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
    <link rel="stylesheet" href="<%= ctxPath %>/map/map_main.css?v=3">
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4d6ec00692a6f465a841ee2f2e06d862&libraries=services"></script>
    <script src="<%= ctxPath %>/map/map_main.js?v=4" defer></script>
    
    <script>
        // 서버에서 가져온 찜 목록(URL)을 JS Set으로 변환 (O(1) 검색용)
        const myJjimSet = new Set([<%= myBookmarkUrls.toString() %>]);
        const ctxPath = "<%= ctxPath %>"; // JS에서 경로 사용
    </script>
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