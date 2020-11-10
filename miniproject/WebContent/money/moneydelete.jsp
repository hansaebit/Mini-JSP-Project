<%@page import="data.dao.MoneyDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	String num=request.getParameter("num");

	MoneyDao dao = new MoneyDao();
	
	dao.deleteMoney(num);
	%>


<script type="text/javascript">
	alert("삭제되었습니다.");
	
	location.href="index.jsp?main=money/moneylist.jsp";
</script>
	