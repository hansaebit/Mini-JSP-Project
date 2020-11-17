<%@page import="data.dao.ShopDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//idx 읽기
	String idx=request.getParameter("idx");

	ShopDao	dao = new ShopDao();

	dao.deleteCart(idx);




%>