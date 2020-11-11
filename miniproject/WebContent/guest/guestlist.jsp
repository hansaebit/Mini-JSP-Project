<%@page import="data.dao.MemberDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="data.dto.GuestDto"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.GuestDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
    GuestDao dao = new GuestDao();
    int totalCount=Integer.parseInt(dao.getTotalCount());
    int perPage=2; //한 페이지당 보여질 글의 갯수
    int perBlock=3; //한 블럭당 출력할 페이지의 갯수
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
    
    //5. 최종 페이지에 해당하는 방명록 글 가져오기.
    List<GuestDto> list=dao.getList(start,end);
%>
</head>
<body>
<jsp:include page="guestform.jsp"/>
<hr width="1000" align="left" style="height:10px; background-color:pink">
총 <%=totalCount %> 개의 글이 있습니다.
<br><Br>
<%
SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
MemberDao mdao=new MemberDao();
//GuestDto의 ID를 이용하여 member의 이름 얻기. 
for(GuestDto dto:list){
    //아이디에 해당하는 이름 얻기
    String name=mdao.getName(dto.getMyid());
%>
    <table class="table table-bordered" style="width:600px; border:5px solid gray;">
        <tr>
        <td>
            <b><%=name %>(<%=dto.getMyid() %>)</b>
            <span style="float:right;color:gray;font-size:14px;">
            <%=sdf.format(dto.getWriteday()) %> </span>
            <div class="content">
            <%
            //이미지 출력
            if(!dto.getPhoto().equals("no")){%>
                <img src="save/<%=dto.getPhoto() %>" style="max-width: 150px;" hspace="20" align="left">
                <br>                    
            <%}%>
            <br>
            <!-- 여러줄 입력시 한줄로 나온다. 
            이유는 오라클 저장시 br태그가 \n으로 저장되기 때문
            해결책은 \n을 다시 br태그로... -->
            <%=dto.getContent().replace("\n","<br>") %>
            </div>
        </td>
        </tr>
        <tr>
            <td>
                <!-- 여기에 로그인한 본인이 쓴 글에만 수정버튼과 삭제버튼이 보이도록 만들어주세요. -->
                
                <%
                    //현재 로그인상태를 세션으로부터 얻는다.
                    String loginok=(String)session.getAttribute("loginok");
                    String loginid=(String)session.getAttribute("myid");
                    String myid=dto.getMyid();
                    %>
                    <!-- 댓글창 ===========================================================================================================================-->
                    <div class="answer" style="cursor:pointer;">댓글 0</div>   <!-- 클릭(this)의 next를 토글 -->
                    <%if(loginok!=null){ %>
                    <div>
                    	목록출력
                    	<br>
                    	<form action="guest/answeradd.jsp" method="post" class="form-inline" >
                    		<input type="hidden" name="num" value="<%=dto.getNum()%>">
                    		<input type="hidden" name="myid" value="<%=loginid %>">
                    		<input type="hidden" name="myid" value="<%=currentPage %>">
                    		
                    		<div class="form-group">
                    			<input type="text" name="memo" class="form-control" required="required" placeholder="댓글을 달아주세요." style="width:500px;">
                    			<button type="submit" class="btn btn-sm">저장</button>
                    		</div>
                    		<%}else{%>
                    			<div style="text-align:center;">로그인을 하셔야 합니다.</div>
                    		<%}%>
                   	 	</form>	
                    </div>
                    <%
                    
                    if(loginok!=null && loginid.equals(myid)){
                        %>
                        <div style="float: right;">
                            <button type="button" class="btn btn-success btn-sm" style="width:80px;" 
                            onclick="location.href='index.jsp?main=guest/updateform.jsp?num=<%=dto.getNum()%>&pageNum=<%=currentPage%>'">수정</button>
                            <button type="button" class="btn btn-info btn-sm" style="width:80px;"
                            onclick="location.href='guest/deleteaction.jsp?num=<%=dto.getNum()%>&pageNum=<%=currentPage%>'">삭제</button>
                        </div>
                        <%
                    }
                %>
            </td>
        </tr>
    </table>

<%}%>

<!-- 페이징 처리========================================================================================================================================= -->

<div style="width:600px; text-align:center; font-size: 17px;">
<%
    if(startPage>1){
    %>
        <a href="index.jsp?main=guest/guestlist.jsp?pageNum=<%=startPage-1%>">&lt;이전</a>
    <%
    }
    for(int i=startPage;i<=endPage;i++){
        String url="index.jsp?main=guest/guestlist.jsp?pageNum="+i;
        if(i==currentPage){ 
            %>
                <a href="<%=url%>" style="color:red;cursor:pointer;"><%=i %></a>&nbsp;
            <%
        }else{
            %>
                <a href="<%=url%>" style="color:black;cursor:pointer;"><%=i %></a>&nbsp;
            <%
        }
    }
    
    //다음
    if(endPage<totalPage){
        %>
            <a href="index.jsp?main=guest/guestlist.jsp?pageNum=<%=endPage+1%>">다음&gt;</a>
        <%
    }
    
%>
</div>

<script type="text/javascript">
$("div.answer").next().hide();
$(document).on('click','div.answer',function(){
	$(this).next().toggle();
});
</script>
</body>
</html>