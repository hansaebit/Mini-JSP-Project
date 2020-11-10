<%@page import="data.dto.MoneyDto"%>
<%@page import="data.dao.MoneyDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
	MoneyDao dao = new MoneyDao();
	MoneyDto dto = new MoneyDto();
	
	String num = request.getParameter("num");
	
	dto = dao.findMoney(num);
	
	

%>
</head>
<body>
<form action="money/moneyupdateaction.jsp ">
<input type="hidden" value="<%=dto.getNum() %>" name="num">
<table class="table table-bordered" style="width:300px;">
	<tr>
		<td>
			품목
		</td>
		<td>
			<input type="text" name="pummok" id="pummok" value="<%=dto.getPummok()%>">
		</td>
	</tr>
	<tr>
		<td>
			가격
		</td>
		<td>
			<input type="text" name="price" id="price" value="<%=dto.getPrice()%>">
		</td>
	</tr>
	<tr>
		<td>
			날짜
		</td>
		<td>
			<input type="date" name="day" id="day" value="<%=dto.getDay()%>">
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<button type="submit">입력</button>
		</td>
		
	</tr>
	
</table>
</form>
</body>
</html>