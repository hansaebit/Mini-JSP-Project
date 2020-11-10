package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Vector;

import data.dto.MemberDto;
import data.dto.MoneyDto;
import oracle.db.DbConnect;

public class MoneyDao {
	
	DbConnect db=new DbConnect();
	
	
	// add money
	public void addMoney(MoneyDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql="insert into daymoney values (money_seq.nextval,?,?,?)";
		
		conn=db.getMyConnection();
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, dto.getPummok());
			pstmt.setString(2, dto.getPrice());
			pstmt.setString(3, dto.getDay());
			
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(conn, pstmt);
			
		}
	} // add money end !!!
	
	// data list!!!
	public List<MoneyDto> moneylist(){
		List<MoneyDto> list = new Vector<MoneyDto>();
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		String sql="select * from daymoney";
		
		conn=db.getMyConnection();
		
		try {
			pstmt=conn.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {		
			MoneyDto dto = new MoneyDto();
			dto.setNum(rs.getString("num"));
			dto.setPummok(rs.getString("pummok"));
			dto.setPrice(rs.getString("price"));
			dto.setDay(rs.getString("day"));
			
			list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(conn, pstmt, rs);
		}
		
		return list;
	}//data list end !!
	
	//date update find
	public MoneyDto findMoney(String num) {
		MoneyDto dto = new MoneyDto();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql="select * from daymoney where num=?";
		conn=db.getMyConnection();
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, num);
			
			rs=pstmt.executeQuery();
			if(rs.next()) {
				
				dto.setDay(rs.getString("day"));
				dto.setNum(rs.getString("num"));
				dto.setPrice(rs.getString("price"));
				dto.setPummok(rs.getString("pummok"));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(conn, pstmt);
			
		}
		return dto;
	} // update
	
	
	public void updateMoney(MoneyDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql="update daymoney set pummok=?, price=?, day=? where num=?";
		
		conn=db.getMyConnection();
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, dto.getPummok());
			pstmt.setString(2, dto.getPrice());
			pstmt.setString(3, dto.getDay());
			pstmt.setString(4, dto.getNum());
			
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(conn, pstmt);
			
		}
	} // update
	
	
	public void deleteMoney(String num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql="delete from daymoney where num=?";
		
		conn=db.getMyConnection();
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, num);
			
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(conn, pstmt);
			
		}
	} // update
	
	
	public String allMoney() {
		String a="";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		String sql="select sum(price) sum from daymoney";
		
		conn=db.getMyConnection();
		
		try {
			pstmt=conn.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				a = rs.getString("sum");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			
			db.dbClose(null, pstmt, rs);
			
		}
		return a;
		
	}
	
	

}
