<%@page import="java.io.File"%>
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
    
    File saveDir = new File(realPath);
    if (!saveDir.exists()) {
        saveDir.mkdirs(); // 폴더가 없으면 상위 폴더까지 모두 생성
    }
    
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
    String oldMenuImg = mr.getParameter("oldMenuImg");
    String menuIdxParam = mr.getParameter("menuIdx");

    MenuDTO dto = new MenuDTO();
    dto.setStoreIdx(storeIdx);
    dto.setMenuName(menuName);
    dto.setMenuPrice(menuPrice);
    dto.setMenuImg(menuImg);

    MenuDAO dao = new MenuDAO();

    if (menuIdxParam == null || menuIdxParam.equals("")) {
        // ✅ 메뉴 추가
        dao.insertMenu(dto);
    } else {
        // ✅ 메뉴 수정
        dto.setMenuIdx(Integer.parseInt(menuIdxParam));
        dao.updateMenu(dto);
    }
    
    if (menuImg == null || menuImg.isEmpty()) {
        // 새 파일을 안 올렸으면 기존 파일명을 유지
        dto.setMenuImg(oldMenuImg);
    } else {
        // 새 파일을 올렸으면 새 파일명 저장
        dto.setMenuImg(menuImg);
    }
    
    isSuccess = true; // 여기까지 문제없이 오면 성공

} catch (Exception e) {
    e.printStackTrace();
}
%>

<script>
<% if (isSuccess) { %>
    alert("메뉴가 정상적으로 저장되었습니다.");
    location.href = "../store/store_detail.jsp?idx=<%= storeIdx %>";
<% } else { %>
	
    alert("메뉴 저장에 실패했습니다.");
    history.back();
<% } %>
</script>
