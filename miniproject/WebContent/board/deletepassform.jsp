<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#wrap{
		display:flex;
		justify-content:center;
		align-items:center;
		height:600;
	}
</style>
</head>
<%
	String num=request.getParameter("num");
	String pageNum=request.getParameter("pageNum");
%>
<body>
<div id="wrap">
	<form action="board/deletepassaction.jsp" class="updatepass" >
		<input type="hidden" name="num" value="<%=num %>">
		<input type="hidden" name="pageNum" value="<%=pageNum %>">
		
		<input type="password" name="inputpass">
		<button type="submit">삭제하기</button>
	</form>
</div>
</body>
</html>