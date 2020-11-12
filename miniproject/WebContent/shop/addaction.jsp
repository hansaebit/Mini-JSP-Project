<%@page import="data.dto.ShopDto"%>
<%@page import="data.dao.ShopDao"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	//업로드할 경로 구하기(shopsave폴더 생성 후 거기에 업로드)
	String uploadPath=getServletContext().getRealPath("/shopsave");
	System.out.println(uploadPath);
	//업로드할 이미지의 사이즈
	int uploadSize=1024*1024*2; // 2mb
	
	MultipartRequest multi=null;
	try{
		multi=new MultipartRequest(request,uploadPath,uploadSize,"utf-8",new DefaultFileRenamePolicy());
		String sangpum=multi.getParameter("sangpum");
		String color=multi.getParameter("color");
		String category=multi.getParameter("category");
		String ipgoday=multi.getParameter("ipgoday");
		int price=Integer.parseInt(multi.getParameter("price"));
		//여러개의 이미지명을 가져오는데 여러개일 경우 ,로 연결
		String photo="";
		//file타입인 요소만 name을 얻는다.
		Enumeration en=multi.getFileNames();
		while(en.hasMoreElements()){
			String name=(String)en.nextElement();
			//name에 들어가있는 이미지명 가져오기
			String fileName=multi.getFilesystemName(name);
			//System.out.println(name+":"+fileName);
			if(fileName!=null){
				if(photo.length()==0)
					photo=fileName;
				else
					photo+=","+fileName;
			}
		}
		//System.out.println(photo);
		
		//dao 선언 하고 
		ShopDao dao=new ShopDao();
		//dto에 데이터 넣기
		ShopDto dto=new ShopDto();
		dto.setSangpum(sangpum);
		dto.setCategory(category);
		dto.setColor(color);
		dto.setIpgoday(ipgoday);
		dto.setPhoto(photo);
		dto.setPrice(price);
		//db에 추가
		dao.insertShop(dto);
		
		//다시 상품폼으로 이동
		response.sendRedirect("../index.jsp?main=shop/addform.jsp");
	}catch(Exception e){
		System.out.println("업로드 오류:" + e.getMessage());
	}
	



%>