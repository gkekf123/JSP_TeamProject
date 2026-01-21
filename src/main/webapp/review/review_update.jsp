<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.team.project.dto.ReviewDTO"%>
<%@page import="com.team.project.dao.ReviewDAO"%>
<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    long reviewIdx = Long.parseLong(request.getParameter("reviewIdx"));
    ReviewDAO dao = new ReviewDAO();
    ReviewDTO dto = dao.oneSelectReview(reviewIdx);

    JSONObject ob = new JSONObject();
    ob.put("reviewIdx", dto.getReviewIdx());
    ob.put("reviewRating", dto.getReviewRating());
    ob.put("reviewContent", dto.getReviewContent());
    ob.put("reviewImg1", dto.getReviewImg1());
    ob.put("reviewImg2", dto.getReviewImg2());
    ob.put("reviewImg3", dto.getReviewImg3());
    ob.put("reviewImg4", dto.getReviewImg4());
    ob.put("reviewImg5", dto.getReviewImg5());
    
%>
<%=ob.toString()%>