<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
    String ctxPath = request.getContextPath(); 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%= ctxPath %>/mainpage/main_page.css">
<script src="<%= ctxPath %>/mainpage/main_page.js"></script>
<title>메인페이지</title>
</head>
<body>

    <jsp:include page="/header/header.jsp" />

    <main>
    	<h1>메인 페이지</h1>
    </main>
</body>
</html>