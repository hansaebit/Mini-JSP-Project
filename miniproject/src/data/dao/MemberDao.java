package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Vector;

import data.dto.GuestDto;
import data.dto.MemberDto;
import data.dto.MemberDto2;
import data.dto.ZipcodeDto;
import oracle.db.DbConnect;

public class MemberDao {
	//아이디 중복확인 메서드
	DbConnect db=new DbConnect();
	
	//아이디가 있으면 true, 없으면 false
	public boolean isIdSearch(String id){
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
	
	//동에 해당하는 주소 반환하는 메서드
	public List<ZipcodeDto> getSearchDong(String dong){
		System.out.println(dong);
		List<ZipcodeDto> list=new Vector<ZipcodeDto>();
		String sql="select zipcode,sido,gugun,dong,nvl(ri,' ') ri,nvl(bunji,' ') bunji from zipcode where dong like ?";
		
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		conn=db.getMyConnection();
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, "%"+dong+"%");
			//실행
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				ZipcodeDto dto=new ZipcodeDto();
				dto.setZipcode(rs.getString("zipcode"));
				dto.setSido(rs.getString("sido"));
				dto.setGugun(rs.getString("gugun"));
				dto.setDong(rs.getString("dong"));
				dto.setRi(rs.getString("ri"));
				dto.setBunji(rs.getString("bunji"));;
				//리스트에 추가
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
	
	//회원가입! insert
	public void insertMember(MemberDto dto) {
		String sql="insert into member values (seq_mini.nextval,?,?,?,?,?,?,?,sysdate)";
		Connection conn=null;
		PreparedStatement pstmt=null;
		conn=db.getMyConnection();
		
		try {
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPass());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getAddress());
			pstmt.setString(5, dto.getAddrdetail());
			pstmt.setString(6, dto.getEmail1()+"@"+dto.getEmail2());
			pstmt.setString(7, dto.getHp1()+"-"+dto.getHp2()+"-"+dto.getHp3());
			
			pstmt.execute();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(conn, pstmt);
		}
				
		
	}
	
	//전체 회원 목록
	public List<MemberDto2> getAllMembers(){
		List<MemberDto2> list=new Vector<MemberDto2>();
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select * from member order by id asc";
		conn=db.getMyConnection();
		
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				MemberDto2 dto=new MemberDto2();
				dto.setNum(rs.getString("num"));
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setAddress(rs.getString("address"));
				dto.setAddrdetail(rs.getString("Addrdetail"));
				dto.setHp(rs.getString("hp"));
				dto.setEmail(rs.getString("email"));
				dto.setGaipday(rs.getTimestamp("gaipday"));
	
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
	
	//num에 해당하는 dto 반환
	public MemberDto getData(String num) {
		MemberDto dto=new MemberDto();
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select * from member where num=?";
		conn=db.getMyConnection();
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, num);
			
			rs=pstmt.executeQuery();
			if(rs.next()) {
				dto.setNum(rs.getString("num"));
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setAddress(rs.getString("address"));
				dto.setAddrdetail(rs.getString("addrdetail"));
				
				String[] hp=rs.getString("hp").split("-");
				dto.setHp1(hp[0]);
				dto.setHp2(hp[1]);
				dto.setHp3(hp[2]);
				
				String[] email=rs.getString("email").split("@");
				dto.setEmail1(email[0]);
				dto.setEmail2(email[1]);
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(conn, pstmt, rs);
		}
		
		return dto;
	}
	
	//수정 ( 이름, 핸드폰, 이메일, 주소만 수정 )
	public void updateMember(MemberDto dto) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		String sql="update member set name=?,hp=?,email=?,address=?,addrdetail=? where num=? ";
		conn=db.getMyConnection();
		
		try {
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getHp1()+"-"+dto.getHp2()+"-"+dto.getHp3());
			pstmt.setString(3, dto.getEmail1()+"@"+dto.getEmail2());
			pstmt.setString(4, dto.getAddress());
			pstmt.setString(5, dto.getAddrdetail());
			pstmt.setString(6, dto.getNum());
			
			pstmt.execute();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(conn, pstmt);
		}
	}
	
	
	
	//아이디에 해당하는 비번이 맞으면 true반환, 아니면 false.
		public boolean isIdPassCheck(String id,String pass) {
			MemberDto dto=new MemberDto();
			boolean find=false;
			Connection conn=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			String sql="select * from member where id=? and pass=?";
			conn=db.getMyConnection();
			
			try {
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setString(2, pass);
				
				rs=pstmt.executeQuery();
				if(rs.next()) {
					find=true;
				
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				db.dbClose(conn, pstmt, rs);
			}
			
			return find;
		}
		
		//삭제하는 메서드
		public void deleteMemger(String id) {
			Connection conn=null;
			PreparedStatement pstmt=null;
			
			String sql="delete from member where id=?";
			
			conn=db.getMyConnection();
			
			try {
				pstmt=conn.prepareStatement(sql);
				
				pstmt.setString(1, id);
				
				pstmt.execute();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				db.dbClose(conn, pstmt);
			}
			
		}
		
		//로그인시 필요한 메서드
		public int loginProcess(String id, String pass) {
			int ans=0;
			if(this.isIdSearch(id)) {
				//아이디가 존재하는 경우
				//비번이 맞는지 체크하기
				if(this.isIdPassCheck(id, pass)) {
					ans=3;
				}else {
					ans=2;
				}
				
			}else {//아이디가 아예 존재하지 안흔ㄴ 경우
				ans=1;
			}
			return ans;
		}
		
		//아이디로 이름 찾기
		public String getName(String id){
			String name="";
			Connection conn=null;
			PreparedStatement pstmt=null;
			ResultSet rs = null;
			String sql="select name from member where id=?";
			
			conn=db.getMyConnection();
			
			try {
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, id);
				
				rs=pstmt.executeQuery();
				if(rs.next()) {
					name = rs.getString("name");
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				
				db.dbClose(conn, pstmt, rs);
				
			}
			
			return name;
		}
		
		public String getNum(String id)
		{
			String num="";
			Connection conn=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			String sql="select num from member where id=?";

			conn=db.getMyConnection();
			try {
				pstmt=conn.prepareStatement(sql);
				//���ε�
				pstmt.setString(1, id);
				rs=pstmt.executeQuery();
				if(rs.next())
					num=rs.getString("num");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				db.dbClose(conn, pstmt, rs);
			}
			return num;
		}

	
}
