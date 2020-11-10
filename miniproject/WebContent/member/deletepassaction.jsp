<%@page import="data.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//id와 pass를 읽는다.
	String id=request.getParameter("id");
	String pass=request.getParameter("pass");
	
	//dao 선언
	MemberDao dao = new MemberDao();
	//비번이 맞는지 isIdPassCheck 호출( 변수 find)
	
	
	boolean find = dao.isIdPassCheck(id, pass);
	
	
	
	
	//find가 false면 스크립트로 '비밀번호가 틀렸습니다.' 경고 후 이전페이지
	if(find==false){
		%>
		<script type="text/javascript">
		alert("비밀번호가 틀렸습니다.");
		history.back();
		</script>
<%
	}else{
		dao.deleteMemger(id);
		response.sendRedirect("../index.jsp?main=member/memberlist.jsp");
	}
	//true 면 삭제메서드 호출 후 멤버목록으로 이동.

%>