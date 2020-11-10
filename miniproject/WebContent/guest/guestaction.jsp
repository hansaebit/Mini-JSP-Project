<%@page import="data.dao.GuestDao"%>
<%@page import="data.dto.GuestDto"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//업로드할 save폴더의 실제 서버에서의 위치 구하기.
	String realPath=getServletContext().getRealPath("/save");
	System.out.println(realPath);
	//업로드할 이미지의 크기 제한
	int uploadSize=1024*1024*2; //2mb
	
	MultipartRequest multi=null;
	try{
		multi=new MultipartRequest(request,realPath,uploadSize,"utf-8",new DefaultFileRenamePolicy());
		//입력한 데이터 읽기
		
		String myid=multi.getParameter("myid");
		//업로드한 이미지인데 안할경우 null
		String photo=multi.getFilesystemName("photo");
		System.out.println("photo="+photo);
		String content=multi.getParameter("content");
		
		//dto에 넣기
		GuestDto dto=new GuestDto();
		dto.setMyid(myid);
		dto.setPhoto(photo==null?"no":photo);
		dto.setContent(content);
		
		//dao 선언
		GuestDao dao = new GuestDao();
		
		//메서드 호출
		dao.insertGuest(dto);
		//방명록 페이지로 이동
		response.sendRedirect("../index.jsp?main=guest/guestlist.jsp");
		
	}catch(Exception e){
		System.out.println("업로드 오류 : "+e.getMessage());
	}

%>