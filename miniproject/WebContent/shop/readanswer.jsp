<%@page import="data.dto.ShopAnswerDto"%>
<%@page import="data.dao.ShopAnswerDao"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String myid=request.getParameter("myid");
	String shopnum=request.getParameter("shopnum");
	String content=request.getParameter("content");
	
	ShopAnswerDao dao=new ShopAnswerDao();
	ShopAnswerDto dto=new ShopAnswerDto();
	
	dto.setMyid(myid);
	dto.setShopnum(shopnum);
	dto.setContent(content);
	
	dao.insertAnswer(dto);
%>



