<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	
	div.mymenu{
		width: 100%;
		display: flex;
	}
	
	div.mymenu ul{
		margin: 0 auto;
		list-style-type: none;
	}

	
	div.mymenu ul li{
		float: left;
		width: 130px;
		height: 80px;
		line-height: 80px;
		border: 1px solid #db7093;
		margin-right: 20px;
		border-radius: 20px;
		
	}
	div.mymenu ul li:hover{
		background-color:#ffb6c1;
		color: #483d8b;
		cursor:pointer;
		
	}
	
	div.mymenu ul li.bottom{
		border-bottom: 5px solid #333;
		border-right: 5px solid #333;
	}
</style>
<script type="text/javascript">
	$(function(){
		if(localStorage.menu!=null){
			$("div.mymenu ul li").each(function(i,element){
				if(localStorage.menu==$(this).attr("menu")){
					$(this).addClass("bottom");
					$(this).next().click();
				}
			});
		}else{
			$("div.mymenu ul li").eq(0).addClass("bottom");
		}
		
		$("div.mymenu ul li a").click(function(e){
			//기본 이벤트 무효화
			e.preventDefault();
			
			var href=$(this).attr("href");
			location.href=href;
			var menu=$(this).parent().attr("menu");
			localStorage.menu=menu;
			//href값을 얻어서 해당 url로 이동
		});
	})
</script>
</head>
<body>
<%
	//프로젝트의 경로 구하기
	String url=request.getContextPath(); // 프로젝트 다음의 경로 구해줌. (경로 오류 최소화)
%>
<div class="mymenu">
	<ul>
		<li menu="menu1">
			<a href="<%=url %>/index.jsp">Home</a>
		</li>
		<li menu="menu2">
			<a href="<%=url %>/index.jsp?main=member/memberlist.jsp">회원목록</a>
		</li>
		<%
		String logid=(String)session.getAttribute("myid");
		String loginok=(String)session.getAttribute("loginok");
		if(logid=="admin"&&loginok!=null){
		%>
		<li menu="menu3">
			<a href="<%=url %>/index.jsp?main=shop/addform.jsp">상품등록</a>
		</li>
		<%}else{%>
		<li menu="menu3">
			<a href="<%=url %>/index.jsp?main=shop/shoplist.jsp">상품목록</a>
		</li>
		<%}%>
		
		
		
		<li menu="menu4">
			<a href="<%=url %>/index.jsp?main=guest/guestlist.jsp">방명록</a>
		</li>
		<li menu="menu5">
			<a href="<%=url %>/index.jsp?main=board/boardlist.jsp">게시판</a>
		</li>
		<li menu="menu6">
			<a href="<%=url %>/index.jsp?main=databoard/databoardlist.jsp">자료실</a>
		</li>
		<li menu="menu7">
			<a href="<%=url %>/index.jsp?main=money/moneylist.jsp">금전출납부</a>
		</li>
	</ul>
<!-- 출력을 무조건 index로...(메인자리에 멤버리스트,게스트,보드 등 나오게 하려고 index.jsp?main=를 씀!)
	getParameter("main")을 하면 경로를 얻을 수 있음! Home은 null, 메인페이지로 가게 설정함. -->
</div>
</body>
</html>