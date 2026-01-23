<%@ page import="com.team.project.dao.MemberDAO"%>
<%@ page import="com.team.project.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");

    String member_id = request.getParameter("member_id");
    String member_pw = request.getParameter("member_pw");
    String save = request.getParameter("save"); // 체크박스 값 (체크하면 "yes", 안하면 null)

    MemberDAO dao = new MemberDAO();
    MemberDTO dto = dao.loginCheck(member_id, member_pw); 

    if (dto != null) {
        // [1] 로그인 성공 처리 (필수 세션)
        session.setAttribute("loginok", "yes");
        session.setAttribute("member_id", dto.getMemberId());
        session.setAttribute("member_role", dto.getMemberRole()); 

        // [2] 아이디 저장 로직 (세션 방식)
        if (save != null) {
            // 체크박스 체크 함 -> 세션에 아이디를 따로 저장해둠
            session.setAttribute("saveid", dto.getMemberId());
        } else {
            // 체크 해제 함 -> 저장해둔 아이디 세션 삭제
            session.removeAttribute("saveid");
        }

        // [3] 메인 페이지로 이동
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return;
    }
%>
<script>
    alert("아이디 또는 비밀번호가 틀렸습니다.");
    history.back();
</script>