<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="ex1.css">
<script src="ex1.js" defer></script>
<title>맛집 리뷰 사이트</title>
</head>
<body>
<% String ctxPath = request.getContextPath(); %>
<jsp:include page="<%= ctxPath %>/public/public.jsp"/>

<!-- ===== 메인 ===== -->
<section class="main">
	<!-- 백그라운드 이미지 삽입 -->
    <div class="bg" id="bg"></div> 
    
    <div class="overlay"></div>

    <div class="search-box">
        <input type="text" placeholder="지역, 음식점을 검색하세요">
    </div>
</section>

</body>
</html>