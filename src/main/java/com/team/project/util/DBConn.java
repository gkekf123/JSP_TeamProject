package com.team.project.util;

import java.sql.Connection;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class DBConn {
    
	
	
	
	
    // Connection 객체를 얻어오는 공통 메서드
    public static Connection getConnection() {
        Connection conn = null;
        try {
            // 1. Context 객체 생성 (JNDI 탐색용)
            Context initContext = new InitialContext();
            
            // 2. 톰캣 환경 설정 탐색 (고정된 문구)
            Context envContext = (Context) initContext.lookup("java:/comp/env");
            
            // 3. context.xml에서 설정한 "name"으로 데이터소스(커넥션 풀) 찾기
            DataSource ds = (DataSource) envContext.lookup("jdbc/mysqldb");
            
            // 4. 커넥션 빌려오기
            conn = ds.getConnection();
            
             System.out.println("DB 연결 성공!"); // 테스트용
            
        } catch (NamingException | SQLException e) {
            e.printStackTrace();
            System.out.println("DB 연결 실패: 설정 파일을 확인하세요.");
        }
        return conn;
    }
    
    // (선택) 연결 해제(반납)용 메서드 - close()
    public static void close(Connection conn) {
        try {
            if (conn != null) conn.close();
        } catch (Exception e) { e.printStackTrace(); }
    }
}