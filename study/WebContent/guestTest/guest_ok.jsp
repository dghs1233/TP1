<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	/* getParameter 없이 액션태그로 호출 가능
	String userName = request.getParameter("userName");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	String created = request.getParameter("created");
	*/
%>

<jsp:useBean id="vo" class="com.test.GuestVO" scope="page"/>

<!-- 변수 받기 -->
<jsp:setProperty property="*" name="vo"/>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

이름 : <%=vo.getUserName() %><br/>
제목 : <%=vo.getSubject() %><br/>
내용 : <%=vo.getContent().replaceAll("\n", "<br/>") %><br/>
날짜 : <%=vo.getCreated() %><br/>

</body>
</html>