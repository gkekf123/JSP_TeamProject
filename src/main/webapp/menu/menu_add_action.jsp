<%@page import="com.team.project.dao.MenuDAO"%>
<%@page import="com.team.project.dto.MenuDTO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

boolean isSuccess = false;
long storeIdx = 0;

try {
    String realPath = application.getRealPath("/images/menu");
    int maxSize = 1024 * 1024 * 10;

    MultipartRequest mr = new MultipartRequest(
        request,
        realPath,
        maxSize,
        "UTF-8",
        new DefaultFileRenamePolicy()
    );

    storeIdx = Long.parseLong(mr.getParameter("storeIdx"));
    String menuName = mr.getParameter("menuName");
    int menuPrice = Integer.parseInt(mr.getParameter("menuPrice"));
    String menuImg = mr.getFilesystemName("menuImg");

    MenuDTO dto = new MenuDTO();
    dto.setStoreIdx(storeIdx);
    dto.setMenuName(menuName);
    dto.setMenuPrice(menuPrice);
    dto.setMenuImg(menuImg);

    MenuDAO dao = new MenuDAO();
    dao.insertMenu(dto);

    isSuccess = true; // 여기까지 오면 성공

} catch (Exception e) {
    e.printStackTrace(); // 콘솔에 원인 출력
}
%>


%>
<!--다시 상세페이지로  --> 
<script>
<% if (isSuccess) { %>
    alert("메뉴 등록이 완료되었니다.");
    location.href = "../store/store_detail.jsp?idx=<%= storeIdx %>";
<% } else { %>
    alert("메뉴 등록에 실패했습니다.");
    history.back();
<% } %>
</script>