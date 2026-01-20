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


/* 
	//로그인 확인 - 서버
	String loginOk = (String) session.getAttribute("loginok");
	String memberId = (String) session.getAttribute("member_id");

	if (!"yes".equals(loginOk) || memberId == null) {
    	ob.put("reviewResult", "login_required");
    	out.print(ob.toString());
    	return;
	}
*/



//================= 업로드 설정 =================
String savePath= application.getRealPath("/images/review_upload");
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
    
 // ===== 여러 이미지 파일명 모으기 =====
    List<String> reviewImgList = new ArrayList<>();
    Enumeration reviewImgfiles = multi.getFileNames();
    while (reviewImgfiles.hasMoreElements()) {
        String paramName = (String) reviewImgfiles.nextElement();
        String filename = multi.getFilesystemName(paramName);
        if (filename != null) reviewImgList.add(filename);
    }

    // ===== DTO =====
    ReviewDTO dto = new ReviewDTO();
    dto.setStoreIdx(storeIdx);
    
    //테스트용
    dto.setMemberId("admin"); //임의지정
	dto.setMemberName("테스트"); //임의지정
	dto.setMemberImg("logo.png"); //임의지정
	
	/* 	
	MemberDAO mdao = new MemberDAO();
	MemberDTO mdto = mdao.getMyInfo(memberId);
	dto.setMemberId(memberId);
	dto.setMemberName(mdto.getMember_name());
	dto.setMemberImg(mdto.getMember_img());
	*/

	
    dto.setReviewRating(reviewRating);
    dto.setReviewContent(reviewContent);


    
    for (int i = 0; i < reviewImgList.size() && i < 5; i++) {
        switch (i) {
            case 0: dto.setReviewImg1(reviewImgList.get(i)); break;
            case 1: dto.setReviewImg2(reviewImgList.get(i)); break;
            case 2: dto.setReviewImg3(reviewImgList.get(i)); break;
            case 3: dto.setReviewImg4(reviewImgList.get(i)); break;
            case 4: dto.setReviewImg5(reviewImgList.get(i)); break;
        }
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
    	
    	String reviewHtml =
    		    "<div class='review-item'>" +

    		    " <div class='review-profile'>" +
    		          profileHtml +
    		    " </div>" +

    	        " <div class='review-content'>" +
    	        "   <div class='review-top'>" +
    	        "     <span class='review-writer'>" + dto.getMemberName() + "</span>" +
    	        "     <span class='review-rating'>평점 " + dto.getReviewRating() + " ★★★★★</span>" +
    	        "   </div>" +
    	        "   <p class='review-text'>" + dto.getReviewContent() + "</p>" +
    	        "   <span class='review-date'>방금 전</span>" +
    	        " </div>" +

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