<%@page import="java.io.IOException"%>
<%@page import="com.team.project.dto.MemberDTO"%>
<%@page import="com.team.project.dao.MemberDAO"%>
<%@page import="com.team.project.dao.ReviewDAO"%>
<%@page import="com.team.project.dto.ReviewDTO"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("UTF-8");

JSONObject ob = new JSONObject();

//로그인 확인 - 서버
String loginok = (String) session.getAttribute("loginok");
String memberId = (String) session.getAttribute("member_id");

if (loginok == null || memberId == null) {
    ob.put("reviewResult", "login_required");
    out.print(ob.toString());
    return;
}

// 업로드 설정
String savePath = application.getRealPath("/images/review_upload");
int maxSize = 25 * 1024 * 1024;

try{
	//업로드 폴더 없으면 생성
    File dir = new File(savePath);
    if (!dir.exists()) dir.mkdirs();
    
    MultipartRequest multi=new MultipartRequest(
    		request,
            savePath,
            maxSize,
            "UTF-8",
            new DefaultFileRenamePolicy()
    );
    
    long storeIdx = Long.parseLong(multi.getParameter("store_idx"));
    int reviewRating = Integer.parseInt(multi.getParameter("review_rating"));
    String reviewContent = multi.getParameter("review_content");

    // DTO
    ReviewDTO dto = new ReviewDTO();
    dto.setStoreIdx(storeIdx);

	MemberDAO mdao = new MemberDAO();
	MemberDTO mdto = mdao.getMyInfo(memberId);	
	dto.setMemberId(memberId);
	dto.setMemberName(mdto.getMemberName());
	dto.setMemberImg("logo.png"); //임의지정
	//dto.setMemberImg(mdto.getMemberImg());

    dto.setReviewRating(reviewRating);
    dto.setReviewContent(reviewContent);
    
    // 모든 이미지 null로 초기화
    dto.setReviewImg1(null);
    dto.setReviewImg2(null);
    dto.setReviewImg3(null);
    dto.setReviewImg4(null);
    dto.setReviewImg5(null);

    // 각 input에서 파일 가져오기
    String reviewImg1 = multi.getFilesystemName("review_img1");
    String reviewImg2 = multi.getFilesystemName("review_img2");
    String reviewImg3 = multi.getFilesystemName("review_img3");
    String reviewImg4 = multi.getFilesystemName("review_img4");
    String reviewImg5 = multi.getFilesystemName("review_img5");

    if (reviewImg1 != null && !reviewImg1.isEmpty()) 
    	dto.setReviewImg1(reviewImg1);
    if (reviewImg2 != null && !reviewImg2.isEmpty()) 
    	dto.setReviewImg2(reviewImg2);
    if (reviewImg3 != null && !reviewImg3.isEmpty()) 
    	dto.setReviewImg3(reviewImg3);
    if (reviewImg4 != null && !reviewImg4.isEmpty()) 
    	dto.setReviewImg4(reviewImg4);
    if (reviewImg5 != null && !reviewImg5.isEmpty()) 
    	dto.setReviewImg5(reviewImg5);

    ReviewDAO dao = new ReviewDAO();
    int reviewResult = dao.insertReview(dto);

    if (reviewResult > 0) {
    	int reviewCount = dao.countReview(storeIdx);
        double avgRating = dao.avgReview(storeIdx);
        
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
    			"<div class='review-item' id='review-" + dto.getReviewIdx() + "'>" +
		        "<div class='review-profile'>" +
		            profileHtml +
		            "<span class='review-writer'>" + dto.getMemberName() + "</span>" +
		            "<span class='review-rating'>평점 " + dto.getReviewRating() + "점</span>" +
		        "</div>" +
		
		        "<div class='review-content'>" +
		
		            "<div class='review-text-wrap'>" +
		                "<p class='review-text'>" + dto.getReviewContent().replace("\n", "<br>") + "</p>" +
		                "<span class='review-date'>방금 전</span>" +
		            "</div>" +
		
					reviewImgHtml.toString()  +
		
		        "</div>" +
		        
				"<div class='review-actions'>" +
				"<button class='review-edit-btn'>수정</button>" +
				"<button class='review-delete-btn'>삭제</button>" +
				"</div>" +
		
		    "</div>";
    	       
        ob.put("reviewResult", "success");
        ob.put("reviewCount", reviewCount);
        ob.put("reviewOrder", reviewCount+1);
        ob.put("reviewHtml", reviewHtml);
        ob.put("avgRating", avgRating);
    } else {
        ob.put("reviewResult", "fail");
    }

}catch (IOException e) {
    ob.put("reviewResult", "file_error");
}catch(Exception e){
    e.printStackTrace();
    ob.put("reviewResult", "fail");
}

out.print(ob.toString());
%>