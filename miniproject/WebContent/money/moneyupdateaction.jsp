<%@page import="data.dto.MoneyDto"%>
<%@page import="data.dao.MoneyDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	String num = request.getParameter("num");
	String price = request.getParameter("price");
	String pummok = request.getParameter("pummok");
	String day = request.getParameter("day");
	
	MoneyDto dto = new MoneyDto();
	
	dto.setDay(day);
	dto.setNum(num);
	dto.setPrice(price);
	dto.setPummok(pummok);
	
	
	MoneyDao dao = new MoneyDao();
	
	dao.updateMoney(dto);

%>

<script type="text/javascript">
	alert("수정되었습니다.")
	location.href="../index.jsp?main=money/moneylist.jsp";

</script>