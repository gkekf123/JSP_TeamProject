<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.team.project.dao.BookmarkDAO" %>
<%@ page import="com.team.project.dto.BookmarkDTO" %>

<%
    String loginOk = (String) session.getAttribute("loginok");
    String role = (String) session.getAttribute("member_role");
    String memberId = (String) session.getAttribute("member_id");

    if (loginOk == null) {
        response.sendRedirect(request.getContextPath() + "/login/login_form.jsp");
        return;
    }

    if (!"USER".equalsIgnoreCase(role)) {
        response.sendRedirect(request.getContextPath() + "/member/my_page.jsp");
        return;
    }

    BookmarkDAO dao = new BookmarkDAO();
    List<BookmarkDTO> list = dao.selectMyBookmarkList(memberId);

    String ctxPath = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 찜 목록</title>

<style>
body {
    margin: 0;
    padding-top: 80px; /* 헤더 높이 */
    font-family: 'Noto Sans KR', sans-serif;
    background-color: #f4f4f4;
}

/* 마이페이지랑 동일 */
.container {
    display: flex;
    max-width: 1000px;
    margin: 30px auto;
    gap: 20px;
}

/* 사이드바 */
.sidebar {
    width: 220px;
    background-color: #fff;
    padding: 20px;
    border-radius: 12px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.1);
}

.sidebar ul {
    list-style: none;
    padding: 0;
}

.sidebar li {
    margin-bottom: 15px;
    padding: 10px;
    border-radius: 8px;
    cursor: pointer;
    font-weight: 500;
}

.sidebar li:hover {
    background-color: #f39c12;
    color: #fff;
}

/* 오른쪽 컨텐츠 */
.content {
    flex: 1;
    background-color: #fff;
    padding: 30px 40px;
    border-radius: 15px;
    box-shadow: 0 5px 20px rgba(0,0,0,0.1);
}

/* 찜 카드 */
.wish-card {
    border-bottom: 1px solid #eee;
    padding: 20px 0;
}

.wish-card:last-child {
    border-bottom: none;
}

.place-name {
    font-size: 18px;
    font-weight: bold;
}

.place-addr {
    color: #666;
    margin-top: 5px;
}

.like-date {
    font-size: 13px;
    color: #999;
    margin-top: 8px;
}

.empty {
    text-align: center;
    color: #888;
    margin-top: 50px;
}
</style>
</head>

<body>

<jsp:include page="/header/header.jsp" />

<div class="container">

    <!-- 사이드바 (마이페이지랑 동일) -->
    <div class="sidebar">
        <ul>
            <li onclick="location.href='<%=ctxPath%>/index.jsp'">메인</li>
            <li onclick="location.href='<%=ctxPath%>/member/my_page.jsp'">마이페이지</li>
            <li style="font-weight:bold; color:#f39c12;">찜 목록</li>
            <li onclick="location.href='<%=ctxPath%>/user/review_list.jsp'">리뷰 작성 목록</li>
            <li onclick="location.href='<%=ctxPath%>/login/logout_action.jsp'"
                style="color:#e74c3c;">로그아웃</li>
        </ul>
    </div>

    <!-- 오른쪽 컨텐츠 -->
    <div class="content">
        <h2 style="text-align:center;">내 찜 목록</h2>

        <% if (list == null || list.isEmpty()) { %>
            <div class="empty">찜한 맛집이 없습니다.</div>
        <% } else {
            for (BookmarkDTO dto : list) { %>

            <div class="wish-card">
                <div class="place-name"><%= dto.getPlaceName() %></div>
                <div class="place-addr"><%= dto.getPlaceAddr() %></div>
                <div class="like-date">찜한 날짜 : <%= dto.getLikeDate() %></div>
            </div>

        <% } } %>
    </div>
</div>

</body>
</html>

