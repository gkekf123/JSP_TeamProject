<%@page import="com.team.project.dao.StoreDAO"%>
<%@page import="com.team.project.dto.StoreDTO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");

    // 1. 파일 업로드 설정
    // 실제 서버 경로 찾기 (images 폴더가 webapp/images 에 있어야 함)
    String savePath = application.getRealPath("/images"); 
    int maxSize = 10 * 1024 * 1024; // 10MB 제한
    String encoding = "UTF-8";

    try {
        // MultipartRequest 생성 (자동으로 파일 업로드 됨)
        MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, encoding, new DefaultFileRenamePolicy());

        // 2. 폼 데이터 받기
        String name = multi.getParameter("store_name");
        String category = multi.getParameter("store_category");
        String tel = multi.getParameter("store_tel");
        String addr = multi.getParameter("store_addr");
        String intro = multi.getParameter("store_intro");
        
        // 업로드된 파일명 가져오기
        String fileName = multi.getFilesystemName("store_img");
        
        // 파일 업로드를 안했을 경우 기본 이미지 설정
        if (fileName == null) {
            fileName = "no_image.png"; 
        }

        // 3. DTO 객체 생성 및 값 세팅
        StoreDTO dto = new StoreDTO();
        dto.setStoreName(name);
        dto.setStoreCategory(category);
        dto.setStoreTel(tel);
        dto.setStoreAddr(addr);
        dto.setStoreIntro(intro);
        dto.setStoreImg(fileName);

        // 4. DAO를 통해 DB 저장
        StoreDAO dao = new StoreDAO();
        int result = dao.insertStore(dto);

        if (result > 0) {
%>
            <script>
                alert("맛집이 성공적으로 등록되었습니다!");
                location.href = "store_main.jsp";
            </script>
<%
        } else {
%>
            <script>
                alert("등록에 실패했습니다.");
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