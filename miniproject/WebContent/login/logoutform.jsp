<%@page import="data.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
	String id = (String)session.getAttribute("myid");
	MemberDao dao = new MemberDao();
	String name = dao.getName(id);
%>


</head>
<body>
<!-- 세션에서 id를 얻어 아이디에 해당하는 이름을 출력 후
그 옆에 로그아웃 버튼 추가하기
버튼 클릭시 logoutaction 호출 -->


<%=name %>님!
<button type="button" class="btn btn-success" 
onclick="location.href='login/logoutaction.jsp'" style="margin-left:30px;width:100px;">로그아웃</button>

</body>
</html>