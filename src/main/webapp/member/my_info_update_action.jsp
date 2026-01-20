<%@page import="com.team.project.dto.MemberDTO"%>
<%@page import="com.team.project.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("utf-8");

	// 로그인 세션 체크
	String member_id = (String)session.getAttribute("member_id");
	if(member_id == null){
	    response.sendRedirect(request.getContextPath() + "/login/login_form.jsp");
	    return;
	}
	
	String member_pw = request.getParameter("member_pw");
	String member_name = request.getParameter("member_name");
	String member_email = request.getParameter("member_email");
	String member_hp = request.getParameter("member_hp");
	String member_addr = request.getParameter("member_addr");
	
	MemberDTO dto = new MemberDTO();
	dto.setMemberId(member_id);
	dto.setMemberPw(member_pw);
	dto.setMemberName(member_name);
	dto.setMemberEmail(member_email);
	dto.setMemberHp(member_hp);
	dto.setMemberAddr(member_addr);
	
	MemberDAO dao = new MemberDAO();
	dao.updateMyInfo(dto);
	
	// 수정 후 마이페이지로 이동
	response.sendRedirect(request.getContextPath() + "/member/my_page.jsp");
%>
