<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	//옛날 방식
	//String root = request.getRealPath("/");
	
	String root = pageContext.getServletContext().getRealPath("/");
	
	//파일 지정 위치(File.separator = \)
	String path = root + "pds" + File.separator + "saveData";
	//String path = "c:\\pds\\saveData";
	
	File f = new File(path);
	if(!f.exists()) {
		f.mkdirs();
	}
	
	String encType = "UTF-8";
	int maxFileSize = 10 * 1024 * 1024;//10mb
	
	try{
		
		//파일 업로드 코드
		MultipartRequest mr = 
				new MultipartRequest(request, path, maxFileSize, encType,
						new DefaultFileRenamePolicy());
		
		//DB에 파일의 정보를 저장하기 위해 데이터 추출하는 코드
		out.print("제목 : " + mr.getParameter("subject") + "<br/>");
		out.print("업로드한 파일명 : " + 
				mr.getOriginalFileName("upload") + "<br/>");
		out.print("서버에 저장된 파일명 : " +
				mr.getFilesystemName("upload") + "<br/>");
		out.print("파일타입 : " + mr.getContentType("upload") + "<br/>");
		
		File d = mr.getFile("upload");
		if(d!=null) {
			out.print("파일 크기 : " + d.length() + "<br/>");
		}
		
	}catch(Exception e) {
		
	}
			
			
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>


</body>
</html>