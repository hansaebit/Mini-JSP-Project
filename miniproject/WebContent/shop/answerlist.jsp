<?xml version="1.0" encoding="UTF-8"?>
<%@page import="data.dao.MemberDao"%>
<%@page import="java.util.List"%>
<%@page import="data.dto.ShopAnswerDto"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="data.dao.ShopAnswerDao"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8"%>
<list>
<%
	//dao 선언
	ShopAnswerDao dao=new ShopAnswerDao();
	//목록 가져오기
	String shopnum=request.getParameter("shopnum");
	List<ShopAnswerDto> list=dao.getAnswerList(shopnum);
	//날짜 포멧 형식
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
	//멤버 dao 선언
	MemberDao mdao=new MemberDao();
	//반복문
	for(ShopAnswerDto dto:list){
	%>
		<answer>
			<idx><%=dto.getIdx() %></idx>
			<myid><%=dto.getMyid() %></myid>
			<name><%=mdao.getName(dto.getMyid()) %></name>
			<content><%=dto.getContent() %></content>
			<shopanswer><%=dto.getShopanswer() %></shopanswer>
			<writeday><%=sdf.format(dto.getWriteday()) %></writeday>
		</answer>	
	<%}
%>
</list>