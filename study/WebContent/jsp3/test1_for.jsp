<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String name = request.getParameter("name");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
이름 : <%=name %>

<!-- result.jsp로 포워딩 하도록 함 -->
<!-- 결과는 result.jsp를 보여주지만 주소는 test1.for로 보여줌 -->
<jsp:forward page="result.jsp"/>
</body>
</html>