<%@page import="com.team.project.dao.MenuDAO"%>
<%@page import="com.team.project.dto.MenuDTO"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");

    // 1. 이미지 저장 경로 설정
    String savePath = application.getRealPath("/images/menu");
    int maxSize = 10 * 1024 * 1024; // 10MB
    String encoding = "UTF-8";

    // 폴더가 없으면 생성
    File dir = new File(savePath);
    if (!dir.exists()) dir.mkdirs();

    try {
        // 2. MultipartRequest 생성 (파일 업로드 수행)
        MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, encoding, new DefaultFileRenamePolicy());

        // 3. 파라미터 수신
        String storeIdxStr = multi.getParameter("storeIdx");
        String menuIdxStr = multi.getParameter("menuIdx");
        String menuName = multi.getParameter("menuName");
        String menuPriceStr = multi.getParameter("menuPrice");
        
        // 4. 이미지 처리 로직 (핵심)
        // 새로 업로드된 파일명
        String newImg = multi.getFilesystemName("menuImg");
        // 기존 파일명 (hidden input으로 넘어옴)
        String oldImg = multi.getParameter("oldMenuImg");
        
        // 새 이미지가 있으면 그걸 쓰고, 없으면(null이면) 기존 이미지를 유지
        String finalImg = (newImg != null) ? newImg : oldImg;

        // 5. DTO 담기
        MenuDTO dto = new MenuDTO();
        dto.setMenuIdx(Integer.parseInt(menuIdxStr));
        dto.setMenuName(menuName);
        dto.setMenuPrice(Integer.parseInt(menuPriceStr));
        dto.setMenuImg(finalImg);

        // 6. DB 업데이트 실행
        MenuDAO dao = new MenuDAO();
        int result = dao.updateMenu(dto);

        if(result > 0) {
%>
            <script>
                alert("메뉴가 수정되었습니다.");
                // 상세 페이지로 복귀
                location.href = "<%= request.getContextPath() %>/store/store_detail.jsp?idx=<%= storeIdxStr %>";
            </script>
<%
        } else {
%>
            <script>
                alert("메뉴 수정에 실패했습니다.");
                history.back();
            </script>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
%>
        <script>
            alert("오류 발생: <%= e.getMessage() %>");
            history.back();
        </script>
<%
    }
%>