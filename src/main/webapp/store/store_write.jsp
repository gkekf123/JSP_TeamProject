<%@page import="com.team.project.dto.MemberDTO"%> <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 2. 관리자 권한 체크 로직
    boolean isAdmin = false;
    Object loginObj = session.getAttribute("loginMember");
    
    if (loginObj != null && loginObj instanceof MemberDTO) {
        MemberDTO loginMember = (MemberDTO) loginObj;
        
        if ("admin".equals(loginMember.getMemberRole())) {
            isAdmin = true;
        }
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
<title>맛집 등록</title>
<style>
    body { font-family: 'Noto Sans KR', sans-serif; background: #f4f4f4; }
    .container { width: 600px; margin: 50px auto; padding: 30px; background: #fff; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
    h2 { text-align: center; color: #333; }
    .form-group { margin-bottom: 15px; }
    .form-group label { display: block; font-weight: bold; margin-bottom: 5px; }
    .form-group input, .form-group select, .form-group textarea {
        width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; box-sizing: border-box;
    }
    .btn-area { text-align: center; margin-top: 20px; }
    .btn-submit { background: #3498db; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; font-size: 16px; }
    .btn-cancel { background: #95a5a6; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; font-size: 16px; margin-left: 10px; }
</style>
</head>
<body>

<jsp:include page="/header/header.jsp" />

<div class="container">
    <h2>🍽 맛집 정보 등록</h2>
    
    <form action="store_write_action.jsp" method="post" enctype="multipart/form-data">
        
        <div class="form-group">
            <label>가게 이름</label>
            <input type="text" name="store_name" required placeholder="상호명을 입력하세요">
        </div>

        <div class="form-group">
            <label>카테고리</label>
            <select name="store_category">
                <option value="한식">한식</option>
                <option value="중식">중식</option>
                <option value="일식">일식</option>
                <option value="양식">양식</option>
                <option value="카페/디저트">카페/디저트</option>
                <option value="기타">기타</option>
            </select>
        </div>

        <div class="form-group">
            <label>전화번호</label>
            <input type="text" name="store_tel" placeholder="02-0000-0000">
        </div>

        <div class="form-group">
            <label>주소</label>
            <input type="text" name="store_addr" required placeholder="도로명 주소 입력">
        </div>

        <div class="form-group">
            <label>한줄 소개</label>
            <textarea name="store_intro" rows="3" placeholder="가게에 대한 간단한 소개를 입력하세요"></textarea>
        </div>

        <div class="form-group">
            <label>대표 이미지</label>
            <input type="file" name="store_img" accept="image/*">
        </div>

        <div class="btn-area">
            <button type="submit" class="btn-submit">등록하기</button>
            <button type="button" class="btn-cancel" onclick="history.back()">취소</button>
        </div>
    </form>
</div>

<jsp:include page="/footer/footer.jsp" />

</body>
</html>