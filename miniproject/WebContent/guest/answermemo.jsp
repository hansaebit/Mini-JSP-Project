<?xml version="1.0" encoding="UTF-8"?>
<%@page import="data.dao.AnswerDao"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String idx = request.getParameter("idx");
	AnswerDao dao = new AnswerDao();
	String memo = dao.getMemo(idx);
%>

<memo>
<%=memo%>
</memo>