<%@page import="com.team.project.dto.MemberDTO"%>
<%@page import="com.team.project.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String loginOk = (String) session.getAttribute("loginok");
    if (loginOk == null) {
        response.sendRedirect(request.getContextPath() + "/login/login_form.jsp");
        return;
    }

 	// "admin" 또는 "user"
    String member_role = (String) session.getAttribute("member_role");
    String member_id = (String) session.getAttribute("member_id");
    MemberDAO dao = new MemberDAO();
    MemberDTO dto = dao.getMyInfo(member_id);

    if (dto == null) {
        out.println("회원 정보가 존재하지 않습니다.");
        return;
    } 

    String ctxPath = request.getContextPath();

    // 비밀번호 길이에 맞춰 별표 생성
    String memberPw = dto.getMemberPw(); 
    String maskedPw = "*".repeat(memberPw.length());
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

<style>
body {
    margin: 0;
    padding-top: 80px; /* 헤더 높이 */
    font-family: 'Noto Sans KR', sans-serif;
    background-color: #f4f4f4;
}

/* 컨테이너 */
.container {
    display: flex;
    max-width: 1000px;
    margin: 100px auto;
    gap: 20px;
}

/* 사이드바 */
.sidebar {
    width: 220px;
    background-color: #fff;
    padding: 20px;
    border-radius: 12px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.1);
}

.sidebar ul {
    list-style: none;
    padding: 0;
}

/* 기본 메뉴 */
.sidebar li {
    margin-bottom: 15px;
    padding: 10px;
    border-radius: 8px;
    cursor: pointer;
    font-weight: 500;
    transition: background 0.2s, color 0.2s;
    color: #333;
}

/* hover */
.sidebar li:hover {
    background-color: #f39c12;
    color: #fff;
}

/* 현재 페이지(active) */
.sidebar li.active {
    background-color: #fdf2e9;   /* 연한 오렌지 */
    color: #f39c12;
    font-weight: 700;
}

/* active 상태에서 hover */
.sidebar li.active:hover {
    background-color: #f39c12;
    color: #fff;
}

/* 메인 컨텐츠 */
.content {
    flex: 1;
    background-color: #fff;
    padding: 30px 40px;
    border-radius: 15px;
    box-shadow: 0 5px 20px rgba(0,0,0,0.1);
}

/* 제목 */
h2 {
    text-align: center;
    font-size: 24px;
    font-weight: bold;
    margin-bottom: 40px;
}

/* 폼 스타일 */
.form-row {
    display: flex;
    gap: 20px;
    margin-bottom: 25px;
}

.form-group {
    flex: 1;
    display: flex;
    flex-direction: column;
}

.form-group label {
    margin-bottom: 8px;
    font-weight: 600;
}

.form-group input {
    padding: 12px;
    border-radius: 10px;
    border: 1px solid #ccc;
    background-color: #f0f0f0;
    font-size: 14px;
    outline: none;
    transition: 0.2s;
}

.form-group input:focus {
    border-color: #f39c12;
    background-color: #fff;
}

/* 모바일 대응 */
@media (max-width: 768px) {
    .container {
        flex-direction: column;
        margin: 20px;
    }
    .form-row {
        flex-direction: column;
    }
}

/* 마이페이지 역할 표시 */
.content {
    position: relative; /* 기준점 */
}

.role-badge {
    position: absolute;
    top: 25px;
    right: 40px;
    font-size: 18px;
    font-weight: 700; 
    pointer-events: none; /* 클릭 방해 안 하게 */
}

.profile-area {
    text-align: center;
    margin-bottom: 30px;
}

.profile-img {
    width: 100px;
    height: 100px;
    border-radius: 50%;
    object-fit: cover;
    border: 3px solid #f39c12;
    cursor: pointer;
}

.profile-name {
    margin-top: 10px;
    font-size: 17px;
    font-weight: 700;
}

</style>
<script>
document.addEventListener("DOMContentLoaded", () => {
    const logoutBtn = document.getElementById("sidebarLogout");

    if (logoutBtn) {
        logoutBtn.addEventListener("click", () => {
            if (confirm("로그아웃 하시겠습니까?")) {
                location.href = "<%=ctxPath%>/login/logout_action.jsp";
            }
        });
    }
});
</script>
</head>
<body>

<jsp:include page="/header/header.jsp" />

<div class="container">
    <!-- 사이드바 -->
    <div class="sidebar">
        <ul>
            <li onclick="location.href='<%=ctxPath%>/index.jsp'">메인</li>
            <li class="active">마이페이지</li>
		    <li onclick="location.href='<%=ctxPath%>/user/wish_list.jsp'">나의 활동</li>
            <li onclick="location.href='<%=ctxPath%>/member/my_info_update_form.jsp'">회원 정보 수정</li>
            <li onclick="location.href='<%=ctxPath%>/member/member_delete_form.jsp'">회원 탈퇴</li>
        	<!-- 로그아웃 -->
        	<li id="sidebarLogout" 
        		style="color:#e74c3c; font-weight:600;">
            	로그아웃
         	</li>
        </ul>
    </div>

    <!-- 메인 컨텐츠 -->
    <div class="content">
    	<div class="role-badge">
    		<%= "admin".equalsIgnoreCase(member_role) ? "- 관리자 -" : "- 유저 -" %>
		</div>
        <h2>마이페이지</h2>
		<!-- 프로필 영역 -->
		<div class="profile-area">
		    <form action="<%=ctxPath%>/member/profile_img_update.jsp"
		          method="post"
		          enctype="multipart/form-data">
				<input type="hidden" name="member_id" value="<%=dto.getMemberId()%>">
				
		        <label for="profileInput">
		            <img src="<%=ctxPath%>/upload/<%=dto.getMemberImg()%>"
		                 class="profile-img"
		                 title="image">
		        </label>
		
		        <input type="file"
		               id="profileInput"
		               name="member_img"
		               accept="image/*"
		               onchange="this.form.submit();"
		               hidden>
		    </form>
		    <div class="profile-name">
		        <%=dto.getMemberName()%>
		    </div>
		</div>
        <div class="form-row">
            <div class="form-group">
                <label>아이디</label>
                <input type="text" value="<%=dto.getMemberId()%>" readonly>
            </div>
            
     </div>
        <div class="form-row">
            <div class="form-group">
                <label>비밀번호</label>
                <input type="password" value="<%=maskedPw%>" readonly>
            </div>
            <div class="form-group">
                <label>비밀번호 확인</label>
                <input type="password" value="<%=maskedPw%>" readonly>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label>사용자명</label>
                <input type="text" value="<%=dto.getMemberName()%>" readonly>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label>전화번호</label>
                <input type="text" value="<%=dto.getMemberHp()%>" readonly>
            </div>
            <div class="form-group">
                <label>이메일</label>
                <input type="text" value="<%=dto.getMemberEmail()%>" readonly>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label>주소</label>
                <input type="text" value="<%=dto.getMemberAddr()%>" readonly>
            </div>
            <div class="form-group">
                <label>가입일</label>
                <input type="text" value="<%=dto.getMemberJoinday()%>" readonly>
            </div>
        </div>
    </div>
</div>
<jsp:include page="/footer/footer.jsp" />
</body>
</html>