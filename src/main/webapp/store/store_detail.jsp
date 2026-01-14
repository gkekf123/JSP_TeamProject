<%@page import="com.team.project.dto.MemberDTO"%>
<%@page import="com.team.project.dao.StoreDetailDAO"%>
<%@page import="com.team.project.dto.StoreDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	 	//0. 기본 설정
	    request.setCharacterEncoding("UTF-8");
	    String ctxPath = request.getContextPath();
	    String storeIdxParam = request.getParameter("idx");

	    if(storeIdxParam == null){
	        response.sendRedirect(ctxPath + "/main.jsp");
	        return;
	    }

	    long storeIdx = Long.parseLong(storeIdxParam);

	    StoreDetailDAO dao = new StoreDetailDAO();
	    StoreDTO dto = dao.selectDetailIntro(storeIdx);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<%= ctxPath %>/store/store_detail.css">
<script src="<%= ctxPath %>/store/store_detail.js" defer></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<jsp:include page="/header/header.jsp" />

<!-- 이미지 슬라이드 -->
<div class="container">
	<div class="info">
		<div id="carouselExampleIndicators" class="carousel slide slider-container" data-bs-ride="carousel">
		  <div class="carousel-indicators">
		    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
		    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
		    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
		  </div>
		  <div class="carousel-inner">
		    <div class="carousel-item active">
		      <img src="<%= dto.getStoreImg() %>" class="d-block w-100 carousel-img" alt="...">
		    </div>
		    <div class="carousel-item">
		      <img src="<%= dto.getStoreImg2() %>" class="d-block w-100 carousel-img" alt="...">
		    </div>
		    <div class="carousel-item">
		      <img src="<%= dto.getStoreImg3() %>" class="d-block w-100 carousel-img" alt="...">
		    </div>
		  </div>
		  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
		    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
		    <span class="visually-hidden">Previous</span>
		  </button>
		  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
		    <span class="carousel-control-next-icon" aria-hidden="true"></span>
		    <span class="visually-hidden">Next</span>
		  </button>
		</div>
	
		<!-- 가게 정보 -->
		<div class="store-info">
		    <div class="store-text">
		        <span class="store-category"><%=dto.getStoreCategory() %></span>
		
		        <div class="store-title-row">
		        	<div class="store-text">
			            <h2 class="store-name"><%=dto.getStoreName()%></h2>
			            <p class="store-intro"><%=dto.getStoreIntro() %></p>
		            </div>
		
		            <!-- 찜 버튼 -->
		            <button class="like-btn">★</button>
		        </div>
		
		        <p class="store-rating">
		            ★ <%=dto.getStoreRatingAvg() %> (<%=dto.getStoreRatingCount() %>)
		        </p>
		
		        <p class="store-tel">
		            📞 <%=dto.getStoreTel()%>
		        </p>
		
		        <p class="store-addr">
		            📍 <%=dto.getStoreAddr()%>
		        </p>
		    </div>
		</div>
	</div>
</div>
<jsp:include page="/footer/footer.jsp" />
</body>
</html>