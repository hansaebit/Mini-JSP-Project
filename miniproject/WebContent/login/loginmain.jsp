<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	//세션에서 로그인 상태를 알 수 있는 loginok 얻기
	String loginok=(String)session.getAttribute("loginok");
	if(loginok==null){
		%>
			<jsp:include page="loginform.jsp"/>
		<%
	}else{
		%>
			<jsp:include page="logoutform.jsp"/>
		<%
	}
%>