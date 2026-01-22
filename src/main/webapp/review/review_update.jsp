<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.team.project.dto.ReviewDTO"%>
<%@page import="com.team.project.dao.ReviewDAO"%>
<%@page import="com.team.project.dto.MemberDTO"%>
<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 로그인 체크
    MemberDTO loginMember = (MemberDTO)session.getAttribute("loginMember");
    JSONObject ob = new JSONObject();
    
    if (loginMember == null) {
        ob.put("reviewResult", "login_required");
        out.print(ob.toString());
        return;
    }

    try {
        // 파일 업로드 경로
        String uploadPath = application.getRealPath("/images/review_upload");
        int maxSize = 5 * 1024 * 1024; // 5MB
        String encoding = "UTF-8";
        
        MultipartRequest multi = new MultipartRequest(
            request, uploadPath, maxSize, encoding, new DefaultFileRenamePolicy()
        );
        
        // 파라미터 받기
        long reviewIdx = Long.parseLong(multi.getParameter("review_idx"));
        long storeIdx = Long.parseLong(multi.getParameter("store_idx"));
        int reviewRating = Integer.parseInt(multi.getParameter("review_rating"));
        String reviewContent = multi.getParameter("review_content");
        
        // DTO 생성
        ReviewDTO dto = new ReviewDTO();
        dto.setReviewIdx(reviewIdx);
        dto.setStoreIdx(storeIdx);
        dto.setMemberId(loginMember.getMemberId());
        dto.setReviewRating(reviewRating);
        dto.setReviewContent(reviewContent);
        
        // 새 이미지 처리
        for (int i = 1; i <= 5; i++) {
            String fileName = multi.getFilesystemName("review_img" + i);
            if (fileName != null) {
                switch(i) {
                    case 1: dto.setReviewImg1(fileName); break;
                    case 2: dto.setReviewImg2(fileName); break;
                    case 3: dto.setReviewImg3(fileName); break;
                    case 4: dto.setReviewImg4(fileName); break;
                    case 5: dto.setReviewImg5(fileName); break;
                }
            }
        }
        
        // 기존 이미지 처리 (삭제 표시된 것들)
        for (int i = 1; i <= 5; i++) {
            String existingImg = multi.getParameter("existing_img" + i);
            if (existingImg != null && !existingImg.equals("DELETE")) {
                // 기존 이미지 유지
                switch(i) {
                    case 1: if (dto.getReviewImg1() == null) dto.setReviewImg1(existingImg); break;
                    case 2: if (dto.getReviewImg2() == null) dto.setReviewImg2(existingImg); break;
                    case 3: if (dto.getReviewImg3() == null) dto.setReviewImg3(existingImg); break;
                    case 4: if (dto.getReviewImg4() == null) dto.setReviewImg4(existingImg); break;
                    case 5: if (dto.getReviewImg5() == null) dto.setReviewImg5(existingImg); break;
                }
            }
        }
        
        // DB 업데이트
        ReviewDAO dao = new ReviewDAO();
        int result = dao.updateReview(dto);
        
        if (result > 0) {
            ob.put("reviewResult", "success");
        } else {
            ob.put("reviewResult", "fail");
        }
        
    } catch (Exception e) {
        e.printStackTrace();
        ob.put("reviewResult", "error");
        ob.put("message", e.getMessage());
    }
    
    out.print(ob.toString());
%>