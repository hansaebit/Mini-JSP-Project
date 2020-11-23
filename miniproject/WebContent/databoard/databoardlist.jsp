<%@page import="data.dao.MemberDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="data.dto.DataBoardDto"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.DataBoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Refresh" content="60*60*60;url=index.jsp?main=databoard/databoardlist.jsp">
<title>Insert title here</title>
<style type="text/css">
	div#container{
		display:flex;
		flex-direction:column;
		align-items: center;
	}
	div#container button.adddata{
		align-self: flex-end;
		margin-right: 100px;
	}
</style>
</head>
<%
	//dao 선언	
	DataBoardDao dao=new DataBoardDao();
	//세션으로부터 key, value 가져오기
	String key=(String)session.getAttribute("key");
	String value=(String)session.getAttribute("value");
	//게시글 갯수 구하기
	int totalCount=dao.getTotalCount(key, value);
    int perPage=10; //한 페이지당 보여질 글의 갯수
    int perBlock=10; //한 블럭당 출력할 페이지의 갯수
    int totalPage; //총 페이지 갯수
    int startPage; //각 블럭당 시작 페이지 번호
    int endPage; //각 블럭당 끝 페이지 번호
    int start; // 각 블럭당 불러올 글의 시작번호
    int end; //각 블럭당 불러올 글의 끝 번호
    int currentPage; //현재 보여질 페이지 번호
    
    //1. currentPage 번호 구하기==================================
    String pageNum=request.getParameter("pageNum");
    if(pageNum==null){
        currentPage=1;//페이지번호가 없을 경우 무조건 1페이지로 간다.
    }else{
        currentPage=Integer.parseInt(pageNum);
    };
    
    //2. 총 페이지 구하기===========================================
    //예: 총 글수가 9이고 한페이지당 2개씩 볼 경우 총 10페이지.(나머지가 있을 때 한 페이지 더해주기.)
    totalPage=totalCount/perPage+(totalCount%perPage>0?1:0);
    
    //3. 시작 페이지와 끝 페이지 구하기=================================
    //예: 한 페이지당 3개만 볼 경우, 현재 페이지가 2라면 start는 1, end가 3.
    //예2: 현재 페이지가 7이라면 start:7, end:9
    startPage=(currentPage-1)/perBlock*perBlock+1;
    endPage=startPage+perBlock-1;
    //마지막 블럭은 endPage를 totalPage로 해놔야 한다.
    if(endPage>totalPage)
        endPage=totalPage;
    
    //4. 각 페이지에서 불러올 글번호 구하기===============================
    //예: 1페이지는 1~2, 2페이지는 3~4 ... 
    start=(currentPage-1)*perPage+1;
    end=start+perPage-1;
    //마지막 글번호는 총 글수와 같은 번호라야 한다.
    if(end>totalCount)  end=totalCount;
	
	//출력할 목록 가져오기
	List<DataBoardDto> list=dao.getSearchList(key, value, start, end);
	//각 페이지의 시작번호 계산
	int no=totalCount-(currentPage-1)*perPage;
