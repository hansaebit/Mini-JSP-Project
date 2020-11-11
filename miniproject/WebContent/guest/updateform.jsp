<%@page import="data.dao.GuestDao"%>
<%@page import="data.dto.GuestDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
    span.camera
    {
        cursor: pointer;
        margin-left: 10px;
        font-size: 22px;
    }
    #showimg
    {
        position:absolute;
        left: 520px;
        max-width:150px;
    }
</style>
<script type="text/javascript">
$(function(){
    $("span.camera").click(function(){
        //#photo의 클릭 이벤트 강제발생.
        $("#photo").trigger('click');
    });
});

function readUrl(input){
    if(input.files[0]){
        var reader=new FileReader();
        reader.onload=function(e){
            $("#showimg").attr("src",e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
    }
    
}
</script>
</head>

<body>
    <%
        //세션으로부터 로그인한 사람의 아이디 얻기
    String id = (String) session.getAttribute("myid");
    //로그인한 상태인제 세션을 얻는다.
    String loginok = (String) session.getAttribute("loginok");
    
    GuestDto dto = new GuestDto();
    String num=request.getParameter("num");
    String pageN=request.getParameter("pageNum");
    GuestDao dao = new GuestDao();
    
    dto = dao.getData(num);
    
    
    if (loginok != null) {
    %>
    <!-- 이미지 출력할 곳 -->
    
    <%
    	if(dto.getPhoto().equals("no")){
    		%>
    		<img id="showimg">
    		<%
    	}else{%>
    		<img id="showimg" src="save/<%=dto.getPhoto()%>">
    		
    	<%}
    %>
    
    
    <form action="guest/updateaction.jsp" method="post" enctype="multipart/form-data">
        <!-- hidden -->
        
        <input type="hidden" name="num" value="<%=num %>">
        <input type="hidden" name="pageN" value="<%=pageN %>">

        <table class="table table-bordered" style="width: 500px">
            <caption>
                <h4>
                    회원방명록(<%=id%>)
                </h4>
            </caption>
            <tr height="150">
                <td>
                    <b>사진은 수정시에만 다시 선택해주세요.</b>
                    <span class="camera glyphicon glyphicon-camera"></span>
                    <input type="file" name="photo" id="photo"
                    style="display:none;"
                    onchange="readUrl(this)"> <!-- 자리 안차지하구 안보이게 -->
                    <br>
                    <textarea name="content" style="width:400px;height:100px;" required="required"><%=dto.getContent() %></textarea>
                    <button type="submit" class="btn btn-default" style="float: right;width:80px;height:100px;">저장</button>
                </td>
            
            </tr>
            <tr>
            	<td align="center">
            		<button type="button" class="btn btn-info"
            		onclick="history.back()"> 목록으로 돌아가기</button>
            	</td>
            </tr>

        </table>
    </form>
    <%
        } else {
    %>
    <b>방명록을 작성하려면 먼저 로그인을 해주세요.</b>
    <%
        }
    %>
</body>
</html>
