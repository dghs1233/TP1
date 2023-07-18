<%@page import="com.mail.MailSend"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	String root = getServletContext().getRealPath("/");
	String path = root + "pds" + File.separator + "mailFile";
	
	File f = new File(path);
	if(!f.exists()) {
		f.mkdirs();
	}
	
	String encType = "UTF-8";
	int maxFileSize = 10*1024*1024;
	
	//파일 업로드
	MultipartRequest mr = 
			new MultipartRequest(request, path, maxFileSize, encType,
					new DefaultFileRenamePolicy());
	
	//
	MailSend mail = new MailSend();
	
	mail.setSenderName(mr.getParameter("senderName"));
	mail.setSenderEmail(mr.getParameter("senderEmail"));
	mail.setReceiverEmail(mr.getParameter("receiverEmail"));
	mail.setSubject(mr.getParameter("subject"));
	mail.setContent(mr.getParameter("content"));
	
	String fileName = mr.getFilesystemName("upload");
	
	if(fileName!=null && !fileName.equals("")) {
		String fileFullPath = path + File.separator + fileName;
		
		mail.setFileFullPath(fileFullPath);
		mail.setOriginalFileName(mr.getOriginalFileName("upload"));
	}
	
	boolean flag = mail.sendMail();
	
	if(flag) {
		
		mail.sendMail();
		
		out.print("메일 전송 완료!!");
	
	}
%>