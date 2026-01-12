<%@page import="com.team.project.dto.MemberDto"%>
<%@page import="com.team.project.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

String member_id=request.getParameter("member_id");
String member_pw=request.getParameter("member_pw");
String adminCheck=request.getParameter("admin_login");

MemberDao dao=new MemberDao();
MemberDto dto=dao.selectMember(member_id, member_pw);

if(dto==null){%>
	<script type="text/javascript">
	alert("아이디 혹은 비밀번호가 틀렸습니다.")
	history.back();
	</script>
<% return;}

session.setAttribute("login_id", dto.getMember_id());
session.setAttribute("login_name", dto.getMember_name());
session.setAttribute("login_role", dto.getMember_role());

response.sendRedirect(request.getContextPath()+"/mainpage/main_page.jsp");
%>

