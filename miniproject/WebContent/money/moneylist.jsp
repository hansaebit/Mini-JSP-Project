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

<button type=button id="btnadd">추가</button>
<button type=button id="btnupdate">수정</button>


<%
	MoneyDao dao = new MoneyDao();

	List<MoneyDto> list = dao.moneylist();
	
	
	
%>


</body>
<script type="text/javascript">
$(document).on('click','#btnadd',function(){
	window.open("money/moneyform.jsp","","left=100px,top=100px,width=400px,height=250px");
	
});
$(document).on('click','#btnupdate',function(){
	window.open("money/moneyupdateform.jsp","","left=100px,top=100px,width=400px,height=250px");
	
});
</script>
</html>