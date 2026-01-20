<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.team.project.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String member_id=request.getParameter("member_id");
  MemberDAO dao=new MemberDAO();
  
  int check=dao.getIdCheck(member_id);
  
  JSONObject ob=new JSONObject();
  ob.put("count", check);
%>

<%=ob.toString()%>
