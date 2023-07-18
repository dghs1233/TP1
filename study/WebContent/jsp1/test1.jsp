<%@ page contentType="text/html; charset=UTF-8"%>

<!-- jsp의 영역 -->
<%
	int a=10, b=5, c;

	c = a + b;
%>

<%!
//!는 service 메소드 안에 메소드가 만들어지면 
//동작하지 않기 때문에 밖으로 빼줌
	int sum(int x) {
		int s=0;
		for(int i=1;i<=x;i++) {
			s+=i;
		}
		return s;
	}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<!-- jsp 방식 -->
합 : <%=a %>+<%=b %>=<%=c %><br/>

<%

	//servlet 방식
	out.print("합 : " + a + "+" + b + "=" + c + "<br/>");

	String str = String.format("합 : %d+%d=%d<br/>", a, b, c);
	out.println(str);

%>

합계 : <%=sum(100) %>

</body>
</html>