<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.naming.*, javax.sql.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<title>DB 연결 테스트</title>
</head>
<body>
    <h2>DB 연결 테스트 결과</h2>
    <hr>
    <%
        Connection conn = null;
        try {
            // 1. 톰캣 설정(context.xml)에서 리소스를 찾음
            Context initCtx = new InitialContext();
            Context envCtx = (Context) initCtx.lookup("java:comp/env");
            
            // 2. Resource 이름으로 데이터베이스 정보를 가져옴 
            DataSource ds = (DataSource) envCtx.lookup("jdbc/mysqldb");
            
            // 3. 연결 시도
            conn = ds.getConnection();
            
            if(conn != null) {
    %>
                <h3 style="color: green;">🎉 연결 성공! (Success)</h3>
                <p>연결된 DB: <%= conn.getMetaData().getURL() %></p>
                <p>DB 버전: <%= conn.getMetaData().getDatabaseProductVersion() %></p>
    <%
            }
        } catch(Exception e) {
    %>
            <h3 style="color: red;">연결 실패...</h3>
            <p><strong>에러 원인:</strong> <%= e.getMessage() %></p>
            <details>
                <summary>자세한 에러 로그 보기 (클릭)</summary>
                <pre><%= e.toString() %></pre>
            </details>
    <%
        } finally {
            if(conn != null) try { conn.close(); } catch(Exception e) {}
        }
    %>
</body>
</html>