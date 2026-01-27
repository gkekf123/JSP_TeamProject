<%@page import="com.team.project.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//0. 기본 설정
request.setCharacterEncoding("UTF-8");
String ctxPath = request.getContextPath();

    // 2. 관리자 권한 체크 로직
    boolean isAdmin = false;
    String loginOk = (String) session.getAttribute("loginok");
    String memberRole = (String) session.getAttribute("member_role");

    if ("yes".equals(loginOk) && "admin".equals(memberRole)) {
        isAdmin = true;
    }
    if (!isAdmin) {
%>
    <script>
        alert("관리자만 접근할 수 있습니다.");
        location.href = "store_main.jsp";
    </script>
<%
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>맛집공유 글쓰기</title>
<link rel="stylesheet" href="<%= ctxPath %>/news/news_write.css">
<script src="<%= ctxPath %>/news/news_write.js" defer></script>
</head>
<body>
<jsp:include page="/header/header.jsp" />
<form action="news_write_action.jsp" method="post" enctype="multipart/form-data">
<div class="write-wrap">
    <h2>📰 뉴스 등록</h2>
    
        <div class="form-group">
            <label>뉴스 제목</label>
            <input type="text" name="news_title" required>
        </div>

        <div class="form-group">
            <label>뉴스 URL</label>
            <input type="url" name="news_url" required>
        </div>

        <div class="form-group">
            <label>대표 이미지</label>
            <div class="img-upload-wrap">
		        <input type="file" name="news_img" accept="image/*"
		               onchange="previewImage(this)">
		        <img id="imgPreview" class="img-preview" style="display:none; width: 100px;">
    		</div>
        </div>

        <div class="form-group">
            <label>뉴스 출처</label>
            <input type="text" name="news_source">
        </div>

        <div class="btn-area">
            <button type="submit" class="btn-submit">등록하기</button>
            <button type="button" class="btn-cancel"
                    onclick="history.back()">취소</button>
        </div>
    </form>
</div>

<jsp:include page="/footer/footer.jsp" />
</body>
</html>