<%@page import="data.dto.BoardDto"%>
<%@page import="data.dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	/* 
	
	String pageNum=request.getParameter("pageNum");
	<jsp:useBean id="dao" class="data.dao.BoardDao"/>
	<jsp:useBean id="dto" class="data.dao.BoardDto"/>
	<jsp:setProperty property="*" name="dto"/>
	
	String subject=dto.getSubject().replace("<","&lt;").replace(">","&gt;");
	dto.setSubject(subject);

	dao.updateBoard(dto);
	
	String go="../index.jsp?main=board/content.jsp?num="+num+"&pageNum="+pageNum;
	response.sendRedirect(go);
	
	*/

	
	String num=request.getParameter("num");
	String pageNum=request.getParameter("pageNum");
	String writer=request.getParameter("writer");
	String subject=request.getParameter("subject");
	String content=request.getParameter("content");
	subject=subject.replace("<","&lt;").replace(">","&gt;");
	
	BoardDao dao=new BoardDao();
	BoardDto dto=new BoardDto();
	dto.setNum(num);
	dto.setWriter(writer);
	dto.setSubject(subject);
	dto.setContent(content);
	dao.updateBoard(dto);
	
	String go="../index.jsp?main=board/content.jsp?num="+num+"&pageNum="+pageNum;
	response.sendRedirect(go);

%>