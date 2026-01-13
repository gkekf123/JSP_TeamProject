<%@page import="java.sql.*"%>
<%@page import="com.team.project.util.DBConn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String member_id = (String)session.getAttribute("login_id");
    // 로그인이 안 되어 있으면 JS에서 처리하므로 여기선 status만 리턴
    if(member_id == null) {
        out.print("login_needed");
        return;
    }

    request.setCharacterEncoding("UTF-8");
    
    String storeIdxStr = request.getParameter("store_idx");
    String name = request.getParameter("place_name");
    String addr = request.getParameter("place_addr");
    
    // store_idx가 있으면 숫자로 변환, 없으면 0
    int storeIdx = (storeIdxStr != null && !storeIdxStr.isEmpty()) ? Integer.parseInt(storeIdxStr) : 0;

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        conn = DBConn.getConnection();
        
        // 1. 이미 찜했는지 확인 (SELECT)
        String checkSql = "SELECT count(*) FROM bookmark WHERE member_id = ? AND store_idx = ?";
        pstmt = conn.prepareStatement(checkSql);
        pstmt.setString(1, member_id);
        pstmt.setInt(2, storeIdx);
        rs = pstmt.executeQuery();
        
        boolean isExist = false;
        if(rs.next() && rs.getInt(1) > 0) {
            isExist = true;
        }
        rs.close();
        pstmt.close();

        // 2. 있으면 삭제 (DELETE), 없으면 저장 (INSERT)
        if(isExist) {
            String delSql = "DELETE FROM bookmark WHERE member_id = ? AND store_idx = ?";
            pstmt = conn.prepareStatement(delSql);
            pstmt.setString(1, member_id);
            pstmt.setInt(2, storeIdx);
            pstmt.executeUpdate();
            out.print("removed"); // 삭제됨 메시지
        } else {
            String insSql = "INSERT INTO bookmark (member_id, store_idx, place_name, place_addr) VALUES (?, ?, ?, ?)";
            pstmt = conn.prepareStatement(insSql);
            pstmt.setString(1, member_id);
            pstmt.setInt(2, storeIdx);
            pstmt.setString(3, name);
            pstmt.setString(4, addr);
            pstmt.executeUpdate();
            out.print("added"); // 추가됨 메시지
        }

    } catch(Exception e) {
        e.printStackTrace();
        out.print("error");
    } finally {
        DBConn.close(rs, pstmt, conn);
    }
%>