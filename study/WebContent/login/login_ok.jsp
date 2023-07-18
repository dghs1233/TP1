<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String userId = request.getParameter("userId");
	String userPwd = request.getParameter("userPwd");
	
	if(userId.equals("suzi")&&userPwd.equals("123")) {
		
		//userId라는 변수를 만들고 그 안에 userId를 넣어라
		session.setAttribute("userId", userId);
		
		//세션의 값이 바꼈으므로 리다이렉트
		response.sendRedirect("login.jsp");
		
	}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

아이디 또는 패스워드가 틀립니다.
<a href="login.jsp">로그인</a>

</body>
</html>