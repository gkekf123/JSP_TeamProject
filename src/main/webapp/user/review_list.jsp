<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String loginOk = (String) session.getAttribute("loginok");
    String role = (String) session.getAttribute("member_role");

    // 로그인 안됨
    if (loginOk == null) {
        response.sendRedirect(request.getContextPath() + "/login/login_form.jsp");
        return;
    }

    // 관리자 접근 불가
    if (!"USER".equalsIgnoreCase(role)) {
        response.sendRedirect(request.getContextPath() + "/member/my_page.jsp");
        return;
    }
%>

<!-- 유저 리뷰 목록 -->
<h3>내 리뷰 목록</h3>
<hr>

<div class="review-list">
    <!-- 작성한 리뷰 리스트 출력 -->
</div>