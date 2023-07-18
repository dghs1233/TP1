<%@page import="java.net.URLDecoder"%>
<%@page import="com.board.BoardDAO"%>
<%@page import="com.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	String searchKey = request.getParameter("searchKey");
	String searchValue = request.getParameter("searchValue");
	
	if(searchValue!=null) {
		
		//get방식으로 넘어오면 한글이 깨지므로 처리
		if(request.getMethod().equalsIgnoreCase("GET")) {
			searchValue = URLDecoder.decode(searchValue, "UTF-8");
		}
			
	//검색 안했으면 searchKey의 기본값은 subject, searchValue의 기본값은 null
	//전체 데이터 보여주도록 함
	}else {
		searchKey = "subject";
		searchValue = "";
	}
	Connection conn = DBConn.getConnection();
	BoardDAO dao = new BoardDAO(conn);
	
	dao.deleteData(num);
	
	DBConn.close();
	
	response.sendRedirect("list.jsp?searchKey=" + searchKey + "&searchValue=" + searchValue + "&pageNum=" + pageNum + "&num=" + num);
%>