<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String ctxPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
<meta charset="UTF-8">
<link rel="stylesheet" href="<%= ctxPath %>/login/login.css">
<script src="<%= ctxPath %>/login/login.js"></script>
<title>Insert title here</title>
</head>
<body>
<jsp:include page="/header/header.jsp" />
<div class="container">

<!-- title -->
	<div class="login-title">로그인</div>
	
	<!-- 상단 -->
	<div class="login-option">
		<label class="admin-check">
            <input type="checkbox" name="admin_login" value="admin">
            관리자
        	</label>
		<div class="login-sign">
			<a href='<%=ctxPath%>/sign/sign_up.jsp'>회원가입</a>
		</div>
	</div>
	
	<!-- 로그인 -->
	<form action="login_action.jsp" method="post">
		<div class="login-id input-box">
			<input type="text" name="member_id" placeholder="아이디" required>
		</div>
		
		<div class="login-pw input-box">
			<input type="text" name="member_pw" placeholder="비밀번호" required>
		</div>
		
		<button type="submit" class="login-btn">로그인</button>
	</form>
</div>
<jsp:include page="/footer/footer.jsp" />
</body>
</html>