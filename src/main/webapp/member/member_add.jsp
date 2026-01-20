<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.team.project.dto.MemberDTO"%>
<%@page import="com.team.project.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("UTF-8");
    try {
        String uploadPath = application.getRealPath("/upload");
        java.io.File uploadDir = new java.io.File(uploadPath);
        if(!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        int uploadSize = 5 * 1024 * 1024; // 5MB

        MultipartRequest multi = new MultipartRequest(
            request, uploadPath, uploadSize, "UTF-8", new DefaultFileRenamePolicy()
        );

        String member_name = multi.getParameter("member_name");
        String member_id = multi.getParameter("member_id");
        String member_pw = multi.getParameter("member_pw1");
        String member_hp = multi.getParameter("member_hp");
        String member_addr = multi.getParameter("member_addr");
        String member_email = multi.getParameter("member_email1") + "@" + multi.getParameter("member_email2");

        String member_img = multi.getFilesystemName("member_img");
        if(member_img == null) member_img = "noimage.png";

        // DTO 세팅
        MemberDTO dto = new MemberDTO();
        dto.setMember_name(member_name);
        dto.setMember_id(member_id);
        dto.setMember_pw(member_pw);
        dto.setMember_hp(member_hp);
        dto.setMember_addr(member_addr);
        dto.setMember_email(member_email);
        dto.setMember_img(member_img);

        dto.setMember_role("USER");
        
        // DB insert
        MemberDAO dao = new MemberDAO();
        dao.insertMember(dto);
%>
<script>
    alert("회원가입이 완료되었습니다!");
    location.href="<%=request.getContextPath()%>/member/gaip_success.jsp";
</script>
<%
    } catch(Exception e) {
        e.printStackTrace();
%>
<div style="text-align:center; margin-top:50px;">
    <h3 style="color:red;">회원가입 처리 중 오류가 발생했습니다.</h3>
    <p><%= e.getMessage() %></p>
</div>
<%
    }
%>