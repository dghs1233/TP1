<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	Cookie[] ck = request.getCookies();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<table border="1" width="400" cellpadding="0" cellspacing="0">
<tr>
	<th>상품명</th>
	<th>가격</th>
</tr>

<tr>
	<td><a href="jepum1.jsp">냉장고</a></td>
	<td>1000</td>
</tr>

<tr>
	<td><a href="jepum2.jsp">세탁기</a></td>
	<td>2000</td>
</tr>

<tr>
	<td><a href="jepum3.jsp">LCD TV</a></td>
	<td>3000</td>
</tr>
</table>

<br/>

<hr align="left" width="400" color="red"/>

<h3>오늘 본 상품 목록</h3>

<%

if(ck!=null) {
	
	for(int i=ck.length-1;i>0;i--) {
		
		if(ck[i].getName().indexOf("productName")!=-1) {
%>
			<img src="./image/<%=ck[i].getValue() %>.jpg" width="100" height="100"><br/>
<% 			
		}
		
	}
	
}


%>

</body>
</html>