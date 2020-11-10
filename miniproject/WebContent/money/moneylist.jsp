<%@page import="java.text.NumberFormat"%>
<%@page import="data.dto.MoneyDto"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.MoneyDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<button type=button id="btnadd" onclick="location.href='index.jsp?main=money/moneyform.jsp'">추가</button>


<%
	MoneyDao dao = new MoneyDao();
	String sum = dao.allMoney();
	List<MoneyDto> list = dao.moneylist();
	
	%>
	<table class="table table-bordered" style="width:500px;">
		<tr>
			<td>Num</td><td>pummok</td><td>price</td><td>day</td><td>비고</td>
		</tr>
	<%
	for(MoneyDto dto:list){
		%>	
				<tr>
					<td><%=dto.getNum() %></td><td><%=dto.getPummok() %></td><td><%=dto.getPrice()%></td><td><%=dto.getDay() %></td>
					<td>
					<button type="button" value="<%=dto.getNum()%>" onclick="location.href='index.jsp?main=money/moneyupdateform.jsp?num=<%=dto.getNum() %>'">수정</button>
					<button type="button" value="<%=dto.getNum()%>" onclick="location.href='index.jsp?main=money/moneydelete.jsp?num=<%=dto.getNum() %>'">삭제</button>
					</td>
				</tr>
			
		
		<%
	}
	
%>
<tr><td colspan='5' style='text-align:right;'>총 금액은 <%=sum %>원 입니다.</td></tr>
</table>

</body>
</html>