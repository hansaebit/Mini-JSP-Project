<%@page import="data.dao.ShopAnswerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String idx=request.getParameter("idx");


	ShopAnswerDao dao=new ShopAnswerDao();
	
	dao.deleteAnswer(idx);



%>