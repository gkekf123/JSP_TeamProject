<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
    String ctxPath = request.getContextPath(); 
%>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%= ctxPath %>/mainpage/main_page.css">
<script src="<%= ctxPath %>/mainpage/main_page.js" defer></script>

<section class="main">
		<!-- 백그라운드 이미지 삽입 -->
    	<div class="bg" id="bg"></div> 
    
    	<div class="overlay"></div>

    	<div class="search-box">
        	<input type="text" placeholder="지역, 음식점을 검색하세요">
    	</div>
</section>
