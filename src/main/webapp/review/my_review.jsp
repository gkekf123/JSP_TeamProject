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

int reviewCount = list.size();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%= ctxPath %>/review/my_review.css">
<script src="<%= ctxPath %>/review/my_review.js" defer></script>
<title>마이리뷰</title>
<!-- Bootstrap & Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
    const ctxPath = "<%= ctxPath %>";
</script>
</head>
<body>
<jsp:include page="/header/header.jsp" />

<div class="container">
	
	        <div class="sidebar">
	            <ul>
	                <li onclick="location.href='<%=ctxPath%>/store/store_main.jsp'">맛집 목록</li>
	                <li onclick="location.href='<%=ctxPath%>/member/my_page.jsp'">마이페이지</li>
	                <li onclick="location.href='<%=ctxPath%>/user/wish_list.jsp'">찜 목록</li>
	                <li style="font-weight:bold; background-color:#f39c12; color:#fff;">내가 쓴 리뷰</li>
	                <li onclick="location.href='<%=ctxPath%>/login/logout_action.jsp'" style="color:#e74c3c; margin-top:20px;">로그아웃</li>
	            </ul>
	        </div>

	<div class="content">
		<div class="header">
		<h3>마이리뷰 (<%= reviewCount %>)</h3>
	</div>
	
	<div class="my-review-list">
<% if (list.isEmpty()) { %>
    <p class="empty">작성한 리뷰가 없습니다.</p>
<% } else { 
    for (ReviewDTO dto : list) { %>

    <div class="review-item" data-review-idx="<%=dto.getReviewIdx()%>" data-store-idx="<%= dto.getStoreIdx() %>">

        <!-- 상단 -->
        <div class="review-top">
        	<span class="store-name"><%= dto.getStoreName() %></span>
            <span class="review-date"><%= dto.getReviewCreatedAt() %></span>
        </div>
        
        <!-- 이미지 -->
        <% if (dto.getReviewImg1() != null) { %>
        <div class="review-img">
            <% if (dto.getReviewImg1() != null && !dto.getReviewImg1().equals("")) { %>
		        <img src="<%=ctxPath%>/images/review_upload/<%=dto.getReviewImg1()%>">
		    <% } %>
		    
		    <% if (dto.getReviewImg2() != null && !dto.getReviewImg2().equals("")) { %>
		        <img src="<%=ctxPath%>/images/review_upload/<%=dto.getReviewImg2()%>">
		    <% } %>
		    
		    <% if (dto.getReviewImg3() != null && !dto.getReviewImg3().equals("")) { %>
		        <img src="<%=ctxPath%>/images/review_upload/<%=dto.getReviewImg3()%>">
		    <% } %>
		    
		    <% if (dto.getReviewImg4() != null && !dto.getReviewImg4().equals("")) { %>
		        <img src="<%=ctxPath%>/images/review_upload/<%=dto.getReviewImg4()%>">
		    <% } %>
		    
		    <% if (dto.getReviewImg5() != null && !dto.getReviewImg5().equals("")) { %>
		        <img src="<%=ctxPath%>/images/review_upload/<%=dto.getReviewImg5()%>">
		    <% } %>
        </div>
        <% } %>

        <!-- 내용 -->
        <div class="review-content">
            <%= dto.getReviewContent() %>
        </div>

		<div class="review-footer">
			 <!-- 별점 -->
	        <div class="review-rating">
	        	<i class="bi bi-star-fill"></i>
	            <%= dto.getReviewRating() %>
	        </div>
	        
	        <!-- 삭제 -->
	        <div class="review-actions">
	        	<button class="review-edit-btn">수정</button>
	            <button type="button" class="btn-delete" 
	                onclick="deleteMyReview(<%= dto.getReviewIdx() %>, <%= dto.getStoreIdx() %>)">
	                삭제
	            </button>
	        </div>
		</div>
    </div>
<% }} %>
</div>
	</div>
</div>
<jsp:include page="/review/review_write.jsp"/>
<jsp:include page="/footer/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
function deleteMyReview(reviewIdx, storeIdx) {
    if (confirm("정말로 이 리뷰를 삭제하시겠습니까?")) {
        // 삭제 처리를 담당하는 jsp로 이동 (경로 확인 필요)
        location.href = "<%= ctxPath %>/review/my_review_delete.jsp?reviewIdx=" + reviewIdx + "&storeIdx=" + storeIdx + "&from=myreview";
    }
}
</script>
</body>
</html>