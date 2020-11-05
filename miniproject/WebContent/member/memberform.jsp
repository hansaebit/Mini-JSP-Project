<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
$(function(){
	//주소검색파일 오픈
	$("#btnpost").click(function(){
		window.open("member/postsearch.jsp","","left=100px,top=100px,width=400px,height=250px");
		//팝업으로 띄워서 경로가 index가 아닌 member로 가 있다. 그래서 bootstrap 효과를 받지 못한다.
		//1. null일 때 폼이 나오고 null이 아닐 때 채워져서...?
	});
	
	
	//아이디 입력시 메세지 지우기
	$("#id").keydown(function(){
		$("b.idcheck").html("");
	});

	$(document).on('blur','#id',function(){
		var id=$(this).val();
		if(id.trim().length==0){//trim은 공백제거 (공백을 제거했을 때 길이가 0이면...)
			$(this).val('');
			return;
		}
		$.ajax({
			type:'get',
			url:'member/idcheckxml.jsp', //현재 경로가 index이기 때문!
			dataType:'xml',
			data:{"id":id},
			success:function(data){
				//alert($(data).text());
				if($(data).text()=='yes'){
					$("b.idcheck").text("이미 등록된 아이디입니다.");
					$("b.idcheck").css({
						"color":"red",
						"font-size":"14px"
					});
					$("#id").val("");
				}else{
					$(".idcheck").text("사용가능한 아이디입니다.");
					$("b.idcheck").css({
						"color":"green",
						"font-size":"14px"
					});
				}
			}
			
		});
	});

})
</script>

</head>
<body>
<form action="member/insertaction.jsp" method="post"
	class="form-inline" name="memberform">
<table class="table table-bordered" style="width:500px;">
	<caption><h3>회원 가입</h3></caption>
	<tr>
		<td align="center" width="100"><b>아 이 디</b></td>
		<td>
			<input type="text" name="id" id='id' class="form-control"
				style="width:100px;" autofocus="autofocus" required="required">
			<b class="idcheck"></b>
		</td>
	</tr>
	
	<tr>
		<td align="center" width="100"><b>비밀번호</b></td>
		<td>
			<input type="password" name="pass" class="form-control"
				style="width:100px;">
				<%-- pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}"      테스트라 빼놓음!
  				title="Must contain at least one  number and one uppercase and lowercase letter, and at least 8 or more characters">> --%>
		</td>
	</tr>
	
	<tr>
		<td align="center" width="100"><b>이  름</b></td>
		<td>
			<input type="text" name="name" class="form-control"
				style="width:100px;">
		</td>
	</tr>
	
	
	<tr>
		<td align="center" width="100"><b>핸드폰</b></td>
		<td>
			<div class="form-group">
				<select name="hp1" class="form-control">
					<option value="02">02</option>
					<option value="010" selected="selected">010</option>
					<option value="019">019</option>
				</select>
				<input type="text" name="hp2" id="hp2" class="form-control"
					maxlength="4" style="width:80px;">
				<input type="text" name="hp3" id="hp3" class="form-control"
					maxlength="4" style="width:80px;">
			</div>
		</td>
	</tr>
	
	<tr>
		<td align="center" width="100"><b>주  소</b></td>
		<td>
			<input type="text" name="address" class="form-control input-sm"
			style="width:300px; background-color: #eee" 
			readonly="readonly">
			<button type="button" class="btn btn-danger btn-sm"
			id="btnpost">주소검색</button>
			<br>
			<input type="text" name="addrdetail" 
			class="form-control input-sm" style="width: 350px;">
		</td>
	</tr>
	
	<tr>
		<td align="center" width="100"><b>이메일</b></td>
		<td>
			<div class="form-group">
				
				<input type="text" name="email1" style="width:80px;"
					class="form-control">
				
				<b>@</b>
				
				<input type="text" name="email2" style="width:100px;"
				id="email2" class="form-control">
				
				<select id="email3" class="form-control">
					<option selected disabled hidden="">이메일 선택</option>
					<option value="-">직접작성</option>
					<option value="naver.com">네이버</option>
					<option value="nate.com">네이트</option>
					<option value="google.com">구글</option>
				</select>
				
			</div>
		</td>
	</tr>
	
	<tr>
		<td colspan="2" align="center">
			<button type="submit" class="btn btn-danger">회원가입</button>
		</td>
	</tr>
</table>
</form>
<script type="text/javascript">
	//1. 핸드폰 4자리 입력시 다음 번호칸으로 이동
	$(document).on('keyup','#hp2',function(){
		if($(this).val().length==4){
			$("#hp3").focus();
		}
		
	});
	//2. 이메일 선택시 앞칸에 이메일 주소 출력
	//   직접쓰기일 경우 기존 이메일 지우고 포커스 주기
	$(document).on('change','#email3', function() {
		$("#email2").val($(this).val());
		if($(this).val()=="-"){
			$("#email2").val("");
			$("#email2").focus();
		}
	});
</script>
</body>
</html>