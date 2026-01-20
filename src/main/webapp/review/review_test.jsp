<%@page import="com.team.project.dao.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String ctxPath = request.getContextPath();
String loginId = (String)session.getAttribute("login_id");
//int storeIdx = request.getParameter("storeIdx");
int storeIdx = 5; // 예시: DB에서 가져온 가게 번호
ReviewDAO dao = new ReviewDAO();
int reviewCount = dao.countReview(storeIdx) +1 ; 
request.setAttribute("reviewCount", reviewCount);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<style type="text/css">
	.btn{
		margin-top: 60px;
	}
</style>
</head>

<body>
    <jsp:include page="/header/header.jsp" />

	<button class="btn btn-dark"
		id="reviewBtn"
		data-bs-toggle="modal"
        data-bs-target="#reviewModal"
        data-store-idx="<%=storeIdx%>">
    	리뷰 작성
	</button>
	
	<!-- data-login="%= (loginId != null) %>"  -->
	
	<jsp:include page="/review/review_write.jsp"/>

    <jsp:include page="/footer/footer.jsp" />
</body>
</html>