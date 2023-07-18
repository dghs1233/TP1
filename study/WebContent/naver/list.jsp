<%@page import="com.naver.NaverDTO"%>
<%@page import="com.naver.NaverDAO"%>
<%@page import="java.util.List"%>
<%@page import="com.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();

	NaverDAO dao = new NaverDAO(DBConn.getConnection());
	
	List<NaverDTO> lists = dao.getlists();
	
	DBConn.close();
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>계정정보 리스트</title>

<style type="text/css">

body {
	font-size: 9pt;
}

td {
	font-size: 9pt;
}

.btn {
	font-size: 9pt;
	background: #e6e6e6;
}

a {
	text-decoration: none;
	color: blue;
}

a:hover, a:active {
	font-size: 9pt;
	color: #f28011;
	text-decoration: underline;
}

</style>

</head>
<body>
<br/><br/>

<table border="1" bordercolor="#ffffff" width="800" cellpadding="0" cellspacing="0" align="center" 
bgcolor="#e4e4e4">
<tr height="50">
	<td bgcolor="#ccffcc" style="padding-left: 10px;">
		<b>계정정보 리스트</b>
	</td>
</tr>
</table>

<table width="700" cellpadding="0" cellspacing="0" align="center"
bgcolor="#ffffff">
<tr height="50">
	<td align="right">
	<input type="button" class="btn" value="계정등록하기" 
	onclick="location='<%=cp %>/naver/naverJoin.jsp';"/>
	</td>
</tr>
</table>

<table border="1" bordercolor="#ffffff" width="800" cellpadding="0" cellspacing="0" align="center"
bgcolor="#e6e6fa">
<tr height="30">
	<td align="center" bgcolor="#e6e6fa" width="90">아이디</td>
	<td align="center" bgcolor="#e6e6fa" width="90">비밀번호</td>
	<td align="center" bgcolor="#e6e6fa" width="120">이메일</td>
	<td align="center" bgcolor="#e6e6fa" width="80">이름</td>
	<td align="center" bgcolor="#e6e6fa" width="70">생년월일</td>
	<td align="center" bgcolor="#e6e6fa" width="70">통신사</td>
	<td align="center" bgcolor="#e6e6fa" width="40">성별</td>
	<td align="center" bgcolor="#e6e6fa" width="70">외국인 여부</td>
	<td align="center" bgcolor="#e6e6fa" width="110">전화번호</td>
	<td align="center" bgcolor="#e6e6fa" width="100">수정</td>
</tr>

<!-- 데이터 갯수만큼 행이 만들어짐 -->
<%for(NaverDTO dto : lists) { %>
<tr height="30" bordercolor="#e6e6fa">
	<td align="center" bgcolor="#f8fff5"><%=dto.getUserId() %></td>
	<td align="center" bgcolor="#f8fff5"><%=dto.getPwd() %></td>
	<td align="center" bgcolor="#f8fff5"><%=dto.getEmail() %></td>
	<td align="center" bgcolor="#f8fff5"><%=dto.getName() %></td>
	<td align="center" bgcolor="#f8fff5"><%=dto.getBirth() %></td>
	<td align="center" bgcolor="#f8fff5"><%=dto.getTelecom() %></td>
	<td align="center" bgcolor="#f8fff5"><%=dto.getSex() %></td>
	<td align="center" bgcolor="#f8fff5"><%=dto.getForeigner() %></td>
	<td align="center" bgcolor="#f8fff5"><%=dto.getPhone() %></td>
	<td align="center" bgcolor="#ffffff">
	
	<!-- 필요한 데이터는 가지고 넘어감 -->
	<a href="<%=cp %>/naver/update.jsp?userId=<%=dto.getUserId() %>">수정</a> 
	
	<a href="<%=cp %>/naver/delete_ok.jsp?userId=<%=dto.getUserId() %>">삭제</a>
	</td>
</tr>		
<%} %>	


</table>
</body>
</html>