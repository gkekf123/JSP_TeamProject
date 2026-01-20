<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String loginOk = (String) session.getAttribute("loginok");
    String role = (String) session.getAttribute("member_role");

    // 로그인 안됨
    if (loginOk == null) {
        response.sendRedirect(request.getContextPath() + "/login/login_main.jsp");
        return;
    }

    // 관리자 아님
    if (!"admin".equalsIgnoreCase(role)) {
        response.sendRedirect(request.getContextPath() + "/member/my_page.jsp");
        return;
    }
%>

<!-- 관리자 글 목록 영역 -->
<h3>관리자 전용 글 목록</h3>
<hr>

<!-- 여기부터 기존 디자인 그대로 -->
<div class="admin-list">
    <!-- 관리자만 작성 가능한 가게 정보 / 공지 등 -->
</div>
