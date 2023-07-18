<%@page import="com.score.ScoreDTO"%>
<%@page import="com.score.ScoreDAO"%>
<%@page import="com.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>성적처리 입력</title>

<script type="text/javascript">

	function sendIt() {
		
		var f = document.myForm;
		
		f.action = "<%=cp %>/jumsu/update_ok.do";
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
bgcolor="#e4e4e4">
<tr height="50">
	<td bgcolor="#ffffff" style="padding-left: 10px";>
		<b>성적처리 수정</b>
	</td>
</tr>

</table>
<br/>

<form action="" method="post" name="myForm">

<table width="500" cellpadding="0" cellspacing="0" align="center">

<tr height="3"><td colspan="2" bgcolor="#cccccc"></td></tr>

<tr height="30">
	<td align="center" width="100" bgcolor="#e6e6e6">학번</td>
	<td style="padding-left: 5px;">
	${dto.hak }
	</td>
</tr>

<tr height="2"><td colspan="2" bgcolor="#cccccc"></td></tr>

<tr height="30">
	<td align="center" width="100" bgcolor="#e6e6e6">이름</td>
	<td style="padding-left: 5px;">
	${dto.name }
	</td>
</tr>

<tr height="2"><td colspan="2" bgcolor="#cccccc"></td></tr>

<tr height="30">
	<td align="center" width="100" bgcolor="#e6e6e6">국어</td>
	<td style="padding-left: 5px;">
	<input type="text" name="kor" size="20" maxlength="3" 
	class="txtField" value="${dto.kor }"/>
	</td>
</tr>

<tr height="2"><td colspan="2" bgcolor="#cccccc"></td></tr>

<tr height="30">
	<td align="center" width="100" bgcolor="#e6e6e6">영어</td>
	<td style="padding-left: 5px;">
	<input type="text" name="eng" size="20" maxlength="3" 
	class="txtField" value="${dto.eng }"/>
	</td>
</tr>

<tr height="2"><td colspan="2" bgcolor="#cccccc"></td></tr>

<tr height="30">
	<td align="center" width="100" bgcolor="#e6e6e6">수학</td>
	<td style="padding-left: 5px;">
	<input type="text" name="mat" size="20" maxlength="3" 
	class="txtField" value="${dto.mat }"/>
	</td>
</tr>

<tr height="3"><td colspan="2" bgcolor="#cccccc"></td></tr>

<tr height="35">
	<td align="center" colspan="2">
	
	<!-- hidden으로 hak 데이터를 넘겨줘야 수정이 완료 됨 -->
	<input type="hidden" name="hak" value="${dto.hak }">
	<input type="button" class="btn" value="수정완료" onclick="sendIt();">
	<input type="button" class="btn" value="수정취소"
		onclick="javascript:location.href='<%=cp %>/jumsu/list.do';">
	</td>
</tr>
</table>


</form>

</body>
</html>