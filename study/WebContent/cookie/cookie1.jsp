<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	Cookie c1 = new Cookie("name", "suzi");
	Cookie c2 = new Cookie("age", "28");
	Cookie c3 = new Cookie("addr", "서울");
	
	response.addCookie(c1);
	response.addCookie(c2);
	response.addCookie(c3);
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<a href="cookie2.jsp">쿠키보기</a>

</body>
</html>