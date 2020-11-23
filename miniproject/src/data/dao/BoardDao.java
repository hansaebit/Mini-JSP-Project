package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import data.dto.BoardDto;
import mysql.db.MysqlConnect;

public class BoardDao {
	MysqlConnect db=new MysqlConnect();
	
	//num의 max값 구해서 리턴(null일 경우 0리턴)
	public int getMaxNum() {
		int max=0;
		String sql="select ifnull(max(num),0) max from board;"; //if max(num)이 null일 때 0
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		//mysql 서버 연결
		conn=db.getGangsaConnection();
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
	
	//데이터 추가시 같은 그룹 중 전달받은 step보다 큰 값을 가진 데이터들은 restep을 무조건 +1을 한다.
	public void updateRestep(int regroup,int restep) {
		String sql="update board set restep=restep+1 where regroup=? and restep>?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		conn=db.getGangsaConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, regroup);
			pstmt.setInt(2, restep);
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(conn, pstmt);
		}
	}
	
	//insert 제일 중요한건 이게 새글로 추가를 할 것인지, 답글로 추가를 할 것인지이다.
	//그래서 판단을 dto에 들어있는 num이 null이면 새글로 null이 아니면 답글로 insert를 할 것이다.
	public void insertBoard(BoardDto dto) {
		String num=dto.getNum();
		int regroup=dto.getRegroup();
		int relevel=dto.getRelevel();
		int restep=dto.getRestep();
		String sql="insert into board (writer,subject,content,pass,regroup,relevel,restep,writeday) values (?,?,?,?,?,?,?,now())";
		if(num==null) {
			//새 글을 의미한다.
			regroup=this.getMaxNum()+1;
			relevel=0;
			restep=0;
		}else {
			//답글을 의미한다.
			//같은 그룹 중 restep이 전달받은 값보다 큰 경우 무조건 1증가
			this.updateRestep(regroup, restep);
			//그리고 전달받은 level,step을 1증가한다.
			relevel+=1;
			restep+=1;
		}
		Connection conn=null;
		PreparedStatement pstmt=null;		
		conn=db.getGangsaConnection();		
		try {
			pstmt=conn.prepareStatement(sql);
			//바인딩
			pstmt.setString(1, dto.getWriter());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getPass());
			//여기부터 주의
			pstmt.setInt(5, regroup);
			pstmt.setInt(6, relevel);
			pstmt.setInt(7, restep);
			//실행
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(conn, pstmt);
		}
	}
	
	//내용보기시 조회수 1증가를 해야하므로
	public void updateReadcount(String num) {
		String sql="update board set readcount=readcount+1 where num=?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		conn=db.getGangsaConnection();
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
	
	//내용보기
	public BoardDto getData(String num) {
		String sql="select * from board where num=?";
		BoardDto dto=new BoardDto();
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		conn=db.getGangsaConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, num);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				dto.setNum(rs.getString("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setRegroup(rs.getInt("regroup"));
				dto.setRelevel(rs.getInt("relevel"));
				dto.setRestep(rs.getInt("restep"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setWriteday(rs.getTimestamp("writeday"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.dbClose(conn, pstmt, rs);
		}
		return dto;
	}
	
	//목록 페이징처리
	public List<BoardDto> getList(int start,int perpage){ //시작, 몇개씩 볼지 (mysql)
		//그룹변수의 내림차순, 같은 그룹인 경우 step의 오름차순 출력.
		//limit으로 시작번지와 몇개를 가져올지 바인딩.
		String sql="select * from board order by regroup desc, restep asc limit ?,?";
		List<BoardDto> list=new ArrayList<BoardDto>();
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		conn=db.getGangsaConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, perpage);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				BoardDto dto=new BoardDto();
				dto.setNum(rs.getString("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setRegroup(rs.getInt("regroup"));
				dto.setRelevel(rs.getInt("relevel"));
				dto.setRestep(rs.getInt("restep"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setWriteday(rs.getTimestamp("writeday"));
				//list에 추가
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.dbClose(conn, pstmt, rs);
		}
		return list;
	}
	
	//전체 갯수 구하기
	public int getTotalCount() {
		int tot=0;
		String sql="select count(*) from board;"; //if max(num)이 null일 때 0
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		//mysql 서버 연결
		conn=db.getGangsaConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next())
				tot=rs.getInt(1); //컬럼 순번으로 읽어오기.
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(conn, pstmt, rs);
		}
		return tot;
	}
	
	//비번이 맞지 않을 경우 true 반환
	public boolean isEqualPass(String num,String pass) {
		boolean flag=false;
		String sql="select count(*) from board where num=? and pass=?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		conn=db.getGangsaConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, num);
			pstmt.setString(2, pass);
			rs=pstmt.executeQuery();
			if(rs.next())
				if(rs.getInt(1)==1)//비번이 맞으면 1, 틀리면 0(count)
				flag=true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(conn, pstmt);
		}
		return flag;
	}
	
	//수정
	public void updateBoard(BoardDto dto) {
		String sql="update board set writer=?,subject=?,content=? where num=?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		conn=db.getGangsaConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			//바인딩
			pstmt.setString(1, dto.getWriter());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getNum());
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(conn, pstmt);
		}
		
	}
	
	//삭제
	public void deleteBoard(String num) {
		String sql="delete from board where num=?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		conn=db.getGangsaConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			//바인딩
			pstmt.setString(1, num);
			
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(conn, pstmt);
		}
	}
	//원글이 있는지 검사 - 있을 경우 true
	public boolean isGroupStep(int regroup) {
		boolean flag=false;
		String sql="select * from board regroup=? and restep=0";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		conn=db.getGangsaConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, regroup);
			rs=pstmt.executeQuery();
			//데이터가 있을 경우 true
			if(rs.next())
				flag=true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(conn, pstmt);
		}
		return flag;
	}
	
}
