<%@page import="com.util.DBConn"%>
<%@page import="com.guest.GuestDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<jsp:useBean id="dto" class="com.guest.GuestDTO" scope="page"/>
<jsp:setProperty property="*" name="dto"/>

<%
	GuestDAO dao = new GuestDAO(DBConn.getConnection());

	//최대값 읽어옴
	int maxNum = dao.getMaxNum();
	
	//DB에 있는 num 최대값에 +1해서 넣어줌
	dto.setNum(maxNum + 1);
	
	//방문자 IP 기입
	dto.setIpAddr(request.getRemoteAddr());

	dao.insertData(dto);
	
	DBConn.close();
	
	//곧장 guest.jsp 페이지로 가게 함
	response.sendRedirect(cp + "/guest/guest.jsp");
	
%>