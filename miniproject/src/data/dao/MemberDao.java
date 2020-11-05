package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import oracle.db.DbConnect;

public class MemberDao {
	//아이디 중복확인 메서드
	DbConnect db=new DbConnect();
	
	//아이디가 있으면 true, 없으면 false
	public boolean isIdSerarch(String id){
		boolean find=false;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql="select * from member where id=?";
		
		conn=db.getMyConnection();
		
		try {
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			if(rs.next()) 
				find=true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(conn, pstmt, rs);
		}
		
		return find;
	}
}
