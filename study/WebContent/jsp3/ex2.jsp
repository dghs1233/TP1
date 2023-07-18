<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String userName = request.getParameter("userName");
	String userBirth = request.getParameter("userBirth");
	
	//session.setAttribute("userName", userName);
	//session.setAttribute("userBirth", userBirth);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="ex3.jsp" method="post">

아이디 : <input type="text" name="userId" size="10"/><br/>
패스워드 : <input type="password" name="userPwd" size="10"/><br/>

<!-- ex1에서 받은 데이터를 그대로 받아와서 hidden을 통해 안보이게 함-->
<input type="hidden" name="userName" value="<%=userName %>"/>
<input type="hidden" name="userBirth" value="<%=userBirth %>"/>
<input type="submit" value="다음" onclick="sendIt();">
</form>

</body>
</html>