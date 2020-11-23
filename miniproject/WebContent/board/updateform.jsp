<%@page import="data.dto.BoardDto"%>
<%@page import="data.dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	String num=request.getParameter("num");
	String pageNum=request.getParameter("pageNum");
	BoardDao dao=new BoardDao();
	BoardDto dto=new BoardDto();
	dto=dao.getData(num);
	
	String writer=dto.getWriter();
	String subject=dto.getSubject();
	String content=dto.getContent();
%>
<body>
<div id="wrap">
	<form action="board/updateformaction.jsp">
		<input type="hidden" name="num" value="<%=num %>">
		<input type="hidden" name="pageNum" value="<%=pageNum %>">
		<table class="table table-bordered" style="width:1000px;">
		 	<caption><b style="font-size:2em">수정하기</b></caption>
		 	<tr>
		 		<td>
		 			<input type="text" style="font-size:1.8em;" name="subject" value="<%=subject%>">
		 		</td>
		 	</tr>
		 	<tr>
		 		<td>
		 			<input type="text" style="font-size:1.8em;" name="writer" value="<%=writer%>">
		 		</td>
		 	</tr>
		 	<tr>
		 		<td style="vertical-align:top;">		 			
		 			<textarea style="width:990px; height:400px;" name="content"><%=content%></textarea>
		 		</td>
		 	</tr>
		 	<tr>
		 		<td style="font-size:1.5em; text-align:center;">
		 			<button type="submit" class="btn btn-primary btn-lg" style="width:120px;">수정하기</button>
		 		</td>
		 	</tr>
		</table>
	</form>
</div>
</body>
</html>