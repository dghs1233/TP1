<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>

<%

	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	String name = request.getParameter("name");
	String gender = request.getParameter("gender");
	String tel1 = request.getParameter("tel1");
	String tel2 = request.getParameter("tel2");
	String tel3 = request.getParameter("tel3");
	String chk = request.getParameter("chk");
	String memo = request.getParameter("memo");
	String[] hobby = request.getParameterValues("hobby");
	String[] type = request.getParameterValues("type");
	
	//엔터한 내용 처리
	memo = memo.replaceAll("\r\n", "<br/>");
	
	String str1 = "";
	String str2 = "";
	
	//hobby를 여러개 선택 가능하고 이를 배열로 받아서 직접 출력해줘야 함
	if(hobby!=null) {
		
		for(String temp : hobby) {
			str1 += temp + " ";
		}
		
	}
	
	if(type!=null) {
		
		for(String temp : type) {
			str2 += temp + " ";
		}
		
	}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

아이디: <%=id %><br/>
패스워드:<%=pwd %><br/>
이름:<%=name %><br/>
성별:<%=gender %><br/>
전화번호:<%=tel1 %>-<%=tel2 %>-<%=tel3 %><br/>
취미:<%=str1 %><br/>
좋아하는 분야:<%=str2 %><br/>
동의여부:<%=chk %><br/>
메모:<%=memo %><br/>

</body>
</html>