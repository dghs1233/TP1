<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	Cookie c4 = new Cookie("tel", "");
	response.addCookie(c4);
	
	//쿠키를 배열로 받음
	Cookie[] ck = request.getCookies();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	if(ck!=null) {
		
		for(Cookie cc : ck) {
			
			out.print("쿠키이름 : ");
			out.print(cc.getName());
			out.print(", 쿠키값 : ");
			out.print(cc.getValue() + "<br/>");
			
		}
		
	}




%> 

</body>
</html>