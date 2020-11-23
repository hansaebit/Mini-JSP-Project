<%@page import="data.dto.BoardDto"%>
<%@page import="data.dao.BoardDao"%>
<%@page import="data.dao.ShopDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	String num=request.getParameter("num");
	String pageNum=request.getParameter("pageNum");
	String pass=request.getParameter("inputpass");
	
	
	BoardDao dao=new BoardDao();

	
	boolean flag=dao.isEqualPass(num, pass);
	
	if(flag){
		//비번이 맞을 경우 삭제 후 목록 보던 페이지로 이동.
		dao.deleteBoard(num);
		String go="../index.jsp?main=board/boardlist.jsp?&pageNum="+pageNum;
		response.sendRedirect(go);
	}else{
		%>
		<script>
		alert("비밀번호가 맞지 않습니다.");
		
		history.back();
		</script>
		<%
		
	}
	
%>