<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>맛집리뷰 - 메인</title>
</head>
<body>

    <jsp:include page="/header/header.jsp" />

    <main>
    	<jsp:include page="/main/main.jsp" />
    </main>

    <jsp:include page="/footer/footer.jsp" />

</body>
</html>