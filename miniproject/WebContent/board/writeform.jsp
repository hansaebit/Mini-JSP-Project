<%@page import="data.dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.ckeditor.com/ckeditor5/23.1.0/classic/ckeditor.js"></script>
<style type="text/css">
	div#wrap{
		display:flex;
		justify-content:center;
	}
	
</style>
</head>
<%
//답글일 경우 읽어야 할 값들 처리하기
String num=request.getParameter("num");
//새 글일 경우 null, 답글일 경우 원글의 num이 넘어온다.
String regroup="",relevel="",restep="",pageNum="",subject=""; //답글일 경우 페이지 넘버도 가져와야 한다.
//db선언
BoardDao db=new BoardDao();
if(num!=null){ //답글일 경우
	regroup=request.getParameter("regroup");
	relevel=request.getParameter("relevel");
	restep=request.getParameter("restep");
	pageNum=request.getParameter("pageNum");
	//답글일 경우 제목부분에 원글의 제목 출력하기
	subject="[답글]"+db.getData(num).getSubject();
}
%>
<body>
<div id="wrap">
	<div class="boardform">
		<form action="board/writeaction.jsp" method="post">
			<!-- hidden -->
			<%
			//답글일때만 hiden으로 넘어간다.
			if(num!=null){
				%>
				<input type="hidden" name="num" value="<%=num %>">
				<input type="hidden" name="regroup" value="<%=regroup %>">
				<input type="hidden" name="relevel" value="<%=relevel %>">
				<input type="hidden" name="restep" value="<%=restep %>">
				<input type="hidden" name="pageNum" value="<%=pageNum %>">
				<%
			}
			%>
			<table class="table table-bordered" style="width:1000px;">
				<caption><b style="font-size:2em;"><%=num==null?"새글등록":"답글등록" %></b></caption>
				<tr>
					<th style="width:130px;" bgcolor="#e6e6fa">작성자</th>
					<td>
						<input type="text" name="writer" style="width:800px;" class="form-control" required>
					</td>
				</tr>
				<tr>
					<th style="width:130px;" bgcolor="#e6e6fa" >제 목</th>
					<td>
						<input type="text" name="subject" style="width:800px;" class="form-control" required value="<%=subject %>">
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<textarea id="editor" style="width:990px; height:400px;" name="content" class="form-control"></textarea>
						<script>
					    // 3. CKEditor5를 생성할 textarea 지정
					    ClassicEditor
					        .create( document.querySelector( '#editor' ) )
					        .catch( error => {
					            console.error( error );
					        } );
					    </script>
					</td>
				</tr>
				<tr>
					<th style="width:130px;" bgcolor="#e6e6fa">비밀번호</th>
					<td>
						<input type="password" name="pass" style="width:120px;" class="form-control" required >
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<button type="submit" class="btn btn-success btn-lg">게시글 등록</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>
</body>
</html>