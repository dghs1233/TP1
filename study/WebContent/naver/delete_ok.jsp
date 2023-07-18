<%@page import="com.naver.NaverDAO"%>
<%@page import="com.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	String userId = request.getParameter("userId");
	
	Connection conn = DBConn.getConnection();
	NaverDAO dao = new NaverDAO(conn);
	
	int result = dao.deleteData(userId);
	
	response.sendRedirect(cp + "/naver/list.jsp");
%>
