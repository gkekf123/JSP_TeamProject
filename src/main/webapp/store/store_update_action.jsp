<%@page import="java.io.File"%>
<%@page import="com.team.project.dao.StoreDAO"%>
<%@page import="com.team.project.dto.StoreDTO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");

    // 1. 파일 저장 경로 설정
    String savePath = application.getRealPath("/images/store_image"); 
    int maxSize = 10 * 1024 * 1024; // 10MB
    String encoding = "UTF-8";

    File dir = new File(savePath);
    if (!dir.exists()) {
        dir.mkdirs(); // 폴더 생성
        System.out.println("업로드 폴더 생성 완료: " + savePath);
    }

    try {
        // 폴더가 확실히 존재하는 상태에서 MultipartRequest 생성
        MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, encoding, new DefaultFileRenamePolicy());

        String idxStr = multi.getParameter("store_idx");
        long idx = Long.parseLong(idxStr);
        
        String name = multi.getParameter("store_name");
        String category = multi.getParameter("store_category");
        String tel = multi.getParameter("store_tel");
        String addr = multi.getParameter("store_addr");
        String intro = multi.getParameter("store_intro");
        
        // 위치 정보
        String latStr = multi.getParameter("latitude");
        String lngStr = multi.getParameter("longitude");
        String kakaoId = multi.getParameter("kakaoId");
        String placeUrl = multi.getParameter("placeUrl");
        
        double lat = (latStr != null && !latStr.isEmpty()) ? Double.parseDouble(latStr) : 0.0;
        double lng = (lngStr != null && !lngStr.isEmpty()) ? Double.parseDouble(lngStr) : 0.0;
        
        // 이미지 처리 (새로 올린 파일이 없으면 기존 hidden 값 사용)
        String img1 = multi.getFilesystemName("store_img1");
        if (img1 == null) img1 = multi.getParameter("old_img1"); 
        
        String img2 = multi.getFilesystemName("store_img2");
        if (img2 == null) img2 = multi.getParameter("old_img2");
        
        String img3 = multi.getFilesystemName("store_img3");
        if (img3 == null) img3 = multi.getParameter("old_img3");

        // DTO 세팅
        StoreDTO dto = new StoreDTO();
        dto.setStoreIdx(idx);
        dto.setStoreName(name);
        dto.setStoreCategory(category);
        dto.setStoreTel(tel);
        dto.setStoreAddr(addr);
        dto.setStoreIntro(intro);
        
        // 위치 정보
        dto.setLatitude(lat);
        dto.setLongitude(lng);
        dto.setKakaoId(kakaoId);
        dto.setPlaceUrl(placeUrl);
        
        // 이미지
        dto.setStoreImg(img1);
        dto.setStoreImg2(img2);
        dto.setStoreImg3(img3);

        // 수정 실행
        StoreDAO dao = new StoreDAO();
        int result = dao.updateStore(dto);

        if (result > 0) {
%>
            <script>
                alert("수정되었습니다.");
                location.href = "store_main.jsp";
            </script>
<%
        } else {
%>
            <script>
                alert("수정 실패.");
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