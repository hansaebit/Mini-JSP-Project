package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import data.dto.CartDto;
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
	
	//cart insert
	public void insertCart(CartDto dto)
	{
		Connection conn=null;
		PreparedStatement pstmt=null;
		String sql="insert into cart values (seq_mini.nextval,"
				+ "?,?,?,?,sysdate)";
		conn=db.getMyConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			//���ε�
			pstmt.setString(1, dto.getShopnum());
			pstmt.setString(2, dto.getNum());
			pstmt.setString(3, dto.getMycolor());
			pstmt.setInt(4, dto.getCnt());
			
			//����
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(conn, pstmt);
		}
	}
	
	//��ٱ��� ���
	public List<HashMap<String, String>> getCartList(String id)
	{
		String sql="select c.idx,s.sangpum,s.shopnum,s.photo,"
				+ "s.price,c.cnt,c.mycolor,c.cartday from cart c,"
				+ "shop s,member m where c.shopnum=s.shopnum "
				+ "and c.num=m.num and m.id=?";
		List<HashMap<String,String>> list=
				new ArrayList<HashMap<String,String>>();
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		conn=db.getMyConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			//���ε�
			pstmt.setString(1, id);
			//����
			rs=pstmt.executeQuery();
			while(rs.next())
			{
				HashMap<String,String> map=new HashMap<String, String>();
				map.put("idx",rs.getString("idx"));
				map.put("sangpum",rs.getString("sangpum"));
				map.put("shopnum",rs.getString("shopnum"));
				map.put("photo",rs.getString("photo"));
				map.put("price",rs.getString("price"));
				map.put("cnt",rs.getString("cnt"));
				map.put("mycolor",rs.getString("mycolor"));
				map.put("cartday",rs.getString("cartday").substring(0,10));
				//list �� �߰�
				list.add(map);				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(conn, pstmt, rs);
		}
		return list;
	}
	
	public void deleteCart(String idx) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		String sql="delete from cart where idx=?";
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
}
