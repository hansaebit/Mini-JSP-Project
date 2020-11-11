package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import data.dto.GuestDto;
import oracle.db.DbConnect;

public class GuestDao {
	DbConnect db=new DbConnect();
	
	public void insertGuest(GuestDto dto) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		
		String sql="insert into guest values (num.nextval,?,?,?,sysdate)";
		
		conn=db.getMyConnection();
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, dto.getMyid());
			pstmt.setString(2, dto.getPhoto());
			pstmt.setString(3, dto.getContent());
			
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(conn, pstmt);
			
		}
	}
	
	public String getTotalCount() {
		String a="";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="SELECT COUNT(*) count FROM guest";
		conn=db.getMyConnection();
		
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				a=rs.getString("count");
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
	public List<GuestDto> getList(int start, int end){
		List<GuestDto> list = new ArrayList<GuestDto>();
		String sql="select a.* from (select ROWNUM as RNUM,b.* from(select * from guest order by num desc)b)a where a.RNUM>=? and a.RNUM<=?";
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
				GuestDto dto = new GuestDto();
				dto.setNum(rs.getString("num"));
				dto.setMyid(rs.getString("myid"));
				dto.setContent(rs.getString("content"));
				dto.setPhoto(rs.getString("photo"));
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
	
	
	
	public GuestDto getData(String num){
		
		GuestDto dto = new GuestDto();
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select * from guest where num=?";
		
		conn=db.getMyConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, num);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				dto.setNum(rs.getString("num"));
				dto.setMyid(rs.getString("myid"));
				dto.setContent(rs.getString("content"));
				dto.setPhoto(rs.getString("photo"));
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
	//photo는 null이 아닐 경우에만 수정, content 만 수정
	public void updateGuest(GuestDto dto){	
		Connection conn=null;
		PreparedStatement pstmt=null;
		
		String sql="";
		
		conn=db.getMyConnection();
		
		try {
			if(dto.getPhoto()==null) {
				sql="update guest set content=? where num=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, dto.getContent());
				pstmt.setString(2, dto.getNum());
			}
			else {
				sql="update guest set photo=?,content=? where num=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, dto.getPhoto());
				pstmt.setString(2, dto.getContent());
				pstmt.setString(3, dto.getNum());
			}
			pstmt.execute();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(conn, pstmt);
			
		}
	}
	
	//삭제
	public void deleteGuest(String num) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		String sql="delete from guest where num=?";
		conn=db.getMyConnection();
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, num);
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			db.dbClose(conn, pstmt);
			
		}
				
	}
	
}
