<%@page import="java.sql.*"%>
<%@page import="com.team.project.util.DBConn"%>
<%@page import="com.team.project.dto.MemberDTO"%>
<%@page import="com.team.project.dao.BookmarkDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
    // 1. 세션 체크 (기존과 동일)
    Object loginObj = session.getAttribute("loginMember");
    String member_id = null;

    if (loginObj != null) {
        if (loginObj instanceof MemberDTO) {
            member_id = ((MemberDTO) loginObj).getMemberId();
        } else if (loginObj instanceof String) {
            member_id = (String) loginObj; 
        }
    }
    
    if(member_id == null) {
        out.print("login_needed");
        return;
    }

    request.setCharacterEncoding("UTF-8");
    
    // 파라미터 수신
    String storeIdxStr = request.getParameter("store_idx");
    String name = request.getParameter("place_name");
    String addr = request.getParameter("place_addr");
    String url = request.getParameter("place_url");   
    String phone = request.getParameter("place_phone"); 

    int storeIdx = (storeIdxStr != null && !storeIdxStr.isEmpty()) ? Integer.parseInt(storeIdxStr) : 0;

    BookmarkDAO dao = new BookmarkDAO();
    boolean isExist = false;

    // 내부 가게(Store)와 외부 가게(Map) 구분 로직
    
    if(storeIdx > 0) {
        // Store 기능 (기존 로직 유지 - 안전함)
        isExist = dao.isBookmarked(member_id, storeIdx);
        
        if(isExist) {
            int result = dao.removeBookmark(member_id, storeIdx);
            if(result > 0) out.print("removed");
            else out.print("error");
        } else {
            int result = dao.addBookmark(member_id, storeIdx, name, addr, url, phone);
            if(result > 0) out.print("added");
            else out.print("error");
        }
        
    } else {
        // Map 기능 (URL 기준으로 처리)
        // DAO를 고치지 않고 JSP에서 직접 URL 중복 확인 및 삭제 처리
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConn.getConnection();
            
            // 2-1. URL로 이미 찜했는지 확인
            String checkSql = "SELECT count(*) FROM bookmark WHERE member_id=? AND place_url=?";
            pstmt = conn.prepareStatement(checkSql);
            pstmt.setString(1, member_id);
            pstmt.setString(2, url);
            rs = pstmt.executeQuery();
            
            if(rs.next() && rs.getInt(1) > 0) {
                isExist = true;
            }
            rs.close();
            pstmt.close();
            
            // 2-2. 토글 실행
            if(isExist) {
                // 이미 있으므로 삭제 (URL 기준 DELETE)
                String delSql = "DELETE FROM bookmark WHERE member_id=? AND place_url=?";
                pstmt = conn.prepareStatement(delSql);
                pstmt.setString(1, member_id);
                pstmt.setString(2, url);
                int result = pstmt.executeUpdate();
                
                if(result > 0) out.print("removed");
                else out.print("error");
                
            } else {
                // 없으므로 추가 (기존 DAO 재활용 - storeIdx가 0으로 들어감)
                int result = dao.addBookmark(member_id, 0, name, addr, url, phone);
                if(result > 0) out.print("added");
                else out.print("error");
            }
            
        } catch(Exception e) {
            e.printStackTrace();
            out.print("error");
        } finally {
            DBConn.close(rs, pstmt, conn);
        }
    }
%>