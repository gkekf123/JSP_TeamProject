<%@page import="com.team.project.dao.StoreDAO"%>
<%@page import="com.team.project.dto.MemberDTO"%>
<%@page import="com.team.project.dto.ReviewDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.team.project.dao.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 0. 기본 설정
request.setCharacterEncoding("UTF-8");
String ctxPath = request.getContextPath();

String loginOk = (String) session.getAttribute("loginok");
String memberId = (String) session.getAttribute("member_id");

if (!"yes".equals(loginOk) || memberId == null) {
    response.sendRedirect(ctxPath + "/login/login_form.jsp");
    return;
}

ReviewDAO dao = new ReviewDAO();
List<ReviewDTO> list = dao.getMyReviews(memberId);


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%= ctxPath %>/review/my_review.css">
<script src="<%= ctxPath %>/review/my_review.js" defer></script>
<title>Insert title here</title>
</head>
<body>
<jsp:include page="/header/header.jsp" />

<div class="container">
	<div class="header">
		<h3>마이리뷰 목록</h3>
	</div>
	<div class="my-review-list">

<% if (list.isEmpty()) { %>
    <p class="empty">작성한 리뷰가 없습니다.</p>
<% } else { 
    for (ReviewDTO dto : list) { %>

    <div class="review-item">

        <!-- 상단 -->
        <div class="review-top">
        	<span class="store-name"><%= dto.getStoreName() %></span>
            <span class="review-date"><%= dto.getReviewCreatedAt() %></span>
        </div>
        
        <!-- 이미지 -->
        <% if (dto.getReviewImg1() != null) { %>
        <div class="review-img">
            <img src="<%=ctxPath%>/images/review_upload/<%=dto.getReviewImg1()%>">
        </div>
        <% } %>

        <!-- 내용 -->
        <div class="review-content">
            <%= dto.getReviewContent() %>
        </div>

        <!-- 별점 -->
        <div class="review-rating">
            ⭐ <%= dto.getReviewRating() %>
        </div>

    </div>

<% }} %>
</div>
	
</div>

<jsp:include page="/footer/footer.jsp" />
</body>
</html>