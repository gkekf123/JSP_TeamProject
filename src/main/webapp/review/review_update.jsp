<%@page import="com.team.project.dao.MemberDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.team.project.dto.ReviewDTO"%>
<%@page import="com.team.project.dao.ReviewDAO"%>
<%@page import="com.team.project.dto.MemberDTO"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
JSONObject ob = new JSONObject();

String memberId = (String) session.getAttribute("member_id");
String loginok = (String) session.getAttribute("loginok");
if (loginok == null) {
	ob.put("reviewResult", "login_required");
	out.print(ob.toString());
	return;
}

// 파일 업로드 경로
String savePath = application.getRealPath("/images/review_upload");
int maxSize = 5 * 1024 * 1024; // 5MB

try {
	
	MultipartRequest multi = new MultipartRequest(
			request, 
			savePath, 
			maxSize, 
			"UTF-8",
			new DefaultFileRenamePolicy()
	);

	// 파라미터 받기
	long storeIdx = Long.parseLong(multi.getParameter("store_idx"));
	long reviewIdx = Long.parseLong(multi.getParameter("review_idx"));
	int reviewRating = Integer.parseInt(multi.getParameter("review_rating"));
	String reviewContent = multi.getParameter("review_content");
	
	ReviewDAO dao = new ReviewDAO();
	ReviewDTO dto = new ReviewDTO();
	dto.setReviewIdx(reviewIdx);
	dto.setMemberId(memberId);
	dto.setReviewRating(reviewRating);
	dto.setReviewContent(reviewContent);

	// 이미지 처리: 기존 + 새 이미지 순서대로
	List<String> imgList = new ArrayList<>();

	// 1. 기존 이미지 가져오기 (삭제되지 않은 것만)
	for (int i = 1; i <= 5; i++) {
		String existingImg = multi.getParameter("existing_img" + i);
		if (existingImg != null && !existingImg.equals("")) {
			imgList.add(existingImg);
		}
	}

	// 2️. 새로 업로드된 이미지 가져오기
	for (int i = 1; i <= 5; i++) {
		String fileName = multi.getFilesystemName("review_img" + i);
		if (fileName != null && !fileName.isEmpty()) {
			imgList.add(fileName);
		}
	}

	// 3️. DTO에 순서대로 세팅
	dto.setReviewImg1(imgList.size() > 0 ? imgList.get(0) : null);
	dto.setReviewImg2(imgList.size() > 1 ? imgList.get(1) : null);
	dto.setReviewImg3(imgList.size() > 2 ? imgList.get(2) : null);
	dto.setReviewImg4(imgList.size() > 3 ? imgList.get(3) : null);
	dto.setReviewImg5(imgList.size() > 4 ? imgList.get(4) : null);

	// DB 업데이트
	int updateResult = dao.updateReview(dto);

	if (updateResult > 0) {
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