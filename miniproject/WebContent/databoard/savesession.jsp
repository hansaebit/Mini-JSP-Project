<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String search=request.getParameter("search");
String word=request.getParameter("word");

//session에 key, value로 저장
session.setAttribute("key", search);
session.setAttribute("value", word);


%>