%>
<body>
<div id="container">
	<button type="button" class="btn btn-info adddata" style="width:120px;" 
	onclick="location.href='index.jsp?main=databoard/databoardform.jsp'">자료추가</button>
	<table class="table table-bordered" style="width:900px;">
		<caption><b>총 <%=totalCount%>개의 자료가 있습니다.</b></caption>
		<tr bgcolor="#ddd">
			<th style="width: 60px;">번호</th>
			<th style="width: 400px;">제목</th>
			<th style="width: 130px;">작성자</th>
			<th style="width: 130px;">작성일</th>
			<th style="width: 60px;">조회</th>
		</tr>
		<%
		if(totalCount==0){
			%>
			<tr height="50">
				<td colspan="5" align="center">
					<b>등록된 글이 없습니다.</b>
				</td>
			</tr>
			<%
		}else{
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
			MemberDao mdao=new MemberDao();
			for(DataBoardDto dto:list){
				boolean isPhoto=dto.isFileInPicture();
				boolean isGeneral=dto.isFileInGeneral();
				//아이디에 해당하는 이름 얻기
				String name=mdao.getName(dto.getMyid());
				%>
				<tr align="center">
					<td><%=no-- %></td>
					<td align="left">
						<a href="index.jsp?main=databoard/content.jsp?num=<%=dto.getNum() %>&pageNum=<%=currentPage %>&key=a">
							<%String listsubject=dto.getSubject(); 
							/* listsubject=listsubject.replace("<", "%<") */%>
							<%=listsubject %>
							<%if(!dto.getFiles().equals("no")){ %>
								<%if(isPhoto){ %>
									<span class="glyphicon glyphicon-picture" style='color:#aaa;'></span>
								<%} %>	
								<%if(isGeneral){ %>
									<span class="glyphicon glyphicon-file" style='color:#aaa;'></span>
								<%}
							}%>
						</a>
					</td>
					<td>
						<%=name %>
					</td>
					<td>
						<%=sdf.format(dto.getWriteday()) %>
					</td>
					<td>
						<%=dto.getReadcount() %>
					</td>
				</tr>
				<%
			}
		}
		%>
	</table>
	
	<!-- 페이징 처리 -->
	<ul class="pagination pagination-lg">
			<%
		    if(startPage>1){
		    %>
		        <li><a href="index.jsp?main=databoard/databoardlist.jsp?pageNum=<%=startPage-1%>">이전</a></li>
		    <%
		    }
		    for(int i=startPage;i<=endPage;i++){
		        String url="index.jsp?main=databoard/databoardlist.jsp?pageNum="+i;
		        if(i==currentPage){ 
		            %>
		                <li class="active"><a href="<%=url%>"><%=i %></a></li>
		            <%
		        }else{
		            %>
		               <li><a href="<%=url%>" style="color:black;cursor:pointer;"><%=i %></a><li>
		            <%
		        }
		    }
		    
		    //다음
		    if(endPage<totalPage){
		        %>
		            <li><a href="index.jsp?main=databoard/databoardlist.jsp?pageNum=<%=endPage+1%>">다음</a><li>
		        <%
		    }
		    
		%>
	</ul>
	
	<!-- 검색창 -->
	<form action="#" class="form-inline">
		<div style="width:900px; text-align:center;">
			<div class="form-group">			
			<%
				String search=(String)session.getAttribute("key");
				String word=(String)session.getAttribute("value");
				if(search==null)
					search="all";
				if(word==null)
					word="";
				
			%>	
				<select class="form-control" id="search" name="search" style="width:100px;">
					<option value="all" <%=search.equals("all")?"selected":"" %>>전체</option>
					<option value="myid" <%=search.equals("myid")?"selected":"" %>>아이디</option>
					<option value="subject" <%=search.equals("subject")?"selected":"" %>>제목</option>
					<option value="content" <%=search.equals("content")?"selected":"" %>>내용</option>
				</select>
				<input type="text" class="form-control" name="word" id="word" style="width:200px;" placeholder="검색 단어 입력하기" value="<%=word%>">
				<button type="button" class="btn btn-default btn-sm" id="btndatasearch"><span class="glyphicon glyphicon-search"></span>검색</button>
			</div>
		</div>
	</form>
</div>
</body>
<script type="text/javascript">
	$("#btndatasearch").click(function(){
		var search=$("#search").val();
		var word=$("#word").val();
		$.ajax({
			type:"get",
			dataType:"html",
			url:"databoard/savesession.jsp",
			data:{"search":search,"word":word},
			success:function(){
				//전체 새로고침
				//location.reload();
				location.href="index.jsp?main=databoard/databoardlist.jsp";
			}
		});
	});
	$("#search").change(function(){
		$(this).next().val("");
		if($(this).val()=="all")
			$("#btndatasearch").trigger("click");

	});
	
</script>
</html>