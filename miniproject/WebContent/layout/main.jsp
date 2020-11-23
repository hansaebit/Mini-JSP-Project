<%@page import="java.text.NumberFormat"%>
<%@page import="data.dto.BoardDto"%>
<%@page import="data.dto.ShopDto"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.ShopDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 10초마다 자동 새로고침 -->
<meta http-equiv="Refresh" content="60*10;url=index.jsp">
<title>Insert title here</title>
<style type="text/css">
	#container{
		display:flex;
		flex-flow:row wrap;
		justify-content:center;
		align-content: space-between;
		
	}
	
	div.main_sangpumlist,
	div.main_boardlist{
		left:100;
		top:100px;
		border:10px solid pink;
		border-radius:30px;
		width:45%;
		height:450px;
		margin: 0 10px 0 10px;
		
	}
	
	span.mainshop,
	span.mainboard{
		cursor:pointer;
		float:right;
		font-size:1.5em;
	}
	
	div.main_sangpumlist b,
	div.main_boardlist b{
		height:40px;
		line-height:30px;
		margin-left:10px;
	}
</style>

</head>
<body>
<div id="container">
	<div class="main_sangpumlist">
		<b>●&nbsp;상품 목록 게시판</b>
		<span class="mainshop glyphicon glyphicon-plus-sign"></span>
		
		<%
		//최신글 4개 가져오기
		ShopDao sdao=new ShopDao();
		List<ShopDto> list=sdao.getNewSangpums();
		%>
		<table class="table table-bordered">
			<%
			int i=0;
			NumberFormat nf=NumberFormat.getCurrencyInstance();
			for(int col=1;col<=2;col++){
				%>
				<tr>
					<%
					for(int row=1;row<=2;row++){
						ShopDto dto=list.get(i++);
						String photo=dto.getPhoto().split(",")[0];
					%>
						<td align="center">
							<a href="index.jsp?main=shop/detailpage.jsp?shopnum=<%=dto.getShopnum()%>">
								<img src="shopsave/<%=photo %>" style="width:150px; height:150px;"><br>
								<%=dto.getSangpum() %><br>
								<%=nf.format(dto.getPrice())%>
							</a>
					<%
					}
					%>
				</tr>
				<%
			}
			%>
		</table>
	</div>
	
	<div class="main_boardlist">
		<b>●&nbsp;게시판</b>
		<span class="mainboard glyphicon glyphicon-plus-sign"></span>
		<table class="table table-bordered">
			<tr>
				<th class="text-center">
				제목
				</th>
				<th class="text-center">
				작성자
				</th>
			</tr>
			<%
		//최신글 4개 가져오기
			List<BoardDto> boardlist=sdao.getNewBoard();
			for(BoardDto dto:boardlist){
			%>
			<tr>
				<td>
					<a href="index.jsp?main=board/content.jsp?num=<%=dto.getNum()%>&key=a">
						<%=dto.getSubject() %>
					</a>
				</td>
				<td>
					<%=dto.getWriter() %>
				</td>
			</tr>
			<%
		}
		%>
		</table>
	</div>
</div>
</body>
<script type="text/javascript">
$("span.mainshop").click(function(){
	location.href="index.jsp?main=shop/shoplist.jsp";
});

$("span.mainboard").click(function(){
	location.href="index.jsp?main=board/boardlist.jsp";
});

</script>
</html>