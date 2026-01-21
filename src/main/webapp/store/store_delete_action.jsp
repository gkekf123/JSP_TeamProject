<%@page import="com.team.project.dao.StoreDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String role = (String) session.getAttribute("member_role");
    if (role == null || !"admin".equals(role)) {
%>
    <script>alert("권한이 없습니다."); history.back();</script>
<%
        return;
    }

    String idx = request.getParameter("idx");
    StoreDAO dao = new StoreDAO();
    int result = dao.deleteStore(idx);
    
    if(result > 0) {
%>
    <script>alert("삭제되었습니다."); location.href = "store_main.jsp";</script>
<%
    } else {
%>
    <script>alert("삭제 실패"); history.back();</script>
<%
    }
%>