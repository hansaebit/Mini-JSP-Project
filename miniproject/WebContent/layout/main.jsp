<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	//프로젝트의 경로 구하기
	String url=request.getContextPath(); // 프로젝트 다음의 경로 구해줌. (경로 오류 최소화)
%>
<img src="<%=url %>/image/s10.JPG">
<img src="<%=url %>/image/s6.JPG">
</body>
</html>