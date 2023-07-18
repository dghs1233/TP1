<%@page import="java.io.DataInputStream"%>
<%@page import="java.util.Enumeration"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	String contentType = request.getContentType();
	
	//헤더에 있는 정보로 밑에 있는 데이터 받아냄(분리)
	Enumeration e = request.getHeaderNames();
	
	out.print("전송받은 헤더 정보..");
	
	//헤더에 대한 정보를 읽어내는 방법
	while(e.hasMoreElements()) {
		
		String key = (String)e.nextElement();
		String value = request.getHeader(key);
		out.print(key + " : " + value + "<br/>");
		
	}
	
	out.print("<br/>전송받은 데이터..<br/>");
	
	DataInputStream is = new DataInputStream(request.getInputStream());
	
	String str;
	while((str = is.readLine())!=null) {
		out.print(new String(str.getBytes("euc-kr"),"ISO-8859-1") + "<br/>");
	}
	
%>