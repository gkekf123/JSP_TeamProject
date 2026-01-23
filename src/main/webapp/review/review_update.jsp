<%@page import="java.text.SimpleDateFormat"%>
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

SimpleDateFormat sdf=new SimpleDateFormat("yyyy/MM/dd HH:mm");

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
	long reviewIdx = Long.parseLong(multi.getParameter("review_idx"));
	int reviewRating = Integer.parseInt(multi.getParameter("review_rating"));
	String reviewContent = multi.getParameter("review_content");
	
	ReviewDAO dao = new ReviewDAO();
	ReviewDTO existingDto = dao.oneSelectReview(reviewIdx);

	ReviewDTO dto = new ReviewDTO();
	dto.setReviewIdx(reviewIdx);

	dto.setStoreIdx(existingDto.getStoreIdx()); // storeIdx도 DB에서 가져옴
	dto.setMemberId(existingDto.getMemberId());
	dto.setMemberName(existingDto.getMemberName());
	dto.setMemberImg(existingDto.getMemberImg());
	
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
    	int reviewCount = dao.countReview(existingDto.getStoreIdx());
        double avgRating = dao.avgReview(existingDto.getStoreIdx());
        
        String profileHtml;

        if(dto.getMemberImg() != null && !dto.getMemberImg().isEmpty()) {
            profileHtml =
                "<img src='" + request.getContextPath() + "/images/profile/" + dto.getMemberImg() + "'>";
        } else {
            profileHtml =
                "<div class='profile-circle'><i class='bi bi-person-circle'></i></div>";
        }
               
     // 리뷰 이미지 HTML 생성 
        StringBuilder reviewImgHtml = new StringBuilder();
    
        if(dto.getReviewImg1() != null && !dto.getReviewImg1().isEmpty()) {
        	reviewImgHtml.append("<div class='review-img-thumb' style='cursor:pointer;' ")
        		.append("onclick=\"showReviewImages('")
        		.append(dto.getReviewImg1()).append("','")
        		.append(dto.getReviewImg2()).append("','")
        		.append(dto.getReviewImg3()).append("','")
        		.append(dto.getReviewImg4()).append("','")
        		.append(dto.getReviewImg5()).append("')\">")
        		
                .append("<img src='")
				.append(request.getContextPath())
      			.append("/images/review_upload/")
   				.append(dto.getReviewImg1()).append("'>");

            if(dto.getReviewImg2() != null && !dto.getReviewImg2().isEmpty()){
                reviewImgHtml.append("<div class='img-count-badge'><i class='bi bi-images'></i></div>");
            }
            
            reviewImgHtml.append("</div>");
        }
        
    	String reviewHtml =
    			"<div class='review-item' id='review-" + reviewIdx + "'>" +

		        "<div class='review-profile'>" +
		            profileHtml +
		            "<span class='review-writer'>" + dto.getMemberName() + "</span>" +
		            "<span class='review-rating'>평점 " + dto.getReviewRating() + "점</span>" +
		        "</div>" +
		
		        "<div class='review-content'>" +
		
		            "<div class='review-text-wrap'>" +
		                "<p class='review-text'>" + dto.getReviewContent().replace("\n", "<br>") + "</p>" +
		                "<span class='review-date'>"+sdf.format(existingDto.getReviewCreatedAt())+" (수정됨)</span>" +
		            "</div>" +
		
					reviewImgHtml.toString()  +
	
		        "</div>" +
		        
				"<div class='review-actions'>" +
				"<button class='review-edit-btn'>수정</button>" +
				"<button class='review-delete-btn'>삭제</button>" +
				"</div>" +
		
		    "</div>";

		ob.put("reviewResult", "success");
		ob.put("reviewHtml", reviewHtml);
		ob.put("avgRating", avgRating);
		ob.put("reviewCount", reviewCount);
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