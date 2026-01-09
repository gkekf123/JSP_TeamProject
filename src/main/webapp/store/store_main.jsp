<%@page import="com.team.project.dto.StoreDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.team.project.dao.StoreDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // 1. 파라미터 받기 (정렬 기준)
    String sort = request.getParameter("sort");
    if (sort == null) sort = "latest"; // 기본값

    // 2. DB 데이터 가져오기
    StoreDAO dao = new StoreDAO();
    List<StoreDTO> storeList = dao.selectStoreList(sort);
%>

<!DOCTYPE html>
<html>
<head>
    <title>맛집 추천 리스트</title>
    <style>
        /* 간단한 CSS 스타일링 */
        .container { width: 1000px; margin: 0 auto; padding: 20px; }
        .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        
        /* 그리드 레이아웃 (3열) */
        .store-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr); /* 한 줄에 3개 */
            gap: 20px;
        }

        .store-card {
            border: 1px solid #ddd;
            border-radius: 8px;
            overflow: hidden;
            background: #fff;
            position: relative; /* 찜 아이콘 위치용 */
        }

        .store-img {
            width: 100%;
            height: 180px;
            background-color: #eee; /* 이미지 없을 때 배경색 */
            object-fit: cover;
        }
        
        .store-info { padding: 15px; }
        .store-name { font-size: 18px; font-weight: bold; margin-bottom: 5px; }
        .store-stats { color: #666; font-size: 14px; margin-bottom: 5px; }
        .store-addr { color: #999; font-size: 12px; }
        .star-icon { color: #f39c12; }
    </style>
</head>
<body>

<div class="container">
    <div class="header">
        <h1>맛집추천 메인메뉴</h1>
        
        <select id="sortFilter" onchange="changeSort()">
            <option value="latest" <%= "latest".equals(sort) ? "selected" : "" %>>최신순</option>
            <option value="rating" <%= "rating".equals(sort) ? "selected" : "" %>>별점 높은순</option>
            <option value="review" <%= "review".equals(sort) ? "selected" : "" %>>리뷰 많은순</option>
            <option value="view"   <%= "view".equals(sort) ? "selected" : "" %>>조회수순</option>
        </select>
    </div>

    <div class="store-grid">
        <% for(StoreDTO store : storeList) { %>
            <div class="store-card">
                <img src="<%= request.getContextPath() %>/images/<%= store.getStoreImg() %>" class="store-img" alt="가게사진" onerror="이미지 없음">
                <div class="store-info">
                    <div class="store-name"><%= store.getStoreName() %></div>
                    <div class="store-stats">
                        <span class="star-icon">★</span> <%= store.getStoreRatingAvg() %> 
                        (리뷰 <%= store.getStoreRatingCount() %>)
                    </div>
                    <div class="store-addr"><%= store.getStoreAddr() %></div>
                </div>
            </div>
        <% } %>
    </div>
</div>

<script>
    // 정렬 변경 시 페이지 새로고침하며 파라미터 전달
    function changeSort() {
        var sortVal = document.getElementById("sortFilter").value;
        location.href = "store_list.jsp?sort=" + sortVal;
    }
</script>

</body>
</html>