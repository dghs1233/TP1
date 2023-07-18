<%@page import="com.util.MyUtil"%>
<%@page import="com.guest.GuestDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.guest.GuestDAO"%>
<%@page import="com.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	Connection conn = DBConn.getConnection();
	GuestDAO dao = new GuestDAO(conn);
	
	MyUtil myUtil = new MyUtil();
	
	int totalDataCount = 0;
	
	totalDataCount = dao.getDataCount();
	
	String pageNum = request.getParameter("pageNum");
	
	int currentPage = 1;
	
	if(pageNum!=null) {
		currentPage = Integer.parseInt(pageNum);
	}
	
	//페이지당 2개의 글만 보이게 할 것
	int numPerPage = 2;
	
	int totalPage = 0;
	
	//전체 페이지 수 구하기(데이터 총 갯수/numPerPage)
	if(totalDataCount!=0) {
		totalPage = myUtil.getPageCount(numPerPage, totalDataCount);
	}
	
	//데이터 삭제 시 페이지도 줄어들 수 있게 처리
	if(currentPage>totalPage) {
		currentPage = totalPage;
	}
	
	//해당 페이지의 게시글 시작 번호와 끝 번호
	int start = (currentPage-1) * numPerPage + 1;
	int end = currentPage * numPerPage;
	
	//List에 GuestDTO에 있는 데이터들 전부 넘겨놓음
	List<GuestDTO> lists = dao.getLists(start, end);
	
	String urlList = cp + "/guest/guest.jsp";
	
	String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, urlList);
	
	DBConn.close();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>방명록</title>

<link rel="stylesheet" type="text/css" href="<%=cp %>/guest/data/style.css"/>

<script type="text/javascript" src="<%=cp%>/guest/data/guest.js"></script>
<script type="text/javascript">

	//해당 자료를 삭제할지 말지 결정하도록 창 띄워줌
	function isDelete(num) {
		if(confirm("이 자료를 삭제하시겠습니까?")) {
			location.href="<%=cp %>/guest/delete.jsp?num=" + num;
		}
	}

</script>
</head>
<body>
<br/><br/>

<!-- style="margin: auto;를 주면 가운데 정렬 됨 -->
<table width="560" border="2" cellspacing="0" cellpadding="0"
	bordercolor="#d6d4a6" style="margin: auto;">
<tr height="40">
	<td style="padding-left: 20px">
	<b>방 명 록</b>
	</td>
</tr>
</table>
<br/>

<form action="" method="post" name="myForm">
<table width="560" border="0" cellpadding="3" cellspacing="0"
	style="margin:auto;">

<tr><td colspan="2" height="3" bgcolor="#dbdbdb" align="center"></td></tr>

<tr>
	<td width="20%" height="30" bgcolor="#eeeeee" style="padding-left: 20px;">
	작성자
	</td>
	<td width="80%" style="padding-left: 10px;">
	<input type="text" name="name" size="35" maxlength="20" class="boxTF"/>
	</td>
</tr>
<tr><td colspan="2" height="1" bgcolor="#dbdbdb"></td></tr>

<tr>
	<td width="20%" height="30" bgcolor="#eeeeee" style="padding-left: 20px;">
	E-Mail
	</td>
	<td width="80%" style="padding-left: 10px;">
	<input type="text" name="email" size="35" maxlength="50" class="boxTF"/>
	</td>
</tr>
<tr><td colspan="2" height="1" bgcolor="#dbdbdb"></td></tr>

<tr>
	<td width="20%" height="30" bgcolor="#eeeeee" style="padding-left: 20px;">
	홈페이지
	</td>
	<td width="80%" style="padding-left: 10px;">
	<input type="text" name="homepage" size="35" maxlength="20" 
	class="boxTF" value="http://"/>
	</td>
</tr>
<tr><td colspan="2" height="1" bgcolor="#dbdbdb"></td></tr>

