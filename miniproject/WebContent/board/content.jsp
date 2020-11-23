<%@page import="java.text.SimpleDateFormat"%>
<%@page import="data.dto.BoardDto"%>
<%@page import="data.dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://fonts.googleapis.com/css2?family=Single+Day&display=swap" rel="stylesheet">
<style type="text/css">
	#wrap{
		display:flex;
		justify-content:center;
	}
	
</style>
</head>
<%
String num=request.getParameter("num");
String pageNum=request.getParameter("pageNum");
//목록에서 제목을 누를 경우에만 어떤 값을 보낼 것임
//목록으로부터 왔을때만 조회수를 증가하기 위한 값
//목록으로부터 올 때 말고는 null값이 넘어온다.
String key=request.getParameter("key");

BoardDao dao=new BoardDao();
//목록에서 넘어온 경우에는 조회수 1 증가
if(key!=null){
	dao.updateReadcount(num);
}
//dto 얻기
BoardDto dto=dao.getData(num);
//날짜 출력에 대한 포멧
SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");

%>
<body>
<div id="wrap">
	<div class="boardcontent">
		<table class="table table-bordered" style="width:1000px;">
		 	<caption><b style="font-size:2em">내용 확인</b></caption>
		 	<tr>
		 		<td>
		 			<b style="font-size:1.8em;word-break:break-all;"><%=dto.getSubject() %></b>
		 			<span style="float:right;color:gray;:font-sixe:0.8em;">
		 			<%=sdf.format(dto.getWriteday()) %></span>
		 		</td>
		 	</tr>
		 	<tr style="height:180px;">
		 		<td style="vertical-align:top;">		 			
		 			<pre style="background-color:white; font-size:1.6em; font-family:'굴림'; border:none;white-space:pre-wrap;
					word-wrap:break-word;width: 900px;"><%=dto.getContent() %></pre>
		 		</td>
		 	</tr>
		 	<tr>
		 		<td style="font-size:1.5em;">
		 			조회 <%=dto.getReadcount() %>
		 			<br>
		 			<!-- 버튼들 -->
		 			<div style="float:right;">
		 			<button type="button" class="btn btn-primary btn-sm" onclick="location.href='index.jsp?main=board/writeform.jsp'" style="width:80px;">새글</button>
		 			
		 			<button type="button" class="btn btn-primary btn-sm" onclick="location.href='index.jsp?main=board/boardlist.jsp?pageNum=<%=pageNum%>'" style="width:80px;">목록</button>
		 			
		 			<!-- regroup relevel restep num pagenum -->
		 			
		 			<button type="button" class="btn btn-primary btn-sm" onclick="location.href='index.jsp?main=board/writeform.jsp?num=<%=num%>&regroup=<%=dto.getRegroup()%>&relevel=<%=dto.getRelevel()%>&restep=<%=dto.getRestep()%>&pageNum=<%=pageNum%>'" style="width:80px;">답글</button>
		 			
		 			<button type="button" class="btn btn-primary btn-sm" onclick="location.href='index.jsp?main=board/updatepassform.jsp?num=<%=num%>&pageNum=<%=pageNum%>'" style="width:80px;"><span class="glyphicon glyphicon-edit"></span>&nbsp;수정</button>
		 			
		 			<button type="button" class="btn btn-primary btn-sm" onclick="location.href='index.jsp?main=board/deletepassform.jsp?num=<%=num%>&pageNum=<%=pageNum%>'" style="width:80px;">&nbsp;삭제</button>
		 			
		 			</div>
		 		</td>
		 	</tr>
		</table>
	</div>
</div>
</body>
<script type="text/javascript">


</script>
</html>