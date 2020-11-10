<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	div.loginform td.submit{
		vertical-align:middle;
		cursor:pointer;
		background-color:#ccc;
		font-weight:bold;
	}
</style>

<script type="text/javascript">
$(function(){
	//로그인 버튼이 td태그이므로 이벤트를 따로 준다.
	$("td.submit").click(function(){
		//로그인이 submit 버튼이 아니라서 ㅏ동입력체크를 못한다.
		//코드로 입력체크 주기
		if($("#myid").val().length==0){
			alert("아이디를 입력해주세요.");
			return;
		}
		if($("#mypass").val().length==0){
			alert("비밀번호를 입력해주세요.");
			return;
		}
		
		$("#frm").submit();
		
		
	});
});
</script>

</head>
<body>
<%
	//session에 saveid가 있을 경우(아이디 저장 체크 한 경우)
	//session에서 id를 얻는다.
	String saveid=(String)session.getAttribute("saveid");
	String id="";
	if(saveid!=null){
		id=(String)session.getAttribute("myid");
	}
%>
<div class="loginform">
	<form action="login/loginaction.jsp" method="post" id="frm">
		<table class="table table-bordered">
			<caption><b> 세션 로그인 </b></caption>
			<tr>
				<td style="width:100px;">
					<input type="text" name="id" id="myid"
					placeholder="아이디" class="form-control input-sm"
					value="<%=id %>">
				</td>
				<td class="submit" rowspan="2">
					로그인
				</td>
			</tr>
			<tr>
				<td style="width:130px;">
					<input type="password" name="pass" id="mypass"
					placeholder="비밀번호"	class="form-control">		
				</td>
			</tr>
			<tr>
				<td colspan="2" style="font-size:.7em;" >
					<input type="checkbox" name="saveid"
					<%=saveid==null?"":"checked"%>>아이디 저장
					&nbsp;
					<a href="index.jsp?main=member/memberform.jsp">회원가입</a>
				</td>
			</tr>
		</table>
	
	</form>
</div>
</body>
</html>