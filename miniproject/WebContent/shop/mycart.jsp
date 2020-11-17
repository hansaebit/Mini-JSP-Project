<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.ShopDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	div.sangpum{
		cursor: pointer;
	}
	div.sangpum img.photo{
		width: 60px;
		height: 90px;
		border: 2px solid gray;
	}
	
	div.mycolor{
		width: 40px;  height: 40px;
		border: 1px solid black;
	}
	
	span.del{
		cursor:pointer;
	}
</style>
<script type="text/javascript">
	$(function(){
		//전체 체크박스 체크/해제
		$("#allcheck").click(function(){
			var a=$(this).is(":checked");			
			if(a){
				$(".idx").prop("checked",true);
			}else{
				$(".idx").prop("checked",false);
			}
		});
		
		//상품 클릭시 디테일 페이지로 이동
		$("div.sangpum").click(function(){
			var shopnum=$(this).attr("shopnum");
			alert(shopnum);
			location.href="index.jsp?main=shop/detailpage.jsp?shopnum="+shopnum;
		});
		
		//선택한 상품 삭제 버튼
		$("#btncartdel").click(function(){
			//체크한 상품 갯수 구하기
			var cnt=$(".idx:checked").length;
			if(cnt==0){
				alert("먼저 삭제할 상품을 선택해주세요");
				return;
			}
			
			$(".idx:checked").each(function(i,element) {
				var idx=$(this).attr("idx");
				console.log(idx);
				
				del(idx);
			});
			
			location.reload();
		});
		
		
		
		//선택한 상품 한개만 삭제시 이벤트
		$("span.del").click(function(){
			var idx=$(this).attr("idx");
			var a=confirm("삭제하려면 [확인]을 눌러주세요.");
			if(a){
				del(idx);
				location.reload(); //f5키랑 같음.
			}
		});
	});
	
	//사용자 함수
	function del(idx){
		$.ajax({
			type:"get",
			url:"shop/cartdelete.jsp",
			dataType:"html",
			data:{"idx":idx},
			success:function(d){
				
			}
		});
	}
</script>
</head>
<%
	//로그인한 아이디 얻기
	String id=(String)session.getAttribute("myid");
	//ShopDao 선언
	ShopDao dao=new ShopDao();
	//장바구니 목록 얻기
	List<HashMap<String,String>> list=dao.getCartList(id);
%>
<body>
<h4 class="alert alert-warning" style="width: 1000px;">
	<%=id%> 님의 장바구니
</h4>
<table class="table table-striped" style="width: 1000px;">
	<tr>
		<th style="width:30px;">
			<input type="checkbox" id="allcheck" checked="checked">
		</th>
		<th style="width: 400px;">상품정보</th>
		<th style="width: 200px;">옵션</th>
		<th style="width: 200px;">상품금액</th>
	</tr>
	<%
	int allmoney=0;
	NumberFormat nf=NumberFormat.getInstance();
	for(int i=0;i<list.size();i++)
	{
		HashMap<String,String> map=list.get(i);
		//사진은 첫번째 사진만 얻기
		String photo=map.get("photo").split(",")[0];
	 %>
	 <tr>
	 	<td align="center">
	 		<input type="checkbox" name="idx" class="idx"
	 		  idx="<%=map.get("idx")%>" checked="checked">
	 	</td>
	 	<td>
	 		<div shopnum="<%=map.get("shopnum")%>" class="sangpum">
	 		 <img src="shopsave/<%=photo%>" class="photo"
	 		 align="left" hspace="20">	 		 
	 		 <h5><b>상품명 : <%=map.get("sangpum")%></b></h5>
	 		 <h5>갯  수 : <%=map.get("cnt")%>개</h5>
	 		 <h5>날  짜 : <%=map.get("cartday")%></h5>
	 		</div>
	 	</td>
	 	<td>
	 		<h4>선택한 색상</h4>
	 		<div style="background-color: <%=map.get("mycolor")%>"
	 		class="mycolor"></div>
	 	</td>
	 	<td align="right" style="vertical-align: middle;" >
	 		<%	 			
	 			int price=Integer.parseInt(map.get("price"));
	 			allmoney+=price;
	 		%>
	 		<h4><%=nf.format(price)%>원
	 			<span class="del glyphicon glyphicon-trash" idx="<%=map.get("idx") %>"></span>
	 		</h4>
	 	</td>
	 </tr>	
	<%}
	%>
	<tr>
		<td colspan="4">
			<button type="button" id="btncartdel"
			class="btndel btn btn-danger btn-lg"
			style="margin-left: 100px;">선택상품삭제</button>
			
			<span style="font-size: 2em;float: right;">
			총 주문 금액 <b style="color: green;">
			<%=nf.format(allmoney)%>원</b></span>
		</td>		
	</tr>
</table>
</body>
</html>







