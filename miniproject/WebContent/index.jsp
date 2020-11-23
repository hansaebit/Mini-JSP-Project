<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Itim&family=Jua&display=swap" rel="stylesheet">



<style type="text/css">
	a{
		color: black;
		text-decoration: none;
	}
	a:visited{
		color: black;
	}
	a:hover{
		color: gray;
		cursor: pointer;
	}
	
	
	div.title{
		height: 130px;
		line-height: 130px;
		font-size: 60px;
		text-align: center;
		font-family: Itim;
	}
	
	div.menu{
		text-align: center;
		font-size: 30px;
		font-family: Jua;

	}
	
	div.info{
		width: 200px;
		height: 200px;
		border: 2px solid gray;
		border-radius: 30px;
		font-size: 15px;
		padding: 20px;
		font-family: Jua;
	}
	
	.container{
		width:1600px;
		margin:60px auto;
		display:flex;
		justify-content: center;
		flex-wrap: nowrap;
		
	}
	
	.incontainer{
		flex-basis:300px;
	}
	
	div.main{
		flex-basis:1500px;
	}
	
	div.nav{
		flex-basis:300px;
	}
	
	div.login{
		width: 200px;
		/* height: 200px; */
		border: 2px solid gray;
		border-radius: 30px;
		font-size: 20px;
		padding: 20px;
		font-family: Jua;
		margin-right: 60px;
		margin-bottom: 500px;
	}
</style>


</head>
<%
	//메인페이지에 들어갈 파일 읽기
	String mainPage="layout/main.jsp";
	if(request.getParameter("main")!=null){
		mainPage=request.getParameter("main");
	}else{%>
		<script type="text/javascript">
			localStorage.menu="menu1";
		</script>
	<%}
%>
<body>
	
	
	<div class="title">
		<jsp:include page="layout/title.jsp"/>
	</div>
	
	<div class="menu">
		<jsp:include page="layout/menu.jsp"/>
	</div>
	
	

	<div class="container">
		<div class="incontainer">
			<div class="login ">
				<jsp:include page="login/loginmain.jsp"/>
			</div>
			
			<div class="info">
				<jsp:include page="layout/info.jsp"/>
			</div>
		</div>
		<div class="main ">
			<jsp:include page="<%=mainPage %>"/>
		</div>
		<div class='nav'>
			&nbsp;
		</div>
	</div>


	
</body>

</html>
















