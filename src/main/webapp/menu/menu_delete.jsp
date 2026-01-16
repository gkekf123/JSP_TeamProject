<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.team.project.dao.MenuDAO" %>
<%@ page import="com.team.project.dto.MemberDTO" %>

<%
request.setCharacterEncoding("UTF-8");
String ctxPath = request.getContextPath();

// 1. 로그인 & 관리자 체크 (보안 필수)
Object loginObj = session.getAttribute("loginMember");
if (loginObj == null || !(loginObj instanceof MemberDTO)) {
    out.println("<script>alert('권한이 없습니다.'); history.back();</script>");
    return;
}

MemberDTO m = (MemberDTO) loginObj;
if (!"admin".equals(m.getMemberRole())) {
    out.println("<script>alert('관리자만 삭제할 수 있습니다.'); history.back();</script>");
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