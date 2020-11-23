<%@page import="data.dao.MemberDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="data.dto.DataBoardDto"%>
<%@page import="data.dao.DataBoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	div.filedownload{
		width:550px;
		height: 70px;
		line-height: 70px;
		border: 1px solid gray;
		border-radius: 10px;
	}
</style>
</head>
<%
	//데이터 읽기
	String num=request.getParameter("num");
	String pageNum=request.getParameter("pageNum");
	String key=request.getParameter("key");
	//dao 선언
	DataBoardDao dao=new DataBoardDao();
	//목록에서 온 경우에만 조회수 1증가
	if(key!=null)
		dao.updateReadCount(num);
	DataBoardDto dto=dao.getData(num);
	//파일은배열 형태로 분리
	String[] files=dto.getFiles().split(",");
	//자료가 있는 path 구하기
	String path=getServletContext().getRealPath("/datasave");
	//출력할 날짜 형식
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	//작성자 이름 가져오기
	MemberDao mdao=new MemberDao();
	String name=mdao.getName(dto.getMyid());
%>
<body>
<div class="datacontent">
	<table class="table table-borderd" style="width:600px;">
		<caption><b>내용 확인</b></caption>
		<tr>
			<td>
				<b style="font-size:2em;"><%=dto.getSubject() %></b>
				<span style="color:gray;font-size:0.9em;float:right;"><%=sdf.format(dto.getWriteday()) %></span>
				<br>
				<span><%=name %></span>
				<span style="margin-left:20px;">조회<%=dto.getReadcount() %></span>
			</td>
		</tr>
		<tr>
			<td>
				<pre class="content"><%=dto.getContent() %></pre>
				<br><br>
				<%
				String ext="jpg,jpeg,png,gif";
				for(String myfile:files){
					//확장자 얻기
					int dot=myfile.indexOf(".");//.의 번지 찾기
					String fileExt=myfile.substring(dot+1);//도트 다음번지부터 끝까지 추출.
					//파일 확장자가 이미지 확장자일 경우에만 출력하기
					if(ext.contains(fileExt.toLowerCase())){
						//이미지가 톰켓서버에 존재할 경우에만 출력
						if(dto.isFile(path, myfile)){
							%>
								<img src="datasave/<%=myfile %>" style="max-width:200px; display:inline-block;">
								<br>
							<%
						}
					}
				}
				%>
				<br><br>
				<!-- 다운로드 톰캣서버에 있는 경우에만 다운로드 가능 -->
				<%
				if(!dto.getFiles().equals("no")){
				for(String myfile:files){%>
					<div class="filedownload">
					<%if(dto.isFile(path, myfile)){%>
						<a href="download?clip=<%=myfile%>">
						<%=myfile %>
						<span class="glyphicon glyphicon-download-alt"></span>
						</a>
					<%}else{
						%>
						<%=myfile %>
						<span style="color:red;">서버에 파일이 존재하지 않습니다. </span>
						<%
					}%>
					</div>
				<%}
				}
				%>
			</td>
		</tr>
		</table>
</div>
</body>
</html>