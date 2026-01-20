<%@ page import="com.team.project.dao.MemberDAO"%>
<%@ page import="com.team.project.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("UTF-8");

String member_id = request.getParameter("member_id");
String member_pw = request.getParameter("member_pw");

MemberDAO dao = new MemberDAO();
MemberDTO dto = dao.loginCheck(member_id, member_pw); // ⭐ DTO 리턴

if (dto != null) {
    // 로그인 성공
    session.setAttribute("loginok", "yes");
    session.setAttribute("member_id", dto.getMemberId());
    session.setAttribute("member_role", dto.getMemberRole()); 

    response.sendRedirect(request.getContextPath() + "/login/logout_form.jsp");
    return;
}
%>

<script>
    alert("아이디 또는 비밀번호가 틀렸습니다.");
    history.back();
</script>