<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>

<!-- dto, dao usebean -->
<jsp:useBean id="dao" class="data.dao.MemberDao" />
<jsp:useBean id="dto" class="data.dto.MemberDto" />

<!-- setproperty : form 데이터 읽어서 가져오기 (같은이름) -->
<jsp:setProperty property="*" name="dto" />
<%

 //isidpasscheck 호출
 
 boolean find= dao.isIdPassCheck(dto.getId(), dto.getPass());
 //find가 true면 수정메서드 호출 후 memberlist 즉 목록이 나오도록 하고
 //만약 false면 script 코드로 alert 경고 후 이전 페이지로 가기.
	if(find){
		dao.updateMember(dto);
		response.sendRedirect("../index.jsp?main=member/memberlist.jsp");
	}else{%>
<script type="text/javascript">
	alert("비밀번호가 맞지 않습니다.");
	history.back();
 
</script>
<%} %>

