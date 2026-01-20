
<%@page import="com.team.project.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("utf-8");

String member_id = request.getParameter("member_id");
String member_pw = request.getParameter("member_pw");

MemberDAO dao = new MemberDAO();

/* 비밀번호 확인 */
if(dao.checkPassword(member_id, member_pw)){

    /* 1️. 회원 삭제 */
    dao.deleteMember(member_id);

    /* 2️. 세션 완전 삭제 → 자동 로그아웃 */
    session.invalidate();

    /* 3️. 로그인 폼으로 이동 */
    response.sendRedirect(
        request.getContextPath() + "/login/login_form.jsp"
    );
    return;

}else{
%>
<script>
    alert("비밀번호가 일치하지 않습니다.");
    history.back();
</script>
<%
}
%>