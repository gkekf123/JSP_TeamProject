<%@page import="java.sql.*"%>
<%@page import="com.team.project.util.DBConn"%>
<%@page import="com.team.project.dao.BookmarkDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
    // 1. 세션 체크
    String member_id = (String) session.getAttribute("member_id");
    
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
    String kakaoId = request.getParameter("kakao_id"); // 카카오 ID

    int storeIdx = (storeIdxStr != null && !storeIdxStr.isEmpty()) ? Integer.parseInt(storeIdxStr) : 0;

    BookmarkDAO dao = new BookmarkDAO();
    boolean isExist = false;

    if(storeIdx > 0) {
        // 내부 가게
        isExist = dao.isBookmarked(member_id, storeIdx);
        
        if(isExist) {
            // 이미 있으면 삭제 (찜 해제)
            int result = dao.removeBookmark(member_id, storeIdx);
            if(result > 0) out.print("removed");
            else out.print("error");
        } else {
            // 없으면 추가 (찜 하기)
            int result = dao.addBookmark(member_id, storeIdx, name, addr, url, phone, kakaoId);
            if(result > 0) out.print("added");
            else out.print("error");
        }
        
    } else {
        // 외부 가게 (카카오맵 장소)
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConn.getConnection();
            
            // 1. 중복 체크
            // 외부 가게는 store_idx가 0이므로 URL이나 카카오ID로 식별해야 함
            String checkSql = "SELECT count(*) FROM bookmark WHERE member_id=? AND place_url=?";
            pstmt = conn.prepareStatement(checkSql);
            pstmt.setString(1, member_id);
            pstmt.setString(2, url);
            rs = pstmt.executeQuery();
            
            if(rs.next() && rs.getInt(1) > 0) {
                isExist = true;
            }
            // 자원 정리 후 재사용을 위해 close
            rs.close();
            pstmt.close();
            
            // 2. 토글 실행
            if(isExist) {
                // 삭제 (찜 해제)
                String delSql = "DELETE FROM bookmark WHERE member_id=? AND place_url=?";
                pstmt = conn.prepareStatement(delSql);
                pstmt.setString(1, member_id);
                pstmt.setString(2, url);
                int result = pstmt.executeUpdate();
                
                if(result > 0) out.print("removed");
                else out.print("error");
                
            } else {
                // 추가 (찜 하기) - storeIdx는 0으로 들어감
                int result = dao.addBookmark(member_id, 0, name, addr, url, phone, kakaoId);
                
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