<%@page import="data.dao.MoneyDao"%>
<%@page import="data.dto.MoneyDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	String pummok = request.getParameter("pummok");
	String price = request.getParameter("price");
	String day = request.getParameter("day");
	
	MoneyDto dto = new MoneyDto();
	MoneyDao dao = new MoneyDao();
	
	dto.setPummok(pummok);
	dto.setPrice(price);
	dto.setDay(day);
	
	dao.addMoney(dto);
	response.sendRedirect("../index.jsp?main=money/moneylist.jsp");
%>