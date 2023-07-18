<%@ page contentType="text/html; charset=UTF-8"%>

<%
	//request에서 가져온 데이터를 utf-8 방식으로 바꿔라
	request.setCharacterEncoding("UTF-8");

	//데이터 받아내기 기본
	String su1 = request.getParameter("su1");
	String su2 = request.getParameter("su2");
	String name = request.getParameter("name");
	
	//형변환
	int s1 = Integer.parseInt(su1);
	int s2 = Integer.parseInt(su2);

	int sum = 0;
	
	sum = s1 + s2;
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

결과 : <%=s1 %>+<%=s2 %>=<%=sum %><br/>
이름 : <%=name %><br/>
</body>
</html>