package oracle.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DbConnect {
	// 필드
	String driver = "oracle.jdbc.driver.OracleDriver"; // 퀀텀에서 우클릭 프로퍼티
	String gangsa_url = "jdbc:oracle:thin:@192.168.0.10:1521:xe";
	String my_url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String gangsa_id = "angel";
	String my_id = "angel";
	String gangsa_pass = "a1234";
	String my_pass = "a1234";

	// Constructor!!
	public DbConnect() {
		try {
			Class.forName(driver);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			System.out.println("오라클 드라이버 실패:" + e.getMessage());
		}
	}

	// Method Start!!
	// 강사 pc 오라클 연결
	public Connection getGangsaConnection() {
		Connection conn = null;
		try {
			conn = DriverManager.getConnection(gangsa_url, gangsa_id, gangsa_pass);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("강사 pc 오라클 연결 실패" + e.getMessage());
		}
		return conn;
	}

	// 내 pc 연결
	public Connection getMyConnection() {
		Connection conn = null;
		try {
			conn = DriverManager.getConnection(my_url, my_id, my_pass);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("내 pc 오라클 연결 실패" + e.getMessage());
		}
		return conn;
	}
	
	public void dbClose(Connection conn, Statement stmt) {
		try {
			if(stmt!=null) stmt.close();
			if(conn!=null) conn.close();
		} catch (Exception e) {
			
		}
	}
	
	public void dbClose(Connection conn, Statement stmt, ResultSet rs) {
		try {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
			if(conn!=null) conn.close();
		} catch (Exception e) {
			
		}
	}
	
	public void dbClose(Connection conn, PreparedStatement pstmt) {
		try {
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		} catch (Exception e) {
			
		}
	}
	
	public void dbClose(Connection conn, PreparedStatement pstmt, ResultSet rs) {
		try {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		} catch (Exception e) {
			
		}
	}
	
	

}
