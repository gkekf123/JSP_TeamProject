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
String sessionMemberId = (String) session.getAttribute("member_id");

if (loginok == null || sessionMemberId == null) {
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
	MemberDTO mdto = mdao.getMyInfo(sessionMemberId);	
	dto.setMemberId(sessionMemberId);
	dto.setMemberName(mdto.getMemberName());
	dto.setMemberImg(mdto.getMemberImg());

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
        ob.put("reviewResult", "success");
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