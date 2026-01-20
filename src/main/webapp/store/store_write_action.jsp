<%@page import="java.io.File"%>
<%@page import="com.team.project.dao.StoreDAO"%>
<%@page import="com.team.project.dto.StoreDTO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");

    // 1. 파일 업로드 설정
    String savePath = application.getRealPath("/images/store_image"); 
    int maxSize = 10 * 1024 * 1024; // 10MB 제한
    String encoding = "UTF-8";

    // 폴더 생성 로직 (안전장치)
    File dir = new File(savePath);
    if (!dir.exists()) {
        dir.mkdirs();
        System.out.println("폴더가 없어서 생성했습니다: " + savePath);
    }

    try {
        // MultipartRequest 생성 (파일 업로드는 이 시점에 이루어짐)
        MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, encoding, new DefaultFileRenamePolicy());

        // 2. 폼 데이터 받기 (입력값)
        String name = multi.getParameter("store_name");
        String category = multi.getParameter("store_category");
        String tel = multi.getParameter("store_tel");
        String addr = multi.getParameter("store_addr");
        String intro = multi.getParameter("store_intro");
        
        // 3. 히든 필드 데이터 받기 (카카오맵 연동 데이터)
        String latStr = multi.getParameter("latitude");
        String lngStr = multi.getParameter("longitude");
        String kakaoId = multi.getParameter("kakaoId");
        String placeUrl = multi.getParameter("placeUrl");
        
        // 위도, 경도 실수형 변환 (값이 없을 경우 0.0 처리)
        double lat = (latStr != null && !latStr.isEmpty()) ? Double.parseDouble(latStr) : 0.0;
        double lng = (lngStr != null && !lngStr.isEmpty()) ? Double.parseDouble(lngStr) : 0.0;
        
        // 4. 이미지 파일명 가져오기
        String img1 = multi.getFilesystemName("store_img1");
        String img2 = multi.getFilesystemName("store_img2");
        String img3 = multi.getFilesystemName("store_img3");
        
        // 5. DTO 객체 생성 및 값 세팅
        StoreDTO dto = new StoreDTO();
        dto.setStoreName(name);
        dto.setStoreCategory(category);
        dto.setStoreTel(tel);
        dto.setStoreAddr(addr);
        dto.setStoreIntro(intro);
        
        // 카카오 데이터 세팅
        dto.setLatitude(lat);
        dto.setLongitude(lng);
        dto.setKakaoId(kakaoId);
        dto.setPlaceUrl(placeUrl);
        
        if(img1 != null) dto.setStoreImg(img1);
        if(img2 != null) dto.setStoreImg2(img2);
        if(img3 != null) dto.setStoreImg3(img3);

        // 6. DAO 호출
        StoreDAO dao = new StoreDAO();
        int result = dao.insertStore(dto);

        // 7. 결과 처리
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