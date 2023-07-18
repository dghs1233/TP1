<%@page import="com.naver.NaverDTO"%>
<%@page import="com.naver.NaverDAO"%>
<%@page import="com.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	//주소 가져오기
	String cp = request.getContextPath();
	
	String userId = request.getParameter("userId");
	Connection conn = DBConn.getConnection();
	NaverDAO dao = new NaverDAO(conn);
	
	NaverDTO dto = dao.getReadData(userId);
	
	DBConn.close();
	
	if(dto==null) {
		response.sendRedirect(cp + "/naver/list.jsp");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>성적처리 입력</title>

<script type="text/javascript">

	function sendIt() {
		
		var f = document.myForm;
		
		f.action = "<%=cp %>/naver/update_ok.jsp";
		f.submit();
	
	}

</script>
<style type="text/css">

body {
	font-size: 9pt;
}

td {
	font-size: 9pt;
}

.txtField {
	font-size: 9pt;
	border: 1px solid;
}

.btn {
	font-size: 9pt;
	background: #e6e6e6;
}

</style>
</head>
<body>

<br/><br/>

<table border="1" width="500" cellpadding="0" cellspacing="0" align="center"
bgcolor="#ccffcc">
<tr height="50">
	<td bgcolor="#e6e6fa" style="padding-left: 10px";>
		<b>계정정보 수정</b>
	</td>
</tr>

</table>
<br/>

<form action="" method="post" name="myForm">

<table width="500" cellpadding="0" cellspacing="0" align="center">

<tr height="3"><td colspan="2" bgcolor="#cccccc"></td></tr>

<tr height="30">
	<td align="center" width="100" bgcolor="#e6e6fa">아이디</td>
	<td style="padding-left: 5px;">
	<%=dto.getUserId() %>
	</td>
</tr>

<tr height="2"><td colspan="2" bgcolor="#cccccc"></td></tr>

<tr height="30">
	<td align="center" width="100" bgcolor="#e6e6fa">비밀번호</td>
	<td style="padding-left: 5px;">
	<%=dto.getPwd() %>
	</td>
</tr>

<tr height="2"><td colspan="2" bgcolor="#cccccc"></td></tr>

<tr height="30">
	<td align="center" width="100" bgcolor="#e6e6fa">이메일</td>
	<td style="padding-left: 5px;">
	<input type="text" name="email" size="20" maxlength="20" 
	class="txtField" value="<%=dto.getEmail()%>"/>
	</td>
</tr>

<tr height="2"><td colspan="2" bgcolor="#cccccc"></td></tr>

<tr height="30">
	<td align="center" width="100" bgcolor="#e6e6fa">이름</td>
	<td style="padding-left: 5px;">
	<%=dto.getName() %>
	</td>
</tr>

<tr height="2"><td colspan="2" bgcolor="#cccccc"></td></tr>

<tr height="30">
	<td align="center" width="100" bgcolor="#e6e6fa">통신사</td>
	<td style="padding-left: 5px;">
	<input type="text" name="telecom" size="20" maxlength="20" 
	class="txtField" value="<%=dto.getTelecom() %>"/>
	</td>
</tr>

<tr height="2"><td colspan="2" bgcolor="#cccccc"></td></tr>

<tr height="30">
	<td align="center" width="100" bgcolor="#e6e6fa">성별</td>
	<td style="padding-left: 5px;">
	<%=dto.getSex()%>
	</td>
</tr>

<tr height="2"><td colspan="2" bgcolor="#cccccc"></td></tr>

<tr height="30">
	<td align="center" width="100" bgcolor="#e6e6fa">외국인 여부</td>
	<td style="padding-left: 5px;">
	<input type="text" name="foreigner" size="20" maxlength="5" 
	class="txtField" value="<%=dto.getForeigner() %>"/>
	</td>
</tr>

<tr height="2"><td colspan="2" bgcolor="#cccccc"></td></tr>

<tr height="30">
	<td align="center" width="100" bgcolor="#e6e6fa">전화번호</td>
	<td style="padding-left: 5px;">
	<input type="text" name="phone" size="20" maxlength="13" 
	class="txtField" value="<%=dto.getPhone()%>"/>
	</td>
</tr>

<tr height="3"><td colspan="2" bgcolor="#cccccc"></td></tr>

<tr height="35">
	<td align="center" colspan="2">
	
	<!-- hidden으로 hak 데이터를 넘겨줘야 수정이 완료 됨 -->
	<input type="hidden" name="userId" value="<%=dto.getUserId() %>">
	<input type="button" class="btn" value="수정완료" onclick="sendIt();">
	<input type="button" class="btn" value="수정취소"
		onclick="javascript:location.href='<%=cp %>/naver/list.jsp';">
	</td>
</tr>
</table>


</form>

</body>
</html>