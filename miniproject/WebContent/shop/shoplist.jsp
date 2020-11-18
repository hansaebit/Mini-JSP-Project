<%@page import="java.text.NumberFormat"%>
<%@page import="data.dto.ShopDto"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.ShopDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="kr">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>jQuery UI Tabs - Default functionality</title>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <style type="text/css">
  	
  	.shoptable{
  		height:150px;
  		text-align:center;
  		font-weight:bold;
  		padding:10px;
  	}
  	img.photo{
  		width:200px;
  		height:230px;
  		border:1px solid black;
  		margin-bottom:10px;
  	}
  </style>
  
  <script>
  $( function() {
    $( "#tabs" ).tabs();
  } );
  </script>
    <script>
  $( function() {
    $( "#tabs" ).tabs();
    
    //각 상품 클릭시 발생하는 이벤트 추가
    $("a.godetail").click(function(e){
    	e.preventDefault();//기본 이벤트 무효화
    	
    	//태그에 넣어둔 shopnum 가져오기
    	var shopnum=$(this).attr("shopnum");
    	//alert(shopnum);
    	//디테일 페이지로 이동하기
    	location.href="index.jsp?main=shop/detailpage.jsp?shopnum="+shopnum;
    });
  } );
  </script>
</head>
<%
	ShopDao dao=new ShopDao();
	List<ShopDto> list=dao.getAllSangpums();
%>
<body>
 
