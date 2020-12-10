<%@page import="data.dto.SmartBoardDto"%>
<%@page import="data.dao.SmartBoardDao"%>
<%@page import="java.io.File"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<style type="text/css">
	#cl-dashboard{display: none;}
	
</style>
</head>
<body>
<%
	String num=request.getParameter("num");	
	String pageNum=request.getParameter("pageNum");
	String key=request.getParameter("key");
	
	//key 값이 널값이 아니면서 'list' 일경우 
	//(이유:수정후에도 content.jsp 로 오기때문에 목록에서
    //			올 경우에만 증가함)
	//조회수 증가
	SmartBoardDao db=new SmartBoardDao();
	if(key!=null && key.equals("list"))
		db.updateReadcount(num);
	
	//번호에 해당하는 dto 가져오기
	SmartBoardDto dto=db.getData(num);
	
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>	
<table class="table table-striped" style="width: 500px;">
	<tr>
		<td width="350">
			<b><%=dto.getSubject()%></b>
		</td>
		<td>
			<span style="color: #ccc;font-size: 9pt;">
			<%=sdf.format(dto.getWriteday()) %></span>
		</td>
	</tr>
	<tr height="350">
		<td colspan="2" valign="top">
			<b><%=dto.getName()%></b>
			<br><br>			
			<pre><%=dto.getContent()%></pre>	
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<span style="color: gray;font-size: 9pt;">
			조회수&nbsp; <%=dto.getReadcount() %>
			</span>			
		</td>
	</tr>
	<tr>
		<td colspan="2" align="right">
			<input type="button" class="btn btn-default btn-xs"
			  value="글쓰기" style="width: 60px;"
			  onclick="location.href='index.jsp?main=smartboard/smartform.jsp'">
			<input type="button" class="btn btn-default btn-xs"
			  value="글목록" style="width: 60px;"
			  onclick="location.href='index.jsp?main=smartboard/smartlist.jsp?pageNum=<%=pageNum%>'">			
		</td>
	</tr>	
</table>
</body>
</html>




