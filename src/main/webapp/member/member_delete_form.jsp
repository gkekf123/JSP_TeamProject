<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

	String member_role = (String) session.getAttribute("member_role");
	String member_id = (String)session.getAttribute("member_id");
	if(member_id == null){
	    response.sendRedirect(request.getContextPath()+"/login/login_form.jsp");
	    return;
	}
	
	String ctxPath = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>

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

.container {
    display: flex;
    max-width: 1000px;
    margin: 100px auto;
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
    margin-bottom: 20px;
}

.terms-box {
    height: 180px;
    border: 1px solid #ccc;
    padding: 10px;
    overflow-y: scroll;
    margin-bottom: 15px;
    background-color: #f9f9f9;
    border-radius: 8px;
}

input[type=password] {
    width: 60%;
    padding: 10px;
    border-radius: 8px;
    border: 1px solid #ccc;
    margin-bottom: 15px;
}

#agree {
    margin-right: 5px;
    cursor: pointer;
}

.btn-delete {
    width: 100%;
    padding: 12px;
    background-color: #f39c12;
    color: white;
    border: none;
    border-radius: 10px;
    font-size: 16px;
    cursor: not-allowed;
}

.btn-delete.active {
    cursor: pointer;
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
function checkScroll(el){
    if(el.scrollTop + el.clientHeight >= el.scrollHeight){
        document.getElementById("agree").disabled = false;
    }
}
function checkAgree(){
    const btn = document.getElementById("deleteBtn");
    btn.disabled = !document.getElementById("agree").checked;
    btn.classList.toggle("active");
}
function confirmDelete(){
    const agree = document.getElementById("agree");
    if(!agree.checked){
        alert("약관에 동의해야 탈퇴할 수 있습니다.");
        return;
    }
    if(confirm("정말로 탈퇴하시겠습니까?\n\n탈퇴 후에는 복구할 수 없습니다.")){
        document.getElementById("deleteForm").submit();
    }
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
            
            <li onclick="location.href='<%=ctxPath%>/user/wish_list.jsp'">나의 활동</li>
			
            <li onclick="location.href='<%=request.getContextPath()%>/member/my_info_update_form.jsp'">회원 정보 수정</li>
            <li class="active">회원 탈퇴</li>

            <!-- 로그아웃 -->
        	<li id="sidebarLogout" 
        	style= "color: #e74c3c; font-weight:600;">
            로그아웃
         </li> 
        </ul>
    </div>

    <div class="content">
	    <div class="role-badge">
	    	<%= "admin".equalsIgnoreCase(member_role) ? "-관리자-" : "-유저-" %>
		</div>
        <h2>회원 탈퇴</h2>
        <p style="color:red;">※ 탈퇴 시 모든 정보는 복구할 수 없습니다.</p>

        <form id="deleteForm" action="<%=request.getContextPath()%>/member/member_delete_action.jsp" method="post">
            <input type="hidden" name="member_id" value="<%=member_id%>">

            <label>비밀번호 확인</label><br>
            <input type="password" name="member_pw" required><br>

            <label>회원 탈퇴 약관</label>
            <div class="terms-box" onscroll="checkScroll(this)">
                <b>제 1조</b><br>
                이 약관은 샘플 약관입니다.<br><br>
                1. 약관 내용 1<br>
                2. 약관 내용 2<br>
                3. 약관 내용 3<br><br>
                <b>제 2조</b><br>
                회원 탈퇴 시 모든 정보는 즉시 삭제됩니다.<br><br>
                <b>제 3조</b><br>
                탈퇴 후 책임은 본인에게 있습니다.
            </div>

            <input type="checkbox" id="agree" disabled onclick="checkAgree()"> 위 약관에 동의합니다<br><br>

            <button type="button" id="deleteBtn" class="btn-delete" disabled onclick="confirmDelete()">회원 탈퇴</button>
        </form>
    </div>
</div>
<jsp:include page="/footer/footer.jsp" />
</body>
</html>
