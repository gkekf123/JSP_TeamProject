<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.team.project.dao.MemberDAO"%>
<%@page import="com.team.project.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
request.setCharacterEncoding("utf-8");

//업로드 경로
String uploadPath = application.getRealPath("/upload");
int uploadSize = 5 * 1024 * 1024; // 5MB

MultipartRequest multi=null;
try{
	multi=new MultipartRequest(request,uploadPath,uploadSize,"utf-8",new DefaultFileRenamePolicy());
	
	String member_id    = multi.getParameter("member_id");
	String member_pw    = multi.getParameter("member_pw");
	String member_name  = multi.getParameter("member_name");
	String member_role  = multi.getParameter("member_role");
	String member_email = multi.getParameter("member_email");
	String member_hp    = multi.getParameter("member_hp");
	String member_addr  = multi.getParameter("member_addr");

	//파일명
	String member_img = multi.getFilesystemName("member_img");
	if(member_img == null) {
	 member_img = "noimage.png";
	}

	MemberDTO dto=new MemberDTO();
	dto.setMember_id(member_id);
	dto.setMember_pw(member_pw);
	dto.setMember_name(member_name);
	dto.setMember_role(member_role); // admin or null
	dto.setMember_email(member_email);
	dto.setMember_hp(member_hp);
	dto.setMember_addr(member_addr);
	dto.setMember_img(member_img); // 기본 이미지

	MemberDAO dao = new MemberDAO();
	dao.insertMember(dto);

}catch(Exception e){
	
}
%>
<script>
    alert("회원가입이 완료되었습니다");
    location.href = "sign_Up.jsp";
</script>
<body>

</body>
</html>