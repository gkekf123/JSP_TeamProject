<%@page import="java.io.File"%>
<%@page import="com.team.project.dao.MemberDAO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");



// 1. 저장 경로 설정 (/upload 폴더)
String saveFolder = "/upload";
String uploadPath = application.getRealPath(saveFolder);
// 2. ★ 중요: 폴더가 없으면 자동 생성 (에러 방지)
File dir = new File(uploadPath);
if (!dir.exists()) {
    dir.mkdirs(); 
}
int uploadSize = 10 * 1024 * 1024; // 10MB
String encoding = "UTF-8";
try {
    // 3. 파일 업로드 수행
    MultipartRequest multi = new MultipartRequest(
        request, uploadPath, uploadSize, encoding, new DefaultFileRenamePolicy()
    );
    // 4. 파라미터 받기
    String member_id = multi.getParameter("member_id");
    String member_img = multi.getFilesystemName("member_img"); // 저장된 파일명
    // 5. DB 업데이트 및 세션 갱신
    if (member_img != null) {
        MemberDAO dao = new MemberDAO();
        dao.updateProfileImg(member_id, member_img);
        // ★ 중요: 세션 정보도 바꿔줘야 화면(헤더 등)에서 즉시 바뀜
        // (기존 MemberDTO를 갱신하거나, 세션값 재설정 필요. 여기서는 예시로 남김)
        // session.setAttribute("member_img", member_img); 
    }
    // 6. 마이페이지로 복귀
    response.sendRedirect("my_page.jsp");
} catch (Exception e) {
    e.printStackTrace();
%>
        <script>
            alert("이미지 변경 중 오류가 발생했습니다.");
            history.back();
        </script>
<%
    }
%>