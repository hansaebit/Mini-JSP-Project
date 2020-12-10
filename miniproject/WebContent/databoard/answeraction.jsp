<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="dao" class="data.dao.DataBoardDao"/>
<jsp:useBean id="dto" class="data.dto.DataAnswerDto"/>
<jsp:setProperty property="*" name="dto"/>
<%
	String pageNum=request.getParameter("pageNum");
	
	dao.insertAnswer(dto);
	
	//아이들 맨 뒤에 주면 그쪽으로 이동하게 됨.
	String go="../index.jsp?main=databoard/content.jsp?num="+dto.getNum()
		+"&pageNum="+pageNum+"#dataanswerlist";
	response.sendRedirect(go);
%>
	
	