<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    session.removeAttribute("loginok");
    session.removeAttribute("member_id");
    session.removeAttribute("member_role");
%>
<script>
    alert("로그아웃 되었습니다.");
    location.href = "<%= request.getContextPath() %>/login/login_form.jsp";
</script>