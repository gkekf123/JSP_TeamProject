<%@page import="java.io.File"%>
<%@page import="com.team.project.dto.ReviewDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.team.project.dao.ReviewDAO" %>

<%
    request.setCharacterEncoding("UTF-8");
    String ctxPath = request.getContextPath();

    // 1. 로그인 체크
    String memberId = (String) session.getAttribute("member_id");
    if (memberId == null) {
        out.println("<script>alert('로그인이 필요합니다.'); location.href='" + ctxPath + "/login/login_form.jsp';</script>");
        return;
    }

    // 2. 파라미터 받기
    String reviewIdxParam = request.getParameter("reviewIdx");
    String storeIdxParam = request.getParameter("storeIdx");
    String from = request.getParameter("from");

    if (reviewIdxParam == null) {
        out.println("<script>alert('잘못된 접근입니다.'); history.back();</script>");
        return;
    }

    long reviewIdx = Long.parseLong(reviewIdxParam);
    
    // 3. DAO 호출 (삭제 실행)
    ReviewDAO dao = new ReviewDAO();
    ReviewDTO dto=dao.oneSelectReview(reviewIdx);
    
    // 실제 파일 삭제 (서버 하드디스크)
    String savePath = application.getRealPath("/images/review_upload/");
    String[] images = {dto.getReviewImg1(), dto.getReviewImg2(), dto.getReviewImg3(), dto.getReviewImg4(), dto.getReviewImg5()};
    
    for(String path : images) {
        if(path != null && !path.isEmpty()) {
            File file = new File(savePath + path);
            if(file.exists()) file.delete(); 
        }
    }
    // DAO 내부에서 member_id를 체크하므로 안전합니다.
    int result = dao.deleteReview(reviewIdx, memberId);

    // 4. 결과 처리
    if (result > 0) {
        out.println("<script>alert('리뷰가 삭제되었습니다.');");
        if ("myreview".equals(from)) {
            out.println("location.href='" + ctxPath + "/review/my_review.jsp';");
        } else {
            out.println("location.href='" + ctxPath + "/store/store_detail.jsp?idx=" + storeIdxParam + "';");
        }
        out.println("</script>");
    } else {
        out.println("<script>alert('삭제 권한이 없거나 실패했습니다.'); history.back();</script>");
    }
%>