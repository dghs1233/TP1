<%@page import="com.naver.NaverDAO"%>
<%@page import="com.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<jsp:useBean id="dto" class="com.naver.NaverDTO" scope="page"/>

<!-- 변수명과 일치하는 데이터 전부 받아서 dto에 set -->
<jsp:setProperty property="*" name="dto"/>

<%

	//연결자 생성
	Connection conn = DBConn.getConnection();

	//DAO에 연결자 넣어주어 객체 생성(의존성 주입)
	NaverDAO dao = new NaverDAO(conn);
	
	int result = dao.insertData(dto);
	
	//닫아줘야 함
	DBConn.close();
	
	if(result!=0) {
		//리다이렉트 해서 처리화면 보여줌
		response.sendRedirect(cp + "/naver/list.jsp");
	}else {
		response.sendRedirect(cp + "/naver/naverJoin.jsp");
	}

%>
