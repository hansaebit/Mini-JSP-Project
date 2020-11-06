<%@page import="data.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%-- 자바빈즈로 쉽게 가져오기 --%>

<%
	request.setCharacterEncoding("utf-8");

%>
<!-- 생성자와 같다. -->
<jsp:useBean id="dao" class="data.dao.MemberDao"/>
<jsp:useBean id="dto" class="data.dto.MemberDto"/>
<!-- 전체 데이터 읽어서 dto에 넣기 -->
<jsp:setProperty property="*" name="dto"/>
<%

	//메서드 호출
	dao.insertMember(dto);
	//success페이지로 이동
	response.sendRedirect("../index.jsp?main=member/successpage.jsp");
%>