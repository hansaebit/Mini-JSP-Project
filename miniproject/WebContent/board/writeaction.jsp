<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- useBean으로 dao,dto 선언 후 모든 데이터 읽기 -->
<%
request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="dao" class="data.dao.BoardDao"/>
<jsp:useBean id="dto" class="data.dto.BoardDto"/>
<jsp:setProperty property="*" name="dto"/>
<%
String subject=dto.getSubject().replace("<","&lt;").replace(">","&gt;");
dto.setSubject(subject);
//insert
dao.insertBoard(dto);
//insert된 num값 얻기
int num=dao.getMaxNum();
//페이지 번호 읽기
String pageNum=request.getParameter("pageNum");
if(pageNum==null)
	pageNum="1";
//content로 이동
String go="../index.jsp?main=board/content.jsp?num="+num+"&pageNum="+pageNum;
response.sendRedirect(go);
%>