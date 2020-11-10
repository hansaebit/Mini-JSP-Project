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
</head>
<body>
<form action="money/moneyaction.jsp ">
<table class="table table-bordered" style="width:300px;">
	<tr>
		<td>
			품목
		</td>
		<td>
			<input type="text" name="pummok" id="pummok">
		</td>
	</tr>
	<tr>
		<td>
			가격
		</td>
		<td>
			<input type="text" name="price" id="price">
		</td>
	</tr>
	<tr>
		<td>
			날짜
		</td>
		<td>
			<input type="date" name="day" id="day">
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<button type="submit">입력</button>
		</td>
		
	</tr>
	
</table>
</form>
</body>
</html>