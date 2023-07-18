<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<!-- test6.jsp를 import해서 출력 -->
<c:set var="url" value="test6.jsp"/>
<c:import url="${url }" var="gugu">
	<c:param name="dan" value="6"/>
</c:import>

<!-- 날코딩 지우기 => escapeXml="false" -->
<c:out value="${gugu }" escapeXml="false"/>

<hr/>

<c:set var="url" value="https://www.nate.com"/>
<c:import url="${url }" var="daum"/>
<c:out value="${daum }" escapeXml="false"/>

</body>
</html>