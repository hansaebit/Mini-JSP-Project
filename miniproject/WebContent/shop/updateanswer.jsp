<%@page import="data.dao.ShopAnswerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

	String idx=request.getParameter("idx");
	String answer=request.getParameter("answer");
	
	ShopAnswerDao dao=new ShopAnswerDao();
	
	dao.updateShopAnswer(idx, answer);
	
	
%>