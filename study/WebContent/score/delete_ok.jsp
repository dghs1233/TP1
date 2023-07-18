<%@page import="com.score.ScoreDAO"%>
<%@page import="com.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	String hak = request.getParameter("hak");
	
	Connection conn = DBConn.getConnection();
	ScoreDAO dao = new ScoreDAO(conn);
	
	int result = dao.deleteData(hak);
	
	response.sendRedirect("list.jsp");
%>
