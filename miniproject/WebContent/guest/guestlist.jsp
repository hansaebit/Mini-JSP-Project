<%@page import="data.dao.GuestDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
	GuestDao dao = new GuestDao();
%>
</head>
<body>
<jsp:include page="guestform.jsp"/>
<hr width="1000" align="left" style="height:10px; background-color:pink">
총 <%=dao.getTotalCount() %> 개의 글이 있습니다.
</body>
</html>