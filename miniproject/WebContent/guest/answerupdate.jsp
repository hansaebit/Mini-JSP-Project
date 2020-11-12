<%@page import="data.dao.AnswerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String idx=request.getParameter("idx");
	String memo=request.getParameter("memo");
	
	AnswerDao dao = new AnswerDao();
	
	dao.updateAnswer(idx, memo);

%>