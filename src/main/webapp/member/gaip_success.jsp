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

.profile-img {
    width: 120px;
    height: 120px;
    border-radius: 50%;
    object-fit: cover;
    display: block;
    margin: 0 auto 20px auto; /* ⭐ 가운데 정렬 */
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
    String memberId = (String)session.getAttribute("member_id");
    String memberName = (String)session.getAttribute("member_name");
    String memberImg  = (String) session.getAttribute("member_img");
    
    if(memberImg == null) memberImg = "noimage.png";
%>
<body>
<jsp:include page="/header/header.jsp" />
<div class="container">
	<img src="<%=request.getContextPath()%>/upload/<%=memberImg%>" class="profile-img">
	

    <p style="text-align: center;">
        <b><%=memberName %></b>님의 회원가입이<br>
        정상적으로 완료되었습니다 🎉
    </p>

    <button class="main-btn"
        onclick="location.href='<%=request.getContextPath()%>/login/login_form.jsp'">
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
