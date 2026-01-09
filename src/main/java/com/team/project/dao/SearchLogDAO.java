package com.team.project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import com.team.project.util.DBConn;

public class SearchLogDAO {

    // 검색 기록 저장 메서드
    public int insertSearchLog(String query, String response) {
        int result = 0;
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        String sql = "INSERT INTO search_log (search_query, ai_response) VALUES (?, ?)";

        try {
            conn = DBConn.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, query);
            pstmt.setString(2, response);
            
            result = pstmt.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBConn.close(null, pstmt, conn);
        }
        return result;
    }
}