package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import data.dto.DataBoardDto;
import data.dto.GuestDto;
import oracle.db.DbConnect;

public class DataBoardDao {
	DbConnect db=new DbConnect();
	
	//갯수 반환
	//key값에 따라서 
	//all	: 전체보기.
	//myid 	: 해당 아이디만 보기
	//subject: 제목에서 검색(value)한 갯수 
	//content: 내용에서 검색(value)한 갯수
	public int getTotalCount(String key,String value) {
		System.out.println(key+":"+value);
		int total=0;
		String sql="";
		if(key==null||key.equals("all")) 
			sql="select count(*) from databoard";
		else if(key.equals("myid"))
			sql="select count(*) from databoard where myid='"+value+"'";
		else if(key.equals("subject"))
			sql="select count(*) from databoard where subject like '%"+value+"%'";
		else if(key.equals("subject"))
			sql="select count(*) from databoard where content like '%"+value+"%'";
		
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		conn=db.getGangsaConnection();
		
		try {
			stmt=conn.createStatement();
			rs=stmt.executeQuery(sql);
			if(rs.next())
				total=rs.getInt(1);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(conn, stmt, rs);
		}
		return total;
	}
	
	//insert
	public void insertBoard(DataBoardDto dto) {
		String sql="insert into databoard values (seq_mini.nextval,?,?,?,?,0,sysdate)";
		Connection conn=null;
		PreparedStatement pstmt=null;
		conn=db.getGangsaConnection();

		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, dto.getMyid());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getFiles());
			pstmt.setString(4, dto.getContent());
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(conn, pstmt);
		}
	}
	
	//검색결과리스트 중 한페이지에서 필요한 만큼 반환하기
	public List<DataBoardDto> getSearchList(String key, String value, int start, int end){
		List<DataBoardDto> list=new ArrayList<DataBoardDto>();
		String s="";
		if(key!=null) {
			if(key.equals("myid"))
				s="where myid='"+value+"'";
			else if(key.equals("subject"))
				s="where subject like '%"+value+"%'";
			else if(key.equals("content"))
				s="where content like '%"+value+"%'";   
		}
		String sql="select a.* from (select ROWNUM as RNUM,b.* from "+
            "(select * from databoard "+s+" order by num desc)b)a " + 
            "where a.RNUM>=? and a.RNUM<=?";
	
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		conn=db.getGangsaConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs=pstmt.executeQuery();
		
			while(rs.next()) {
				DataBoardDto dto=new DataBoardDto();
				dto.setNum(rs.getString("num"));
				dto.setMyid(rs.getString("myid"));
				dto.setSubject(rs.getString("subject"));
				dto.setFiles(rs.getString("files"));
				dto.setContent(rs.getString("content"));
				dto.setWriteday(rs.getTimestamp("writeday"));
			
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
}
