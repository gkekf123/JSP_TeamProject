<%@page import="com.team.project.dao.MemberDao"%>
<%@page import="com.team.project.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
<title>Insert title here</title>
<style>
    body {
        background-color: #f4e3d6;
        font-family: 'Nanum Myeongjo';
    }

    .signup-container {
        width: 600px;
        margin: 80px auto;
    }

    .signup-title {
        font-size: 22px;
        font-weight: bold;
        margin-bottom: 30px;
    }

    .signup-table th {
        width: 120px;
        background-color: #f8f8f8;
        vertical-align: middle;
    }

    .signup-table input[type="text"],
    .signup-table input[type="password"],
    .signup-table input[type="email"] {
        width: 100%;
        height: 40px;
        background-color: none;
        border: 1px solid gray;
        border-radius: 10px;
        padding: 0 10px;
    }
	
	.signup-table input[type="file"] {
        width: 100%;
    }
    #preview{
    	width: 200px;
    }

    .signup-btn {
        margin-top: 30px;
        background-color: #ddd;
        border: none;
        padding: 10px 40px;
    }
</style>
<script>
function previewImage(input) {
    if (input.files && input.files[0]) {
        const reader = new FileReader();
        reader.onload = function(e) {
            document.getElementById('preview').src = e.target.result;
        };
        reader.readAsDataURL(input.files[0]);
    }
}
</script>
</head>
<body>
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

    <tr>
        <td colspan="2" align="center">
            <button type="submit" class="btn btn-primary">회원가입</button>
        </td>
    </tr>
</table>
</form>
</body>
</html>