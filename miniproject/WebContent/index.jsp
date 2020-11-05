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
	div.layout div.title{
		height: 130px;
		line-height: 130px;
		font-size: 60px;
		text-align: center;
		font-family: Itim;
	}
	
	div.layout div.menu{
		text-align: center;
		font-size: 30px;
		font-family: Jua;

	}
	
	div.layout div.info{
		position: absolute;
		left: 20px;
		top: 400px;
		width: 140px;
		height: 200px;
		border: 2px solid gray;
		border-radius: 30px;
		font-size: 15px;
		padding: 20px;
		font-family: Jua;
	}
	
	div.layout div.main{
		position: absolute;
		left: 300px;
		top: 300px;
	}
	
	div.layout div.login{
		position: absolute;
		left: 20px;
		top: 160px;
		width: 160px;
		height: 150px;
		border: 2px solid gray;
		border-radius: 30px;
		font-size: 20px;
		padding: 20px;
		font-family: Jua;
	}
</style>
</head>
<%
	//메인페이지에 들어갈 파일 읽기
	String mainPage="layout/main.jsp";
	if(request.getParameter("main")!=null){
		mainPage=request.getParameter("main");
	};

%>
<body>
<div class="layout">
	<div class="login">
		<jsp:include page="login/loginmain.jsp"/>
	</div>
	<div class="title">
		<jsp:include page="layout/title.jsp"/>
	</div>
	<div class="menu">
		<jsp:include page="layout/menu.jsp"/>
	</div>
	<div class="main">
		<jsp:include page="<%=mainPage %>"/>
	</div>
	<div class="info">
		<jsp:include page="layout/info.jsp"/>
	</div>
</div>
</body>
</html>















