package com.team.project.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class DBConn {
    
    // Connection 객체를 얻어오는 메서드
    public static Connection getConnection() {
        Connection conn = null;
        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:/comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/mysqldb");
            conn = ds.getConnection();
            // System.out.println("DB 연결 성공");
        } catch (NamingException | SQLException e) {
            e.printStackTrace();
            System.out.println("DB 연결 실패: context.xml 설정을 확인하세요.");
        }
        return conn;
    }
    
    public static void close(ResultSet rs, PreparedStatement pstmt, Connection conn) {
        try {
            if (rs != null) rs.close();
        } catch (Exception e) { e.printStackTrace(); }
        
        try {
            if (pstmt != null) pstmt.close();
        } catch (Exception e) { e.printStackTrace(); }
        
        try {
            if (conn != null) conn.close();
        } catch (Exception e) { e.printStackTrace(); }
    }
    
    public static void close(PreparedStatement pstmt, Connection conn) {
        try {
            if (pstmt != null) pstmt.close();
        } catch (Exception e) { e.printStackTrace(); }
        
        try {
            if (conn != null) conn.close();
        } catch (Exception e) { e.printStackTrace(); }
    }
}