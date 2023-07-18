<%@page import="java.net.URLDecoder"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	
	request.setCharacterEncoding("UTF-8");

	String eng = request.getParameter("eng");
	String han = request.getParameter("kor");
	
	//han이라고 하는 변수를 UTF-8로 디코딩
	String kor = URLDecoder.decode(han, "UTF-8");
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

포워딩된 데이터<br/>
eng: <%=eng %><br/>
<!-- 한글은 깨지므로 압축(Encoding) 후 해제(Decoding) 해줘야 함 -->
kor: <%=kor %><br/>

</body>
</html>