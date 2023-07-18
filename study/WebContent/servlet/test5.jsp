<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	//JSTL(JSP Standard Tag Library)
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="" method="post">
수: <input type="text" name="su"/><br/>
<input type="submit" value="결과"/><br/>

</form>
<br/>

<!-- param의 su가 null이 아니면 실행 -->
<c:if test="${!empty param.su }">

	<c:if test="${param.su % 2 ==0 }">
		${param.su } : 짝수<br/>
	</c:if>
	<c:if test="${param.su % 2 == 1 }">
		${param.su } : 홀수<br/>
	</c:if>
</c:if>

<hr/>

<table border="1" cellpadding="0" cellspacing="0" align="center">

<c:forEach var="i" begin="1" end="9" step="1">
<tr>
	<c:forEach var="j" begin="1" end="9" step="1">
		<td width="50">${i*j }</td>
	</c:forEach>
</tr>
</c:forEach>


</table>
</body>
</html>