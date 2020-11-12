<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	//한글 엔코딩
	request.setCharacterEncoding("utf-8");
	//pageNum 읽기
	String pageNum=request.getParameter("pageNum");
%>

<!-- useBean dto,dao 선언 -->
	<jsp:useBean id="dto" class="data.dto.AnswerDto"/>
	<jsp:useBean id="dao" class="data.dao.AnswerDao"/>
<!-- dto에 데이터 읽어서 넣기 : setProperty -->
	<jsp:setProperty property="*" name="dto"/>
<%
	//insert 메소드 호출
	dao.insertAnswer(dto);
	
	//guestlist로 가는데 보던 페이지로 이동해야 한다.
	String go="../index.jsp?main=guest/guestlist.jsp?pageNum="+pageNum;
	response.sendRedirect(go);

%>
