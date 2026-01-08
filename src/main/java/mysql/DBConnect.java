package mysql;

import java.sql.Statement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBConnect {

	static final String MYSQLDRIVER="com.mysql.cj.jdbc.Driver";
	static final String MYSQL_URL="jdbc:mysql://myjoo.c5uaqw0amn9r.ap-northeast-2.rds.amazonaws.com/foodroad";

	public DBConnect() {
		try {
			Class.forName(MYSQLDRIVER);
			System.out.println("MYSQL 드라이버 성공");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			System.out.println("MYSQL 드라이버 실패");
		}
	}
	
	//MYSQL 서버 연결 메서드(connection)
	public Connection getDbConnect()
	{
		Connection conn=null;
		
		try {
			conn=DriverManager.getConnection(MYSQL_URL, "adminjoo","asioetu609l3!");
			System.out.println("MYSQL 서버연결 성공");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("MYSQL 서버연결 실패");
		}
		
		return conn;
	}
	
	//close 메서드 만들기
	public void dbClose(ResultSet rs, Statement stmt, Connection conn)
	{
		try {
			rs.close();
			stmt.close();
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void dbClose(Statement stmt, Connection conn)
	{
		try {
			stmt.close();
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void dbClose(ResultSet rs, PreparedStatement pstmt, Connection conn)
	{
		try {
			if (rs != null) rs.close();
	        if (pstmt != null) pstmt.close();
	        if (conn != null) conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void dbClose(PreparedStatement pstmt, Connection conn)
	{
		try {
			pstmt.close();
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
}
