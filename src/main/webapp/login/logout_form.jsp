<%@page import="com.team.project.dto.MemberDTO"%>
<%@page import="com.team.project.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String loginok = (String)session.getAttribute("loginok");
    if(loginok == null){
        response.sendRedirect(request.getContextPath()+"/login/login_form.jsp");
        return;
    }

    String member_id = (String)session.getAttribute("member_id");

    MemberDAO dao = new MemberDAO();
    MemberDTO dto = dao.getMyInfo(member_id);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 상태</title>

<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

<style>
body {
    background-color: #f4f4f4;
    font-family: 'Noto Sans KR', sans-serif;
}
.container {
    width: 400px;
    margin: 150px auto;
    padding: 40px;
    background-color: #fff;
    border-radius: 15px;
    box-shadow: 0 5px 20px rgba(0,0,0,0.1);
}
.login-title {
    text-align: center;
    font-size: 22px;
    font-weight: bold;
    margin-bottom: 30px;
}
.login-btn {
    width: 100%;
    height: 45px;
    border: none;
    border-radius: 10px;
    color: white;
    font-size: 16px;
    background-color: #f39c12;
    cursor: pointer;
}
.login-btn:hover {
    background-color: #e67e22;
}
.signup-btn {
    width: 100%;
    height: 45px;
    margin-top: 10px;
    border-radius: 10px;
    border: 1px solid #f39c12;
    background-color: #fff;
    color: #f39c12;
    font-size: 15px;
    cursor: pointer;
}
</style>
</head>

<body>
<jsp:include page="/header/header.jsp" />

<div class="container">
    <div class="login-title">로그인 상태</div>

    <div style="text-align:center; margin-bottom:25px;">
        <b><%=dto.getMemberName()%></b> 님이 로그인 중입니다
    </div>

    <button class="login-btn"
        onclick="location.href='<%=request.getContextPath()%>/login/logout_action.jsp'">
        로그아웃
    </button>

    <button class="signup-btn"
        onclick="location.href='<%=request.getContextPath()%>/index.jsp'">
        메인으로 이동
    </button>
</div>

<jsp:include page="/footer/footer.jsp" />
</body>
</html>