<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.team.project.dao.MenuDAO" %>
<%@ page import="com.team.project.dto.MemberDTO" %>

<%
request.setCharacterEncoding("UTF-8");
String ctxPath = request.getContextPath();

//1. 로그인 & 관리자 체크 (store_detail.jsp와 동일한 방식)
String memberId = (String) session.getAttribute("member_id");
String memberRole = (String) session.getAttribute("member_role");

// 세션에 아이디가 없거나, 역할이 'admin'이 아니면 차단
if (memberId == null || !"admin".equals(memberRole)) {
    out.println("<script>alert('관리자 권한이 없습니다.'); history.back();</script>");
    return;
}

// 2. 파라미터 받기
String menuIdxParam = request.getParameter("menuIdx");
String storeIdxParam = request.getParameter("storeIdx");

if (menuIdxParam == null || storeIdxParam == null) {
    out.println("<script>alert('잘못된 접근입니다.'); history.back();</script>");
    return;
}

int menuIdx = Integer.parseInt(menuIdxParam);
long storeIdx = Long.parseLong(storeIdxParam);

// 3. 삭제 처리
MenuDAO dao = new MenuDAO();
boolean result = dao.deleteMenu(menuIdx);

// 4. 결과 처리
if (result) {
%>
<script>
    alert("메뉴가 삭제되었습니다.");
    location.href = "<%= ctxPath %>/store/store_detail.jsp?idx=<%= storeIdx %>";
</script>
<%
} else {
%>
<script>
    alert("메뉴 삭제에 실패했습니다.");
    history.back();
</script>
<%
}
%>