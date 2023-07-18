<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String userId = request.getParameter("userId");
	String pwd = request.getParameter("pwd");
	/*
	
	if(userId.equals("suzi")&&pwd.equals("123")) {
		
		//userId라는 변수를 만들고 그 안에 userId를 넣어라
		session.setAttribute("userId", userId);
		
		//세션의 값이 바꼈으므로 리다이렉트
		response.sendRedirect("naverLogin.jsp");
		
	}
	*/
%>
