<%@page import="com.team.project.dto.MemberDTO"%>
<%@page import="com.team.project.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String member_role = (String) session.getAttribute("member_role");
	String member_id = (String)session.getAttribute("member_id");
	if(member_id == null){
    	response.sendRedirect(request.getContextPath() + "/login/login_form.jsp");
    	return;
      
}
	
	String ctxPath = request.getContextPath();

	MemberDAO dao = new MemberDAO();
	MemberDTO dto = dao.getMyInfo(member_id);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

<style>
body {
    font-family: 'Noto Sans KR', sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding-top: 80px;
}

.container {
    display: flex;
    max-width: 1000px;
    margin: 30px auto;
    gap: 20px;
}

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

.sidebar li {
    margin-bottom: 15px;
    padding: 10px;
    border-radius: 8px;
    cursor: pointer;
    font-weight: 500;
    transition: background 0.2s, color 0.2s;
    color: #333;
}

.sidebar li:hover {
    background-color: #f39c12;
    color: #fff;
}

/* 현재 페이지 */
.sidebar li.active {
    background-color: #fdf2e9;
    color: #f39c12;
    font-weight: 700;
}

/* 현재 페이지 + hover */
.sidebar li.active:hover {
    background-color: #f39c12;
    color: #fff;
}


.content {
    flex: 1;
    background-color: #fff;
    padding: 30px 40px;
    border-radius: 15px;
    box-shadow: 0 5px 20px rgba(0,0,0,0.1);
}

h2 {
    text-align: center;
    font-size: 24px;
    font-weight: bold;
    margin-bottom: 40px;
}

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

.btn-area {
    text-align: center;
    margin-top: 40px;
}

.btn-save, .btn-cancel {
    padding: 12px 30px;
    border: none;
    border-radius: 10px;
    font-size: 16px;
    cursor: pointer;
    margin: 0 10px;
}

.btn-save {
    background-color: #f39c12;
    color: #fff;
}

.btn-save:hover {
    background-color: #e67e22;
}

.btn-cancel {
    background-color: #999;
    color: #fff;
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

</style>

<script>
// 폼 초기화 함수
function resetForm() {
    const form = document.getElementById("updateForm");
    // 각 input에 기본값을 세팅
    form.member_pw.value = "";
    form.member_name.value = "<%=dto.getMember_name()%>";
    form.member_email.value = "<%=dto.getMember_email()%>";
    form.member_hp.value = "<%=dto.getMember_hp()%>";
    form.member_addr.value = "<%=dto.getMember_addr()%>";
    // 비밀번호 확인도 초기화
    form.member_pw_confirm.value = "";
    
}

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
    <div class="sidebar">
        <ul>
            <li onclick="location.href='<%=request.getContextPath()%>/index.jsp'">메인</li>
            <li onclick="location.href='<%=request.getContextPath()%>/member/my_page.jsp'">마이페이지</li>
            
            <% if("admin".equalsIgnoreCase(member_role)) { %>
		    <!-- 관리자 메뉴만 보여줌 -->
		    <li onclick="location.href='<%=ctxPath%>/admin/admin_list.jsp'">관리자 글 작성 목록</li>
			<% } else if("user".equalsIgnoreCase(member_role)) { %>
		
		    <!-- 일반유저 메뉴만 보여줌 -->
		    <li onclick="location.href='<%=ctxPath%>/user/wish_list.jsp'">찜 목록</li>
		    <li onclick="location.href='<%=ctxPath%>/user/review_list.jsp'">리뷰 작성 목록</li>
			<% } %>
			
            <li class="active">회원 정보 수정</li>
            <li onclick="location.href='<%=request.getContextPath()%>/member/member_delete_form.jsp'">회원 탈퇴</li>
            

        <!-- 로그아웃 -->
        	<li id="sidebarLogout" 
        	style="color:#e74c3c; font-weight:600;">
            로그아웃
         </li>  
        </ul>
    </div>

    <div class="content">
    	<div class="role-badge">
    		<%= "admin".equalsIgnoreCase(member_role) ? "-관리자-" : "-유저-" %>
		</div>
        <h2>회원 정보 수정</h2>

        <form id="updateForm" action="<%=request.getContextPath()%>/member/my_info_update_action.jsp" method="post">
            <div class="form-row">
                <div class="form-group">
                    <label>아이디</label>
                    <input type="text" value="<%=dto.getMember_id()%>" readonly>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>비밀번호</label>
                    <input type="password" name="member_pw">
                </div>
                <div class="form-group">
                    <label>비밀번호 확인</label>
                    <input type="password" name="member_pw_confirm">
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>사용자명</label>
                    <input type="text" name="member_name" value="<%=dto.getMember_name()%>">
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>전화번호</label>
                    <input type="text" name="member_hp" value="<%=dto.getMember_hp()%>">
                </div>
                <div class="form-group">
                    <label>이메일</label>
                    <input type="text" name="member_email" value="<%=dto.getMember_email()%>">
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>주소</label>
                    <input type="text" name="member_addr" value="<%=dto.getMember_addr()%>">
                </div>
            </div>

            <div class="btn-area">
                <button type="submit" class="btn-save">수정하기</button>
                <button type="button" class="btn-cancel" onclick="resetForm()">취소</button>
            </div>
        </form>
    </div>
</div>
<jsp:include page="/footer/footer.jsp" />
</body>
</html>
