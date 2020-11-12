package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import data.dto.ShopDto;
import oracle.db.DbConnect;

public class ShopDao {
	DbConnect db=new DbConnect();
	
	//insert
	public void insertShop(ShopDto dto) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		String sql="insert into shop values (seq_mini.nextval,?,?,?,?,?,?)";
		conn=db.getMyConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, dto.getCategory());
			pstmt.setString(2, dto.getSangpum());
			pstmt.setString(3, dto.getPhoto());
			pstmt.setInt(4, dto.getPrice());
			pstmt.setString(5, dto.getColor());
			pstmt.setString(6, dto.getIpgoday());
			
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(conn, pstmt);
		}
		
	}
	
	//전체 데이터 가져오기
	
	public List<ShopDto> getAllSangpums(){
		List<ShopDto> list=new ArrayList<ShopDto>();
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select * from shop order by shopnum desc";
		conn=db.getMyConnection();
		
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				ShopDto dto=new ShopDto();
				dto.setCategory(rs.getString("category"));
				dto.setColor(rs.getString("color"));
				dto.setIpgoday(rs.getString("ipgoday"));
				dto.setPhoto(rs.getString("photo"));
				dto.setPrice(rs.getInt("price"));
				dto.setSangpum(rs.getString("sangpum"));
				dto.setShopnum(rs.getString("shopnum"));
				
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
	
	
	public ShopDto getData(String shopnum) {
		ShopDto dto=new ShopDto();
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select * from shop where shopnum=?";
		conn=db.getMyConnection();
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, shopnum);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				dto.setCategory(rs.getString("category"));
				dto.setColor(rs.getString("color"));
				dto.setIpgoday(rs.getString("ipgoday"));
				dto.setPhoto(rs.getString("photo"));
				dto.setPrice(rs.getInt("price"));
				dto.setSangpum(rs.getString("sangpum"));
				dto.setShopnum(rs.getString("shopnum"));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(conn, pstmt, rs);
		}
		return dto;
	}
}
