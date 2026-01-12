<%@page import="com.team.project.dao.MemberDao"%>
<%@page import="com.team.project.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String ctxPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="<%= ctxPath %>/sign/sign_up.css">
<script src="<%= ctxPath %>/sign/sign_up.js"></script>
</head>
<body>
 <jsp:include page="/header/header.jsp" />
<div class="signup-container">
    <div class="signup-title">회원가입</div>

<form action="Sign_Up_Action.jsp" method="post" enctype="multipart/form-data">
<table class="table signup-table">
<!-- 관리자 체크박스 -->
    <tr>
        <th>권한</th>
        <td>
            <label>
                <input type="checkbox" name="member_role" value="admin">
                관리자
            </label>
        </td>
    </tr>
    
    <tr>
        <th>아이디</th>
        <td><input type="text" name="member_id" required placeholder="아이디 입력"></td>
    </tr>
    <tr>
        <th>비밀번호</th>
        <td><input type="password" name="member_pw" required placeholder="비밀번호 입력"></td>
    </tr>
    <tr>
        <th>닉네임</th>
        <td><input type="text" name="member_name" required placeholder="닉네임 입력"></td>
    </tr>

    <tr>
        <th>이메일</th>
        <td><input type="email" name="member_email" placeholder="abcd@gmail.com"></td>
    </tr>
    <tr>
        <th>전화번호</th>
        <td><input type="text" name="member_hp" placeholder="02-***-****"></td>
    </tr>
    <tr>
        <th>주소</th>
        <td><input type="text" name="member_addr" placeholder="서울특별시 강남구"></td>
    </tr>
    <tr>
        <th>프로필사진</th>
        <td>
            <div class="d-flex align-items-center gap-2">
            	<div class="preview-box">
                	<img id="preview" src="" alt="">
                </div>
                <input type="file" name="member_img" accept="image/*" onchange="previewImage(this)">
            </div>
        </td>
        </tr>
        
<!-- 회원가입 버튼 -->
    <tr>
        <td colspan="2" align="center">
            <button type="submit" class="signup-btn">회원가입</button>
        </td>
    </tr>
</table>
</form>
<jsp:include page="/footer/footer.jsp" />
</div>
</body>
</html>