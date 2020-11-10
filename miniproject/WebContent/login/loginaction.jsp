<%@page import="data.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
 //id, pass, saveid 읽기
 	String id=request.getParameter("id");
	String pass=request.getParameter("pass");
	String saveid=request.getParameter("saveid"); //null이면 체크 안한 상태
 //세션에 위의 설명대로 저장 및 삭제
 //loginProcess 호출
 	MemberDao dao = new MemberDao();
 //아이디가 db명단에 없을 경우 1반환
 //이이디는 있는데 비번이 안맞는경우 2 반환
 //아이디와 비번 모두 맞느 경우 3 반환
 	int x = dao.loginProcess(id, pass);
 	if(x==1){
 		%>
 		<script type="text/javascript">
			alert("아이디가 존재하지 않습니다.\n 먼저 회원가입을 해주세요.");
			history.back();
		</script>
 		<%
 	}else if(x==2){
 		%>
 		 <script type="text/javascript">
			alert("패스워드가 맞지 않습니다.");
			history.back();
		</script>
 		<%
 	}else if(x==3){
 		session.setAttribute("myid", id);
 		
 		if(saveid!=null){//아이디 저장 체크한 경우
 			session.setAttribute("saveid", "yes");
 		}else{//기존 세션 삭제
 			session.removeAttribute("saveid");
 		}
 		session.setAttribute("loginok", "success");
 		//세션 유지시간 지정
 		session.setMaxInactiveInterval(60*60*24);
 		//로그인 메인으로 이동
 		response.sendRedirect("../index.jsp");
 		

 	};

 
 //위의 결과 3인 경우에만 세션에 위의 설명대로 저장 및 삭제, index로 이동
 
 //나머지 경우는 적절한 경고창과 함꼐 이전 페이지로 이동하기.
%>