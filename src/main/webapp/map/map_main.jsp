<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
    String ctxPath = request.getContextPath(); 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%= ctxPath %>/map/map.css">
<script src="<%= ctxPath %>/map/map.js"></script>
<title>맛집지도 - 메인</title>
</head>
<body>

    <jsp:include page="/header/header.jsp" />

    <main>
    	<h1>지도 페이지</h1>
    </main>
    
    <jsp:include page="/footer/footer.jsp" />

</body>
</html>