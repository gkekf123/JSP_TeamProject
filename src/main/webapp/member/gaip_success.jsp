<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 완료</title>

<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

<style>
body{
    background-color: #f4f4f4;
    font-family: 'Noto Sans KR', sans-serif;
}

/* login_test_form 과 동일 */
.container{
    width: 400px;
    margin: 150px auto;
    padding: 40px;
    background-color: #fff;
    border-radius: 15px;
    box-shadow: 0 5px 20px rgba(0,0,0,0.1);
}

.logo{
    text-align: center;
    margin-bottom: 25px;
}

.logo img{
    width: 180px;
}

.complete-text{
    text-align: center;
    font-size: 16px;
    margin-bottom: 30px;
}

/* 메인 컬러 통일 */
.main-btn{
    width: 100%;
    height: 45px;
    border: none;
    border-radius: 10px;
    background-color: #f39c12;
    color: white;
    font-size: 16px;
    cursor: pointer;
}

.main-btn:hover{
    background-color: #e67e22;
}

.sub-btn{
    width: 100%;
    height: 45px;
    margin-top: 10px;
    border-radius: 10px;
    border: 1px solid #f39c12;
    background-color: white;
    color: #f39c12;
    font-size: 15px;
    cursor: pointer;
}

.sub-btn:hover{
    background-color: #fdf2e9;
}
</style>
</head>

<%
    String id = request.getParameter("member_id");
%>

<body>
<jsp:include page="/header/header.jsp" />
<div class="container">

    <div class="logo">
        <img src="<%=request.getContextPath()%>/images/logo1.png">
    </div>

    <div class="complete-text">
        <b><%=id %></b>님의 회원가입이<br>
        정상적으로 완료되었습니다 🎉
    </div>

    <button class="main-btn"
        onclick="location.href='<%=request.getContextPath()%>/login/login_test.jsp'">
        로그인
    </button>

    <button class="sub-btn"
        onclick="location.href='<%=request.getContextPath()%>/index.jsp'">
        메인으로
    </button>

</div>
<jsp:include page="/footer/footer.jsp" />
</body>
</html>
