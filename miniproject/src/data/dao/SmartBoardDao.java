package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import data.dto.SmartBoardDto;
import oracle.db.DbConnect;

public class SmartBoardDao {
	DbConnect db=new DbConnect();
	
	//Insert
	public void insertSmart(SmartBoardDto dto) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		
		String sql="insert into smartbbs values (num.nextval,?,?,?,0,sysdate)";
		
		conn=db.getMyConnection();
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
			
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(conn, pstmt);
			
		}
	}
	
	//TotalCount
	public int getTotalCount() {
		int a=0;
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="SELECT COUNT(*) count FROM smartbbs";
		conn=db.getMyConnection();
		
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				a=rs.getInt(1);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(conn, pstmt, rs);
			
		}
		return a;
	}
	
	//페이지처링한 리스트 목록
	public List<SmartBoardDto> getList(int start, int end){
		List<SmartBoardDto> list = new ArrayList<SmartBoardDto>();
		String sql="select a.* from (select ROWNUM as RNUM,b.* from(select * from smartbbs order by num desc)b)a where a.RNUM>=? and a.RNUM<=?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		conn=db.getMyConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			//바인딩
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			//실행
			rs=pstmt.executeQuery();
			while(rs.next()) {
				SmartBoardDto dto = new SmartBoardDto();
				dto.setNum(rs.getString("num"));
				dto.setName(rs.getString("name"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setWriteday(rs.getTimestamp("writeday"));
				//list에 추가
				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(conn, pstmt, rs);	
		}		
		return list;
	}
	
	
	
	public SmartBoardDto getData(String num){
		
		SmartBoardDto dto = new SmartBoardDto();
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select * from smartbbs where num=?";
		
		conn=db.getMyConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, num);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				dto.setNum(rs.getString("num"));
				dto.setName(rs.getString("name"));
				dto.setSubject(rs.getString("subject"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setContent(rs.getString("content"));
				dto.setWriteday(rs.getTimestamp("writeday"));
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(conn, pstmt, rs);
			
		}
		return dto;
	}
	
	public int getMaxNum() {
		int max=0;
		String sql="select nvl(max(num),0) max from smartbbs;"; //if max(num)이 null일 때 0
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		conn=db.getMyConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next())
				max=rs.getInt(1); //컬럼 순번으로 읽어오기.
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(conn, pstmt, rs);
		}
		return max;
	}
	
	public void updateReadcount(String num) {
		String sql="update smartbbs set readcount=readcount+1 where num=?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		conn=db.getMyConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, num);
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(conn, pstmt);
		}
	}
}
