<%@page import="com.score.ScoreDAO"%>
<%@page import="com.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<jsp:useBean id="dto" class="com.score.ScoreDTO" scope="page"/>
<jsp:setProperty property="*" name="dto"/>

<%

	Connection conn = DBConn.getConnection();
	ScoreDAO dao = new ScoreDAO(conn);
	
	int result = dao.updateData(dto);
	
	DBConn.close();
	
	response.sendRedirect(cp + "/score/list.jsp");

	//_ok에는 html 아예 안씀(리다이렉트로 필요가 없음)
%>
