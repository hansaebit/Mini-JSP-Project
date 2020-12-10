<%@page import="data.dto.SmartBoardDto"%>
<%@page import="data.dao.SmartBoardDao"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<style type="text/css">
	#cl-dashboard{display: none;}
	
</style>
</head>
<%
	SmartBoardDao db=new SmartBoardDao();
	
	MultipartRequest multi=null;
	String realFolder=getServletContext().getRealPath("/save");
	int uploadSize=1024*1024*2;
	
	try{
		multi=new MultipartRequest(request,realFolder,
				uploadSize,"utf-8",new DefaultFileRenamePolicy());
		String subject=multi.getParameter("subject");
		String name=multi.getParameter("name");
		String content=multi.getParameter("content");
		
		SmartBoardDto dto=new SmartBoardDto();
		dto.setContent(content);
		dto.setName(name);
		dto.setSubject(subject);
		
		db.insertSmart(dto);
		
		//최근 추가된 num 구하기
		int num=db.getMaxNum();
		String path="../index.jsp?main=smartboard/content.jsp?num="+num+"&pageNum=1";
		response.sendRedirect(path);
	}catch(Exception e){
		out.write("파일 업로드 오류:"+e.getMessage());
	}
%>
<body>

</body>
</html>