<div id="tabs">
	<ul>
	    <li><a href="#tabs-1">전체</a></li>
	    <li><a href="#tabs-2">아우터</a></li>
	    <li><a href="#tabs-3">상의</a></li>
	    <li><a href="#tabs-4">하의</a></li>
	    <li><a href="#tabs-5">세트</a></li>
	    <li><a href="#tabs-6">악세서리</a></li>
	</ul>
	
	
	<div id="tabs-1">
		<p>
    		<table class="table table-bordered" style="width:700px;">
    			<caption><b>전세 상품 목록</b></caption>
    			<tr>
    			<%
    			NumberFormat nf=NumberFormat.getCurrencyInstance();
    			int i=0;
    			for(ShopDto dto:list){
    				//첫번째 사진
    				String photo=dto.getPhoto().split(",")[0];
    				//20~50까지 난수 발생
    				int sale=(int)(Math.random()*31)+20;
    				double saleper=1-(double)sale/100;
    				double saleprice=dto.getPrice()*saleper;
    			%>
    				<td>
    					<a shopnum="<%=dto.getShopnum()%>" style="cursor:pointer;" class="godetail">
    						<img src="shopsave/<%=photo %>" class="photo">
    						<br>
    						<%=dto.getSangpum()%>
    						<br>
    						<b style='color:red; font-size:1.7em;'><%=sale %>%</b>
    						<span style="float:right;">
    							<div style="color:gray;">
    								<del><%=nf.format(dto.getPrice())%></del><br>
    							</div>
    							<b><%=nf.format(saleprice)%></b>
    						</span>
    					</a>
    				</td>
    				<%
    				if((i+1)%4==0){%>
    					</tr>
    					<tr>
    				<%}
    				i++;
    			}
    			%>
    		</table>
		</p>
	</div>
	<div id="tabs-2">
    	<p>
    		<table class="table table-bordered" style="width:700px;">
    			<caption><b>아우터</b></caption>
    			<tr>
    			<%
    			i=0;
    			for(ShopDto dto:list){
    				if(dto.getCategory().equals("아우터")){
    				//첫번째 사진
    				String photo=dto.getPhoto().split(",")[0];
    				//20~50까지 난수 발생
    				int sale=(int)(Math.random()*31)+20;
    				double saleper=1-(double)sale/100;
    				double saleprice=dto.getPrice()*saleper;
    			%>
    				<td>
    					<a shopnum="<%=dto.getShopnum() %>" style="cursor:pointer;" class="godetail">
    						<img src="shopsave/<%=photo %>" class="photo">
    						<br>
    						<%=dto.getSangpum()%>
    						<br>
    						<b style='color:red; font-size:1.7em;'><%=sale %>%</b>
    						<span style="float:right;">
    							<div style="color:gray;">
    								<del><%=nf.format(dto.getPrice())%></del><br>
    							</div>
    							<b><%=nf.format(saleprice)%></b>
    						</span>
    					</a>
    				</td>
    				<%
    				if((i+1)%4==0){%>
    					</tr>
    					<tr>
    				<%}
    				i++;
    			}}
    			%>
    		</table>
		</p>
	</div>
	<div id="tabs-3">
  	    <p>
    		<table class="table table-bordered" style="width:700px;">
    			<caption><b>상의</b></caption>
    			<tr>
    			<%
    			i=0;
    			for(ShopDto dto:list){
    				if(dto.getCategory().equals("상의")){
    				//첫번째 사진
    				String photo=dto.getPhoto().split(",")[0];
    				//20~50까지 난수 발생
    				int sale=(int)(Math.random()*31)+20;
    				double saleper=1-(double)sale/100;
    				double saleprice=dto.getPrice()*saleper;
    			%>
    				<td>
    					<a shopnum="<%=dto.getShopnum() %>" style="cursor:pointer;" class="godetail">
    						<img src="shopsave/<%=photo %>" class="photo">
    						<br>
    						<%=dto.getSangpum()%>
    						<br>
    						<b style='color:red; font-size:1.7em;'><%=sale %>%</b>
    						<span style="float:right;">
    							<div style="color:gray;">
    								<del><%=nf.format(dto.getPrice())%></del><br>
    							</div>
    							<b><%=nf.format(saleprice)%></b>
    						</span>
    					</a>
    				</td>
    				<%
    				if((i+1)%4==0){%>
    					</tr>
    					<tr>
    				<%}
    				i++;
    			}}
    			%>
    		</table>
		</p>
	</div>
	<div id="tabs-4">
    	<p>
    		<table class="table table-bordered" style="width:700px;">
    			<caption><b>하의</b></caption>
    			<tr>
    			<%
    			i=0;
    			for(ShopDto dto:list){
    				if(dto.getCategory().equals("하의")){
    				//첫번째 사진
    				String photo=dto.getPhoto().split(",")[0];
    				//20~50까지 난수 발생
    				int sale=(int)(Math.random()*31)+20;
    				double saleper=1-(double)sale/100;
    				double saleprice=dto.getPrice()*saleper;
    			%>
    				<td>
    					<a shopnum="<%=dto.getShopnum() %>" style="cursor:pointer;" class="godetail">
    						<img src="shopsave/<%=photo %>" class="photo">
    						<br>
    						<%=dto.getSangpum()%>
    						<br>
    						<b style='color:red; font-size:1.7em;'><%=sale %>%</b>
    						<span style="float:right;">
    							<div style="color:gray;">
    								<del><%=nf.format(dto.getPrice())%></del><br>
    							</div>
    							<b><%=nf.format(saleprice)%></b>
    						</span>
    					</a>
    				</td>
    				<%
    				if((i+1)%4==0){%>
    					</tr>
    					<tr>
    				<%}
    				i++;
    			}}
    			%>
    		</table>
		</p>
	</div>
	<div id="tabs-5">
    	<p>
    		<table class="table table-bordered" style="width:700px;">
    			<caption><b>세트</b></caption>
    			<tr>
    			<%
    			i=0;
    			for(ShopDto dto:list){
    				if(dto.getCategory().equals("세트")){
    				//첫번째 사진
    				String photo=dto.getPhoto().split(",")[0];
    				//20~50까지 난수 발생
    				int sale=(int)(Math.random()*31)+20;
    				double saleper=1-(double)sale/100;
    				double saleprice=dto.getPrice()*saleper;
    			%>
    				<td>
    					<a shopnum="<%=dto.getShopnum() %>" style="cursor:pointer;" class="godetail">
    						<img src="shopsave/<%=photo %>" class="photo">
    						<br>
    						<%=dto.getSangpum()%>
    						<br>
    						<b style='color:red; font-size:1.7em;'><%=sale %>%</b>
    						<span style="float:right;">
    							<div style="color:gray;">
    								<del><%=nf.format(dto.getPrice())%></del><br>
    							</div>
    							<b><%=nf.format(saleprice)%></b>
    						</span>
    					</a>
    				</td>
    				<%
    				if((i+1)%4==0){%>
    					</tr>
    					<tr>
    				<%}
    				i++;
    			}}
    			%>
    		</table>
		</p>
	</div>
	<div id="tabs-6">
    	<p>
    		<table class="table table-bordered" style="width:700px;">
    			<caption><b>악세서리</b></caption>
    			<tr>
    			<%
    			i=0;
    			for(ShopDto dto:list){
    				if(dto.getCategory().equals("악세서리")){
    				//첫번째 사진
    				String photo=dto.getPhoto().split(",")[0];
    				//20~50까지 난수 발생
    				int sale=(int)(Math.random()*31)+20;
    				double saleper=1-(double)sale/100;
    				double saleprice=dto.getPrice()*saleper;
    			%>
    				<td>
    					<a shopnum="<%=dto.getShopnum() %>" style="cursor:pointer;" class="godetail">
    						<img src="shopsave/<%=photo %>" class="photo">
    						<br>
    						<%=dto.getSangpum()%>
    						<br>
    						<b style='color:red; font-size:1.7em;'><%=sale %>%</b>
    						<span style="float:right;">
    							<div style="color:gray;">
    								<del><%=nf.format(dto.getPrice())%></del><br>
    							</div>
    							<b><%=nf.format(saleprice)%></b>
    						</span>
    					</a>
    				</td>
    				<%
    				if((i+1)%4==0){%>
    					</tr>
    					<tr>
    				<%}
    				i++;
    			}}
    			%>
    		</table>
		</p>
	</div>
</div>
 
 
</body>
</html>