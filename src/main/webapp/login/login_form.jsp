<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 1. 세션에서 저장된 아이디 가져오기
    String saveId = (String) session.getAttribute("saveid");
    
    // 2. 저장된 아이디가 있는지 확인 (있으면 true -> 체크박스 체크용)
    boolean isSave = (saveId != null);

    // 3. null이면 화면에 "null" 글자가 뜨지 않도록 빈 문자열로 변경
    if (saveId == null) saveId = "";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 로그인</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<style>
    body { background-color: #f4f4f4; font-family: 'Noto Sans KR', sans-serif; }
    .container { width: 400px; margin: 150px auto; padding: 40px; background-color: #fff; border-radius: 15px; box-shadow: 0 5px 20px rgba(0,0,0,0.1); }
    .login-title { text-align: center; font-size: 22px; font-weight: bold; margin-bottom: 30px; }
    .input-box { margin-bottom: 15px; }
    .input-box input { width: 100%; height: 45px; border-radius: 10px; border: 1px solid #ccc; padding: 0 15px; font-size: 14px; box-sizing:border-box;}
    .login-option { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; font-size: 14px; color: #555; }
    .login-btn { width: 100%; height: 45px; border: none; border-radius: 10px; color: white; font-size: 16px; cursor: pointer; background-color: #f39c12; }
    .login-btn:hover { background-color: #e67e22; }
    .signup-btn { width: 100%; height: 45px; margin-top: 10px; border-radius: 10px; border: 1px solid #f39c12; background-color: #fff; color: #f39c12; font-size: 15px; cursor: pointer; }
</style>
</head>
<body>

<jsp:include page="/header/header.jsp" />

<div class="container">
    <div class="login-title">회원 로그인</div>

    <form action="login_action.jsp" method="post">
        
        <div class="input-box">
            <input type="text" name="member_id" placeholder="아이디" required 
                   value="<%=saveId%>">
        </div>

        <div class="input-box">
            <input type="password" name="member_pw" placeholder="비밀번호" required>
        </div>

        <div class="login-option">
            <label>
                <input type="checkbox" name="save" value="yes" <%= isSave ? "checked" : "" %>>
                아이디 저장
            </label>
        </div>

        <button type="submit" class="login-btn">로그인</button>

        <button type="button" class="signup-btn"
                onclick="location.href='<%=request.getContextPath()%>/member/member_form.jsp'">
            회원가입
        </button>
    </form>
</div>

<jsp:include page="/footer/footer.jsp" />
</body>
</html>