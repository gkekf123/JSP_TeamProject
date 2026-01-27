<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.team.project.dao.MemberDAO"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
String uploadPath = application.getRealPath("/upload");
int uploadSize = 5 * 1024 * 1024;

MultipartRequest multi = new MultipartRequest(
    request, uploadPath, uploadSize, "UTF-8", new DefaultFileRenamePolicy()
);

String member_id = multi.getParameter("member_id");
String member_img = multi.getFilesystemName("member_img");

if(member_img != null) {
    MemberDAO dao = new MemberDAO();
    dao.updateProfileImg(member_id, member_img);
}

response.sendRedirect(request.getContextPath() + "/member/my_page.jsp");
%>
