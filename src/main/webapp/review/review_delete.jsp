<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.io.File"%>
<%@page import="com.team.project.dto.ReviewDTO"%>
<%@page import="com.team.project.dao.ReviewDAO"%>
<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	JSONObject ob=new JSONObject();

    long reviewIdx = Long.parseLong(request.getParameter("reviewIdx"));
    long storeIdx = Long.parseLong(request.getParameter("storeIdx"));
    String memberId = (String)session.getAttribute("member_id");
    
    if(memberId == null){
    	   ob.put("deleteResult","login_required");
    	   return;
    	}

    ReviewDAO dao = new ReviewDAO();
    
    // 1. 삭제 전 이미지 경로 확보
    ReviewDTO dto = dao.oneSelectReview(reviewIdx);
    
    // 2. 실제 파일 삭제 (서버 하드디스크)
    String savePath = application.getRealPath("/images/review_upload/");
    String[] images = {dto.getReviewImg1(), dto.getReviewImg2(), dto.getReviewImg3(), dto.getReviewImg4(), dto.getReviewImg5()};
    
    for(String path : images) {
        if(path != null && !path.isEmpty()) {
            File file = new File(savePath + path);
            if(file.exists()) file.delete(); 
        }
    }
    
    // 3. DB 삭제
    int deleteResult = dao.deleteReview(reviewIdx, memberId);
    
    if(deleteResult > 0) {     
    	ob.put("deleteResult", "success");

    } else {
        ob.put("deleteResult", "fail");
    }
    
    out.print(ob.toString());
%>