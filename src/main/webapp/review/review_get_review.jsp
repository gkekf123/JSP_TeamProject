<%@page import="com.team.project.dto.MemberDTO"%>
<%@page import="java.util.List"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.team.project.dto.ReviewDTO"%>
<%@page import="com.team.project.dao.ReviewDAO"%>
<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String sessionMemberId = (String)session.getAttribute("member_id");

	if(sessionMemberId == null){
	    JSONObject error = new JSONObject();
	    error.put("error", "login_required");
	    out.print(error.toString());
	    return;
	}

	String reviewIdxParam = request.getParameter("reviewIdx");

	// null 체크
	if (reviewIdxParam == null || reviewIdxParam.trim().isEmpty()) {
    	JSONObject error = new JSONObject();
    	error.put("error", "reviewIdx가 없습니다.");
    	out.print(error.toString());
    	return;
	
	}	
	
    long reviewIdx = Long.parseLong(request.getParameter("reviewIdx"));

    ReviewDAO dao = new ReviewDAO();
    ReviewDTO dto = dao.oneSelectReview(reviewIdx);
    
    // dto null 체크
    if (dto == null) {
        JSONObject error = new JSONObject();
        error.put("error", "리뷰를 찾을 수 없습니다.");
        out.print(error.toString());
        return;
    }
    
 // 권한 체크
    if(!dto.getMemberId().equals(sessionMemberId)){
        JSONObject error = new JSONObject();
        error.put("error", "권한이 없습니다.");
        out.print(error.toString());
        return;
    }
  
    //리뷰 순서 가져오기
    List<ReviewDTO> reviews = dao.selectReview(dto.getStoreIdx());
    int reviewOrder = 0;
    for (int i = 0; i < reviews.size(); i++) {
        if (reviews.get(i).getReviewIdx() == dto.getReviewIdx()) {
        	reviewOrder = reviews.size() - i;
            break;
        }
    }

    JSONObject ob = new JSONObject();
    
    ob.put("reviewIdx", dto.getReviewIdx());
    ob.put("reviewRating", dto.getReviewRating());
    ob.put("reviewContent", dto.getReviewContent());
    ob.put("reviewImg1", dto.getReviewImg1());
    ob.put("reviewImg2", dto.getReviewImg2());
    ob.put("reviewImg3", dto.getReviewImg3());
    ob.put("reviewImg4", dto.getReviewImg4());
    ob.put("reviewImg5", dto.getReviewImg5());
    ob.put("reviewOrder", reviewOrder);
    
%>
<%=ob.toString()%>