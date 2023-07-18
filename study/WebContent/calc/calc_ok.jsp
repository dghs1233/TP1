<%@page import="com.test.Calc"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	int su1 = Integer.parseInt(request.getParameter("su1"));
	int su2 = Integer.parseInt(request.getParameter("su2"));
	String oper = request.getParameter("oper");
	
%>
<!-- 객체 생성 -->
<jsp:useBean id="ob" class="com.test.Calc" scope="page"/>

<!-- 변수 받기 -->
<jsp:setProperty property="su1" name="ob" value="<%=su1 %>"/>
<jsp:setProperty property="su2" name="ob" value="<%=su2 %>"/>
<jsp:setProperty property="oper" name="ob" value="<%=oper %>"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
결과 : <%=ob.result() %>
</body>
</html>