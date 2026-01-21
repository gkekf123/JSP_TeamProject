<%@page import="java.io.File"%>
<%@page import="com.team.project.dto.ReviewDTO"%>
<%@page import="com.team.project.dao.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    long reviewIdx = Long.parseLong(request.getParameter("reviewIdx"));
    long storeIdx = Long.parseLong(request.getParameter("storeIdx"));
    String memberId = (String)session.getAttribute("member_id");

    ReviewDAO dao = new ReviewDAO();
    
    // 1. 삭제 전 이미지 경로 확보
    ReviewDTO dto = dao.oneSelectReview(reviewIdx);
    
    // 2. 실제 파일 삭제 (서버 하드디스크)
    String rootPath = application.getRealPath("/"); 
    String[] images = {dto.getReviewImg1(), dto.getReviewImg2(), dto.getReviewImg3(), dto.getReviewImg4(), dto.getReviewImg5()};
    
    for(String path : images) {
        if(path != null && !path.isEmpty()) {
            File file = new File(rootPath + path);
            if(file.exists()) file.delete(); 
        }
    }
    
    // 3. DB 삭제
    int res = dao.deleteReview(reviewIdx, memberId);
    
    if(res > 0) {
        response.sendRedirect(request.getContextPath() + "/store/store_detail.jsp?idx=" + storeIdx);
    } else {
        out.print("<script>alert('삭제 권한이 없거나 실패했습니다.'); history.back();</script>");
    }
%>