<%@page import="data.dto.DataBoardDto"%>
<%@page import="data.dao.DataBoardDao"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//파일을 저장할 폴더
	String savePath=getServletContext().getRealPath("/datasave"); //서버에 들어있는 경로
	//업로드할 사이즈
	int uploadSize=1024*1024*3;// 3mb
	MultipartRequest multi=null;
	try{
		multi=new MultipartRequest(request,savePath,uploadSize,"utf-8",new DefaultFileRenamePolicy());
		String myid=multi.getParameter("myid");
		String subject=multi.getParameter("subject");
		//html 태그 입력시 텍스트로 보이게 하기
		subject=subject.replace("<","&lt;").replace(">","&gt;");
		String content=multi.getParameter("content");
		//html 태그 입력시 텍스트로 보이게 하기
		content=content.replace("<","&lt;").replace(">","&gt;");
		String files="";
		//파일은 파일타입의 name들을 먼저 얻은 후 반복하여 파일명을 얻는다.
		Enumeration en=multi.getFileNames();
		while(en.hasMoreElements()){
			String tagName=en.nextElement().toString();
			//실제 업로드된 파일명
			String fileName=multi.getFilesystemName(tagName);
			//파일 선택을 안한 경우는 null이므로 빼고 처리.
			if(fileName!=null){
				files+=fileName+",";
			}
		}
		//마지막 컴마 제거
		if(files.length()>0)
			files=files.substring(0,files.length()-1);
		else
			files="no"; //파일을 업로드하지 않은 경우
		System.out.println(savePath);
			
		//dao 선언
		DataBoardDao dao=new DataBoardDao();
		//dto 에 넣기
		DataBoardDto dto=new DataBoardDto();
		dto.setMyid(myid);
		dto.setSubject(subject);
		dto.setFiles(files);
		dto.setContent(content);
		//insert
		dao.insertBoard(dto);
		//목록으로 이동
		response.sendRedirect("../index.jsp?main=databoard/databoardlist.jsp");
	}catch(Exception e){
		System.out.println("업로드 오류:"+e.getMessage());
	}
	
%>