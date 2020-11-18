<%@page import="data.dao.ShopAnswerDao"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="data.dto.ShopDto"%>
<%@page import="data.dao.ShopDao"%>
<%@page import="data.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Single+Day&display=swap" rel="stylesheet">
<style type="text/css">
	#wrap{
		display:flex;
		flex-direction:column;
		justify-content:center;
	}

	img.large{
		width: 470px;
		height: 570px;
	}
	
	img.small{
		cursor: pointer;
		width: 80px;
		height: 90px;
		border: 1px solid gray;
		margin-right: 5px;
	}
	
	img.select{
		border: 4px solid tomato;
		border-radius: 20px;
	}
	
	div.colors{
		float:right;	
		width: 30px;
		height: 30px;
		border: 1px solid black;
		margin-right: 5px;
		cursor: pointer;
	}
	
	div.mycolor{
		width: 50px;
		height: 50px;
		border: 1px solid black;
		margin-left: 100px;
	}	
	#frm{
		margin:0 auto;
	}
	
	div#answer{
		margin:30px auto;
	}
	
	div#answerlist{
		margin:30px auto;
	}
	
	#content{
		width:600px;
		height:100px;
		float:left;
	}
	
	#addanswer{
		width:80px;
		height:50px;
		line-height:50px;
		margin-left:5px;
	}
	
	.answeradd textarea{
		margin-left:40px;
		width:700px;
		height:100px;
		float:left;
	}
	
	.writeanswer{
		margin-left:340px;
		margin-top:10px;
		float:left;
	}
	
	span.delanswer{
		cursor:pointer;
	}
	
	table.answertable{
		font-family: Single day;
		font-size:1.3em;
		border-collapse: collapse;
 		border-radius: 1em;
 		overflow: hidden;
	}
	table.answertable thead{
		text-align: center;
		padding: 10px;
    	font-weight: bold;
	    vertical-align: top;
   		color: #369;
  	 	border-bottom: 3px solid #036;
	}
	
</style>
<script type="text/javascript">
$(function(){
	//처음 상품디테일 출력시 기존 댓들도 출력하기
	answerlist();
	//첫번째 사진에 클래스 추가
	$("img.small").first().addClass("select");
	//작은사진 클릭시 이벤트
	$("img.small").click(function(){
		//클릭한 이미지를제외한 나머지 작은 이미지에 있는 클래스 제거
		$(this).siblings().removeClass("select");
		//클릭한 이미지에서 src값 얻기
		var imgsrc=$(this).attr("src");
		//얻은 src 를 큰 이미지에 적용
		$("img.large").attr("src",imgsrc);
		//클릭한 작은이미지에 select 클래스 추가
		$(this).addClass("select");
	});	
	
	//색상 클릭시 이벤트
	$("div.colors").click(function(){
		var mycolor=$(this).css("background-color");
		$("div.mycolor").css("background-color",mycolor);
		//hidden 폼태그에도 같이 넣어준다
		$("#mycolor").val(mycolor);
	});
	
	//댓글 추가버튼 이벤트
	$("#addanswer").click(function(){
		//ajax함수로 처리
		//readanswer.jsp로 myid, shopnum, content 3개를 보내서
		//해당 jsp파일에서 db에 insert한다.
		//성공하면 사용자함수 answerlist()를 호출하고
		//입력창의 값들은 지워주세요.
		var myid=$("#myid").val();
		var shopnum=$("#shopnum").val();
		var content=$("#content").val();
		//alert(myid+shopnum+content)
		$.ajax({
			data:"post",
			dataType:"html",
			data:{"myid":myid,"shopnum":shopnum,"content":content},
			url:"shop/readanswer.jsp",
			success:function(data){
				answerlist();
				$("#content").val("");
			}
		});
		
	});
	
	$(document).on('click','.addanswer',function(){
		$(this).next().toggle();
	});
		
	
	$(document).on('click','.writeanswer',function(){
		var idx=$(this).val();
		var answer=$(".writearea").val();
		if(answer.length==0){
			alert("답글을 입력 후 저장해주세요");
			return;
		}else{
			$.ajax({
				data:"post",
				dataType:"html",
				data:{"idx":idx,"answer":answer},
				url:"shop/updateanswer.jsp",
				success:function(data){
					alert("작성이 완료되었습니다.");
					answerlist();
					$(".writearea").val("");
					
				}
			});
		}
		
	});
		
	
	
	$(document).on('click','span.delanswer',function(){
		var idx=$(this).attr("value");
		$.ajax({
			data:"post",
			dataType:"html",
			data:{"idx":idx},
			url:"shop/deleteanswer.jsp",
			success:function(data){
				alert("삭제가 완료되었습니다.");
				answerlist();
			}
		});
	})
	
});