<tr>
	<td width="20%" height="30" bgcolor="#eeeeee" 
	style="padding-left: 20px; padding-top: 5px;" valign="top">
	내&nbsp;&nbsp;&nbsp;&nbsp;용
	</td>
	<td width="80%" style="padding-left: 10px;">
	<textarea rows="7" cols="60" name="content" class="boxTA"
	style="resize: none; background-color: #ffffff"></textarea>
	</td>
</tr>
<tr><td colspan="2" height="3" bgcolor="#dbdbdb"></td></tr>
</table>

<table width="560" border="0" cellspacing="0" cellpadding="3" 
style="margin: auto;">
<tr align="center">
	<td height="40">
	<input type="button" value=" 등록하기 " class="btn1" onclick="sendIt();"/>
	<input type="reset" value=" 재입력하기 " class="btn1" 
	onclick="document.myForm.name.focus();"/>
	</td>
</tr>
</table>

</form>
<table width="560" border="0" cellpadding="0" cellspacing="0"
style="margin: auto;">
<tr><td height="3" bgcolor="#dbdbdb" align="center"></td></tr>
</table>

<!-- list에 들어간 데이터 갯수만큼 테이블 생성 -->
<%for(GuestDTO dto : lists){ %>
<table width="560" border="0" cellpadding="3" cellspacing="0"
	style="margin:auto;">

	<tr style="background-color: #eeeeee">
		<td width="50%" height="30" bgcolor="#eeeeee" align="left" style="padding-left: 5px;">
		<b>No <%=dto.getNum() %>. <%=dto.getName() %>
		
		<!-- mailto : 아웃룩 활용해서 메일 보내는 하이퍼링크 생성 -->
			<a href="mailto:<%=dto.getEmail() %>">(<%=dto.getEmail() %>)</a></b>
		</td>
		<td width="50%" align="right" style="padding-right: 5px;">
		<%if(!dto.getHomepage().equals("")) { %>
			홈페이지 : <a href="<%=dto.getHomepage() %>" target="_blank">
			<%=dto.getHomepage() %></a>
		<%}else {
			out.print("&nbsp;");
			}
 		%>
		</td>
	</tr>
	
	<tr style="background-color: #eeeeee">
		<td width="50%" height="30" bgcolor="#eeeeee" align="left" style="padding-left: 5px;">
		작성일 : <%=dto.getCreated() %> (<%=dto.getIpAddr() %>)
		</td>
		<td width="50%" align="right" style="padding-right: 5px;">
		<a href="javascript:isDelete('<%=dto.getNum() %>')">삭제</a>
		</td>
	</tr>
	
	<tr valign="top" style="background-color: #ffffff;">
		<td colspan="2" height="35" bgcolor="#ffffff" align="left" style="padding: 5px;">
		<%=dto.getContent().replaceAll("\r\n", "<br/>") %>
		</td>
	</tr>
	
	<tr><td colspan="2" height="3" bgcolor="#dbdbdb"></td></tr>
<%} %>

<!-- 저장된 데이터가 없는 경우 "등록된 자료가 없습니다" 출력 -->
<%if(totalDataCount==0) { %>
<table width="560" border="0" cellpadding="0" cellspacing="0"
bgcolor="#eeeeee" style="margin: auto;">
<tr align="center" height="50">
	<td><b>등록된 자료가 없습니다</b></td>
</tr>
</table>

<table width="560" border="0" cellpadding="0" cellspacing="0"
bgcolor="#eeeeee" style="margin: auto;">
<tr><td colspan="2" bgcolor="#dbdbdb" height="3"></td></tr>

<!-- 데이터가 있는 경우 페이징 처리 -->
<%}else{ %>


<table width="560" border="0" cellpadding="0" cellspacing="0"
bgcolor="#eeeeee" style="margin: auto;">
<tr align="center" height="30">
	<td><%=pageIndexList %></td>
</tr>
</table>
<%} %>
</table>
</body>
</html>