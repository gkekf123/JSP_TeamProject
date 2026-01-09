<%@page import="java.util.List"%>
<%@page import="com.team.project.dto.StoreDTO"%>
<%@page import="com.team.project.dao.Store_DetailDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    
<%
String idxParam = request.getParameter("store_idx");

if (idxParam == null) {
    out.println("<h2>잘못된 접근입니다.</h2>");
    return;
}

long storeIdx = Long.parseLong(idxParam);

Store_DetailDao dao = new Store_DetailDao();
StoreDTO dto = dao.selectDetailIntro(storeIdx);

%>

</div>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- 이미지 슬라이드 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css"/>

<style>
body {
    margin: 0;
    font-family: Arial, sans-serif;
}
.container {
    width: 100%;
}
.content {
	width: 80%;
    margin: 0 auto;
}

/* 이미지 */
.img img {
    width: 100%;        
    height: 400px;      
    object-fit: cover; 
}
.img{
	width: 100%;
	margin-top: 30px;
}

/* 가게 정보 */
.info {
    width: 100%;
    margin-top: 30px;
}
.category {
    color: #777;
    font-size: 14px;
}
.store-name {
    font-size: 32px;
    font-weight: bold;
}

/* 찜 */
.heart {
 	background: none;
    border: none;
    float: right;
    font-size: 28px;
    cursor: pointer;
}
.heart i {
    font-size: 28px;
    color: #717171;   /* 기본 회색 */
    transition: color 0.2s ease;
}
.heart i.active {
    color: hotpink;   /* 핑크 */
}
.heart:focus {
    outline: none;
    box-shadow: none;
}


.desc {
    margin-top: 10px;
    font-size: 15px;
}
.detail {
    margin-top: 8px;
    font-size: 14px;
    color: #444;
}
.line {
    margin: 25px 0;
    border-bottom: 1px solid #ddd;
}
.rating , .tel{
	margin-right: 5px;
}
</style>
</head>
<!-- 이미지 슬라이드 -->
<body>
<div class="container">
	<div class="content">

    <!-- 이미지 -->
		<div class="img">
			<img src="<%= request.getContextPath() %>/images/<%=dto.getStoreImg()%>">
		</div>

    <!-- 가게 정보 영역 -->
    <div class="info">
        <div class="category"><%=dto.getStoreCategory()%></div>

        <div class="store-name">
            <%=dto.getStoreName()%>
            <button type="submit" class="heart" id="heart"><i class="bi bi-heart"></i></button>
        </div>

        <div class="desc"><%=dto.getStoreIntro()%></div>

        <div class="detail">
            <i class="bi bi-star-fill rating"></i>
            <%=dto.getStoreRatingAvg()%> (<%=dto.getStoreRatingCount()%>)
            &nbsp;&nbsp;
            <i class="bi bi-telephone tel"></i><%=dto.getStoreTel()%>
        </div>

        <div class="detail">
            <i class="bi bi-geo-alt"></i>
            <%=dto.getStoreAddr()%>
        </div>

        <div class="line"></div>
    </div>
</div>
</div>
<script>

document.getElementById("heart").addEventListener("click", function () {
    const icon = this.querySelector("i");

    if (icon.classList.contains("bi-heart")) {
        icon.classList.remove("bi-heart");
        icon.classList.add("bi-heart-fill");
        icon.classList.add("active");   // 핑크
    } else {
        icon.classList.remove("bi-heart-fill");
        icon.classList.add("bi-heart");
        icon.classList.remove("active"); // 회색
    }
});

</script>
</body>
</html>