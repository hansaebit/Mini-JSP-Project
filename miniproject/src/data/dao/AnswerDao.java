package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import data.dto.AnswerDto;
import oracle.db.DbConnect;

public class AnswerDao {
	DbConnect db = new DbConnect();
	

	    //insert
	    public void insertAnswer(AnswerDto dto) {
	        Connection conn=null;
	        PreparedStatement pstmt=null;
	        String sql="insert into answer values (num.nextval,?,?,?,sysdate)";
	        
	        conn=db.getMyConnection();
	        
	        try {
	            pstmt=conn.prepareStatement(sql);
	            pstmt.setString(1, dto.getNum());
	            pstmt.setString(2, dto.getMyid());
	            pstmt.setString(3, dto.getMemo());
	            
	            pstmt.execute();
	        } catch (SQLException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        }finally {
	            db.dbClose(conn, pstmt);    
	        }
	    }

	
	//list
	public List<AnswerDto> getAnswerList(String num){
		List<AnswerDto> list = new ArrayList<AnswerDto>();
		
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select * from answer where num=? order by idx desc";
		
		conn=db.getMyConnection();
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, num);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				AnswerDto dto = new AnswerDto();
				dto.setIdx(rs.getString("idx"));
				dto.setNum(rs.getString("num"));
				dto.setMyid(rs.getString("myid"));
				dto.setMemo(rs.getString("memo"));
				dto.setWriteday(rs.getTimestamp("writeday"));
				
				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(conn, pstmt, rs);
		}
		return list;
	}
	
	public void delteAnswer(String idx) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		String sql="delete from answer where idx=?";
		
		conn=db.getMyConnection();
		
		try {
			 pstmt=conn.prepareStatement(sql);
	         pstmt.setString(1, idx);

	         pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(conn, pstmt);	
		}
	}
	
	public String getMemo(String idx) {
		String memo="";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select memo from answer where idx=?";
		conn=db.getMyConnection();
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, idx);
			rs=pstmt.executeQuery();
			
			if(rs.next()) 
				memo = rs.getString("memo");
				
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(conn, pstmt, rs);
		}
		return memo;
	}
	
	public void updateAnswer(String idx, String memo) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		String sql="update answer set memo=? where idx=?";
		
		conn=db.getMyConnection();
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, memo);
			pstmt.setString(2, idx);
			
			pstmt.execute();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(conn, pstmt);
		}
		
	}
		
}
