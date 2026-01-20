<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 0. 기본 설정
request.setCharacterEncoding("UTF-8");
String ctxPath = request.getContextPath();
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



<jsp:include page="/footer/footer.jsp" />
</body>
</html>