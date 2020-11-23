<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	div.databoardform{
		display:flex;
		justify-content:center;
	}
</style>
</head>
<%
	String loginok=(String)session.getAttribute("loginok");
	String myid=(String)session.getAttribute("myid");
%>
<body>
<%
if(loginok==null){
	%>
	<script type="text/javascript">
		alert("자료를 업로드하려면 먼저 로그인을 해주세요.");
		history.back();
	</script>
	<%
}else{
%>
<div class="databoardform">
	<form action="databoard/datawriteaction.jsp" method="post" enctype="multipart/form-data" class="form-inline">
		<!-- hidden -->
		<input type="hidden" name="myid" value="<%=myid %>">
	
		<table class="table table-bordered" style="width: 1000px;">
			<caption><b>자료 업로드</b></caption>
			<tr>
				<td class="text-center" style="width:150px; background-color:#66cdaa;">
				<b>아이디</b>
				</td>
				<td>
				<%=myid %>
				</td>
			</tr>
				
			<tr>
				<td class="text-center" style="width: 150px;background-color:#66cdaa;">
				<b>제목</b>
				</td>	
				<td>
					<input type="text" name="subject" class="form-control" style="width:400px;" required>
				</td>
			</tr>
			
			<tr>
				<td class="text-center" style="width:150px;background-color:#66cdaa;">
				<b>업로드 파일</b>
				</td>
				
				<td>
					<div class="form-group">
						<input type="file" name="files1" style="width:300px;" class="form-control" >
						<span class="glyphicon glyphicon-plus-sign files" style="margin-left:20px; font-size:1.3em; cursor:pointer;"></span>
					</div>
					<div class="addfile"></div>
				</td>
			
			</tr>
			
			<tr>
				<td class="text-center" style="width: 150px;background-color:#66cdaa;line-height:500px;">
				<b>설 명</b>
				</td>	
				<td>
					<textarea name="content" required style="width:840px; height:500px;"></textarea>
				</td>
			</tr>
			
			<tr>
				<td colspan="2" align="center">
					<button type="submit" class="btn btn-info" style="width:100px">업로드하기</button>
					<button type="button" class="btn btn-info" style="width:100px" onclick="location.href='index.jsp?main=databoard/databoardlist.jsp'">자료실</button>
				</td>
			</tr>
			
			
		</table>
	</form>
</div>
<%} %>
</body>
<script type="text/javascript">
var n=2;
$(".files").click(function(){
	if(n>5){
		alert("파일은 5개까지만 등록 가능합니다.");
		return;
	}
	var tag="<input type='file' name='files"+(n++)+"' style='width:300px;' class='form-control'><br>";
	$("div.addfile").html(function(idx,html){
		return html+tag;
	});
});

</script>
</html>