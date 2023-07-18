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
<title>비밀번호 찾기</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/member/css/style.css"/>
<script type="text/javascript">

	function searchId() {
		var f = document.myForm;
		
		if(!f.userName.value) {
			alert("이름을 입력하세요.");
			f.userName.focus();
			return;
		}
		
		if(!f.userTel.value) {
			alert("전화번호를 입력하세요.");
			f.userTel.focus();
			return;
		}
		
		f.action = "<%=cp%>/join/searchId_ok.do";
		f.submit();
		
	}

</script>
</head>
<body>

<br/><br/>

<form action="" method="post" name="myForm">
<c:choose>
	<c:when test="${not empty message }">
	<table cellpadding="0" cellspacing="0" style="margin: auto;">
		<tr height="2">
			<td colspan="2" bgcolor="#cccccc"></td>
		</tr>
		
		<tr height="30">
			<td colspan="2" align="center"><b>아이디 찾기</b></td>
		</tr>
		
		<tr height="2">
			<td colspan="2" bgcolor="#cccccc"></td>
		</tr>
		
		<tr height="25">
			<td width="80" bgcolor="#e6e4e6" align="center">이름</td>
			<td width="120" style="padding-left: 5px;">
			<input type="text" name="userName" maxlength="20" size="15"/>
			</td>
		</tr>
		
		<tr height="2">
			<td colspan="2" bgcolor="#cccccc"></td>
		</tr>
		
		<tr height="25">
			<td width="80" bgcolor="#e6e4e6" align="center">전화번호</td>
			<td width="120" style="padding-left: 5px;">
			<input type="text" name="userTel" maxlength="20" size="15"/>
			</td>
		</tr>
		
		<tr height="2">
			<td colspan="2" bgcolor="#cccccc"></td>
		</tr>
		
		<tr height="2">
			<td colspan="2" bgcolor="#cccccc"></td>
		</tr>
				
		<tr height="30">
			<td colspan="2" align="center">
			<font color="red"><b>${message }</b></font><br/>
			</td>
		</tr>
		
		<tr height="30">
			<td colspan="2" align="center">
			<input type="button" value=" 확인 " class="btn2" onclick="searchId();"/>
			<input type="button" value=" 취소 " class="btn2" 
			onclick="location='<%=cp%>';"/>
			<input type="button" value=" 로그인화면 " class="btn2" 
			onclick="location='<%=cp%>/join/login.do';"/>
			</td>
		</tr>
	</table>
	</c:when>
	<c:when test="${not empty userId }">
	<table cellpadding="0" cellspacing="0" style="margin: auto;">
		<tr height="2">
			<td colspan="2" bgcolor="#cccccc"></td>
		</tr>
		
		<tr height="30">
			<td colspan="2" align="center"><b>아이디 찾기</b></td>
		</tr>
		
		<tr height="2">
			<td colspan="2" bgcolor="#cccccc"></td>
		</tr>
		
		<tr height="50">
			<td width="80" bgcolor="#e6e4e6" align="center">아이디</td>
			<td width="120" style="padding-left: 5px;">
			${userName }님의 아이디는<br/> 
			${userId }<br/> 
			입니다.
			</td>
		</tr>
		
		<tr height="2">
			<td colspan="2" bgcolor="#cccccc"></td>
		</tr>
		
		<tr height="30">
			<td colspan="2" align="center">
			<input type="button" value=" 로그인화면 " class="btn2" 
			onclick="location='<%=cp%>/join/login.do';"/>
			<input type="button" value=" 메인화면 " class="btn2" 
			onclick="location='<%=cp%>';"/>
			</td>
		</tr>
	</table>
	</c:when>
	<c:otherwise>
	<table cellpadding="0" cellspacing="0" style="margin: auto;">
		<tr height="2">
			<td colspan="2" bgcolor="#cccccc"></td>
		</tr>
		
		<tr height="30">
			<td colspan="2" align="center"><b>아이디 찾기</b></td>
		</tr>
		
		<tr height="2">
			<td colspan="2" bgcolor="#cccccc"></td>
		</tr>
		
		<tr height="25">
			<td width="80" bgcolor="#e6e4e6" align="center">이름</td>
			<td width="120" style="padding-left: 5px;">
			<input type="text" name="userName" maxlength="20" size="15"/>
			</td>
		</tr>
		
		<tr height="2">
			<td colspan="2" bgcolor="#cccccc"></td>
		</tr>
		
		<tr height="25">
			<td width="80" bgcolor="#e6e4e6" align="center">전화번호</td>
			<td width="120" style="padding-left: 5px;">
			<input type="text" name="userTel" maxlength="20" size="15"/>
			</td>
		</tr>
		
		<tr height="2">
			<td colspan="2" bgcolor="#cccccc"></td>
		</tr>
		
		<tr height="30">
			<td colspan="2" align="center">
			<input type="button" value=" 확인 " class="btn2" onclick="searchId();"/>
			<input type="button" value=" 메인화면 " class="btn2" 
			onclick="location='<%=cp%>';"/>
			</td>
		</tr>
	</table>
	</c:otherwise>
</c:choose>

</form>
</body>
</html>