//사용자 함수 추가
function answerlist(){
	//alert($("#shopnum").val());
	var loginid=$("#myid").val();
	var shopnum=$("#shopnum").val();
	$.ajax({
		data:"post",
		dataType:"xml",
		data:{"shopnum":shopnum},
		url:"shop/answerlist.jsp",
		success:function(data){
			//console.log($(data).find("answer").find("idx").text());
			var s="";
			$(data).find("answer").each(function(key,value){
				var a=$(value);
				s+="<table class='table table-bordered answertable' style='width:800px'><thead><tr class='info'><td>작성자</td><td>"+a.find("name").text()+"</td><td>작성일</td><td width='250px'>"+a.find("writeday").text();
				
				var myid=a.find("myid").text();
				if(loginid==myid){
					s+="&nbsp;&nbsp;&nbsp;&nbsp;<span class='delanswer glyphicon glyphicon-trash' value='"+a.find('idx').text()+"' ></span></td></tr></thead>";		
				}else{
					s+="</td></tr></thead>";
				}
				var qcontent=a.find("content").text();
				qcontent = qcontent.replace(/(?:\r\n|\r|\n)/g, '<br />');
				s+="<tr><td colspan='4' height='100px'><b>["+a.find("name").text()+"]</b><br>&nbsp;&nbsp;"+qcontent+"</td></tr>";
				if(a.find("shopanswer").text()=="no"){
					if(loginid=="admin"){
					s+="<tr><td colspan='4'><button type='button' class='btn btn-primary addanswer'>답변달기</button>";
					s+="<div class=answeradd style='display:none'><br><textarea class='writearea'></textarea><br>";
					s+="<button type='button' value='"+a.find('idx').text()+"' class='btn btn-warning writeanswer'>작성</button></div></td></tr></table>";
					}
				}else{
					var qanswer=a.find("shopanswer").text();
					qanswer = qanswer.replace(/(?:\r\n|\r|\n)/g, '<br />');
					s+="<tr class='info'><td colspan='4' height='80px;'><b>[샵주인]</b><br>&nbsp;&nbsp;"+qanswer+"</td></tr></table>";
				}
				
			});
			$("#answerlist").html(s);
		}
	});
}
</script>
</head>
<%
	String shopnum=request.getParameter("shopnum");
	//로그인상태
	String loginok=(String)session.getAttribute("loginok");
	//로그인한 아이디
	String myid=(String)session.getAttribute("myid");
	//아이디에 해당하는 멤버 테이블의 시퀀스번호
	MemberDao mdao=new MemberDao();
	String num=mdao.getNum(myid);
	
	//해당 상품에 대한 데이타 가져오기
	ShopDao sdao=new ShopDao();
	ShopDto dto=sdao.getData(shopnum);
	//사진들 배열타입으로 얻기
	String []photo=dto.getPhoto().split(",");
	//색상들 배열타입으로 얻기
	String []color=dto.getColor().split(":");		
%>
<body>
<div id="wrap">
	<form id="frm">
		<!-- hidden : 장바구니 db 에 넣어야할 값들 -->
		<input type="hidden" name="shopnum" value="<%=shopnum%>">
		<input type="hidden" name="num" value="<%=num%>">
		<input type="hidden" name="mycolor" id="mycolor" 
		value="<%=color[color.length-1]%>">
		
		<table style="width: 800px;">
			<tr>
				<td style="width: 500px;">
					<div id="photo">
						<img src="shopsave/<%=photo[0]%>"
							class="large img-thumbnail">
						<div>
						<%
						//사진이 여러개일경우만 반복문으로 처리
						if(photo.length>1)
						{
							for(int i=0;i<photo.length;i++)
							{%>
								<img src="shopsave/<%=photo[i]%>"
									class="small" >
							<%}
						}
						%>	
						</div>
					</div>
				</td>
				<td style="width: 300px;" valign="top">
					<h3>카테고리 : <%=dto.getCategory()%></h3>
					<h3>상품명 : <%=dto.getSangpum()%></h3>
					<%
					NumberFormat nf=NumberFormat.getCurrencyInstance();
					%>
					<h3>가 격 : <%=nf.format(dto.getPrice())%></h3>
					<h3>색 상 :
					<%
					for(String co:color)
					{%>
						<div class="colors" style="background-color: <%=co%>"></div>
					<%}
					%>
					</h3>
					<h3>선택한 색상 : 
					 <div class="mycolor" style="background-color: <%=color[color.length-1]%>"></div>
				    </h3>
				    
				    <!-- 갯수 선택 -->
				    <h3>갯 수 : 
				    	<input type="number" min="1" max="10" value="1"
				    	step="1" name="cnt">
				    </h3>
				    
				    <div style="margin-top: 100px;margin-left: 60px;">
				    	<button type="button"
				    	class="btn btn-success btn-lg"
				    	style="width: 100px;"
				    	id="btncart">장바구니</button>
				    	
				    	<button type="button"
				    	class="btn btn-info btn-lg"
				    	style="width: 100px;"
				    	onclick="location.href='index.jsp?main=shop/shoplist.jsp'">상품목록</button>
				    </div>
				</td>
			</tr>
		</table>
	</form>
	
	<!-- detail 페이지의 댓글 -->
	<%
		//댓글 입력창은 로그인을 해야만 보인다.
		if(loginok!=null)
		{
	%>
	<div id="answer">
		<form id="answerfrm">
			<input type="hidden" id="myid" value="<%=myid %>">
			<input type="hidden" id="shopnum" value="<%=dto.getShopnum() %>">
			<h5 style='font-weight:bold; font-size:1.5em;'>● 댓글달기</h5>
			<textarea id="content" class="form-control"></textarea>
			<button type="button" id="addanswer" class="btn btn-warning">추가</button>
		</form>
	</div>
	<%} %>
	<div id="answerlist">
		
	</div>

</div>
<script type="text/javascript">
	$("#btncart").click(function(){
		var login="<%=loginok%>";
		if(login=="null"){
			alert("먼저 로그인을 해주세요");
			return;
		}
		
		//form 태그의 모든값을 가져오기
		var formdata=$("#frm").serialize();
		//alert(formdata);
		$.ajax({
			type:"post",
			dataType:"html",
			data:formdata,
			url:"shop/detailprocess.jsp",
			success:function(data){
				//alert("성공");
				var a=confirm("장바구니에 저장하였습니다\n장바구니로 이동하려면 [확인]을 눌러주세요");
				if(a){
					location.href="index.jsp?main=shop/mycart.jsp";
				}
			}
		});
	});
</script>
</body>

</html>










