<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	
	//이렇게 파일을 받으면 null값 나옴
	String subject = request.getParameter("subject");
	String upload = request.getParameter("upload");
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<!-- 파일 형태가 아닌 텍스트 형태로 넘어옴 -->
제목 : <%=subject %><br/>
파일 : <%=upload %><br/>

</body>
</html>