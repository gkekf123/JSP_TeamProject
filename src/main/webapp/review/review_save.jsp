<%@page import="com.team.project.dto.MemberDTO"%>
<%@page import="com.team.project.dao.MemberDAO"%>
<%@page import="com.team.project.dao.ReviewDAO"%>
<%@page import="com.team.project.dto.ReviewDTO"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
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
String loginOk = (String) session.getAttribute("loginok");
String memberId = (String) session.getAttribute("member_id");

if (!"yes".equals(loginOk) || memberId == null) {
    ob.put("reviewResult", "login_required");
    out.print(ob.toString());
    return;
}

//================= 업로드 설정 =================
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
    
    int storeIdx = Integer.parseInt(multi.getParameter("store_idx"));
    int reviewRating = Integer.parseInt(multi.getParameter("review_rating"));
    String reviewContent = multi.getParameter("review_content");
    
/*  // ===== 여러 이미지 파일명 모으기 =====
    List<String> reviewImgList = new ArrayList<>();
    Enumeration reviewImgfiles = multi.getFileNames();
    while (reviewImgfiles.hasMoreElements()) {
        String paramName = (String) reviewImgfiles.nextElement();
        String filename = multi.getFilesystemName(paramName);
        // DB에 저장할 웹 경로 생성
        String webPath = "/images/review_upload/" + filename;
        reviewImgList.add(webPath);
    } */

    // ===== DTO =====
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


    
/*     for (int i = 0; i < reviewImgList.size() && i < 5; i++) {
        switch (i) {
            case 0: dto.setReviewImg1(reviewImgList.get(i)); break;
            case 1: dto.setReviewImg2(reviewImgList.get(i)); break;
            case 2: dto.setReviewImg3(reviewImgList.get(i)); break;
            case 3: dto.setReviewImg4(reviewImgList.get(i)); break;
            case 4: dto.setReviewImg5(reviewImgList.get(i)); break;
        }
    }
    
 // ★★★ 중요: 업로드 안 한 이미지는 null로 설정 ★★★
    if (reviewImgList.size() < 1) dto.setReviewImg1(null);
    if (reviewImgList.size() < 2) dto.setReviewImg2(null);
    if (reviewImgList.size() < 3) dto.setReviewImg3(null);
    if (reviewImgList.size() < 4) dto.setReviewImg4(null);
    if (reviewImgList.size() < 5) dto.setReviewImg5(null); */
    
    // ★★★ 모든 이미지 null로 초기화 ★★★
    dto.setReviewImg1(null);
    dto.setReviewImg2(null);
    dto.setReviewImg3(null);
    dto.setReviewImg4(null);
    dto.setReviewImg5(null);

    // ★★★ 각 input에서 파일 가져오기 ★★★
    String img1 = multi.getFilesystemName("review_img1");
    String img2 = multi.getFilesystemName("review_img2");
    String img3 = multi.getFilesystemName("review_img3");
    String img4 = multi.getFilesystemName("review_img4");
    String img5 = multi.getFilesystemName("review_img5");

    // null이 아니고 빈 문자열도 아닐 때만 설정
    if (img1 != null && !img1.isEmpty()) {
        dto.setReviewImg1("/images/review_upload/" + img1);
    }
    if (img2 != null && !img2.isEmpty()) {
        dto.setReviewImg2("/images/review_upload/" + img2);
    }
    if (img3 != null && !img3.isEmpty()) {
        dto.setReviewImg3("/images/review_upload/" + img3);
    }
    if (img4 != null && !img4.isEmpty()) {
        dto.setReviewImg4("/images/review_upload/" + img4);
    }
    if (img5 != null && !img5.isEmpty()) {
        dto.setReviewImg5("/images/review_upload/" + img5);
    }

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
               
     // ===== 리뷰 이미지 HTML 생성 =====
        StringBuilder reviewImgHtml = new StringBuilder();
        if(dto.getReviewImg1() != null && !dto.getReviewImg1().isEmpty()) {
            reviewImgHtml.append("<div class='review-img-thumb'>")
                         .append("<img src='").append(request.getContextPath()).append(dto.getReviewImg1()).append("'>")
                         .append("</div>");
            
            // 2~5번 이미지는 반복문으로 처리
            String[] otherImgs = {dto.getReviewImg2(), dto.getReviewImg3(), dto.getReviewImg4(), dto.getReviewImg5()};
            for(String imgPath : otherImgs) {
                if(imgPath != null && !imgPath.isEmpty()) {
                    // style='display:none'로 숨김
                    reviewImgHtml.append("<div class='review-img-thumb' style='display:none;'>")
                                 .append("<img src='").append(request.getContextPath()).append(imgPath).append("'>")
                                 .append("</div>");
                }
            }
        }
        reviewImgHtml.append("</div>");
        
    	String reviewHtml =
    			"<div class='review-item'>" +

		        "<div class='review-profile'>" +
		            profileHtml +
		            "<span class='review-writer'>" + dto.getMemberName() + "</span>" +
		            "<span class='review-rating'>평점 " + dto.getReviewRating() + "점</span>" +
		        "</div>" +
		
		        "<div class='review-content'>" +
		
		            "<div class='review-text-wrap'>" +
		                "<p class='review-text'>" + dto.getReviewContent() + "</p>" +
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
        ob.put("reviewOrder", reviewCount +1 );
        ob.put("reviewHtml", reviewHtml);
        ob.put("avgRating", avgRating);
    } else {
        ob.put("reviewResult", "fail");
    }

}catch(Exception e){
    e.printStackTrace();
    ob.put("reviewResult", "fail");
	
}
%>
<%=ob.toString()%>