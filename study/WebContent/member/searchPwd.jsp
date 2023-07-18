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

	function searchPwd() {
		var f = document.myForm;
		
		if(!f.userId.value) {
			alert("아이디를 입력하세요.");
			f.userId.focus();
			return;
		}
		
		if(!f.userName.value) {
			alert("이름을 입력하세요.");
			f.userName.focus();
			return;
		}
		
		if(!f.userBirth.value) {
			alert("생년월일을 입력하세요.");
			f.userBirth.focus();
			return;
		}
		
		f.action = "<%=cp%>/join/searchPwd_ok.do";
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
			<td colspan="2" align="center"><b>비밀번호 찾기</b></td>
		</tr>
		
		<tr height="2">
			<td colspan="2" bgcolor="#cccccc"></td>
		</tr>
		
		<tr height="25">
			<td width="80" bgcolor="#e6e4e6" align="center">아이디</td>
			<td width="120" style="padding-left: 5px;">
			<input type="text" name="userId" maxlength="20" size="15"/>
			</td>
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
			<td width="80" bgcolor="#e6e4e6" align="center">생년월일</td>
			<td width="120" style="padding-left: 5px;">
			<input type="text" name="userBirth" maxlength="10" size="15"/>
			</td>
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
			<input type="button" value=" 확인 " class="btn2" onclick="searchPwd();"/>
			<input type="button" value=" 메인화면 " class="btn2" 
			onclick="location='<%=cp%>';"/>
			<input type="button" value=" 로그인화면 " class="btn2" 
			onclick="location='<%=cp%>/join/login.do';"/>
			</td>
		</tr>
	</table>
	</c:when>
	<c:when test="${not empty userPwd }">
	<table cellpadding="0" cellspacing="0" style="margin: auto;">
		<tr height="2">
			<td colspan="2" bgcolor="#cccccc"></td>
		</tr>
		
		<tr height="30">
			<td colspan="2" align="center"><b>비밀번호 찾기</b></td>
		</tr>
		
		<tr height="2">
			<td colspan="2" bgcolor="#cccccc"></td>
		</tr>
		
		<tr height="50">
			<td width="80" bgcolor="#e6e4e6" align="center">패스워드</td>
			<td width="120" style="padding-left: 5px;">
			${userId }님의 비밀번호는<br/> 
			${userPwd }<br/> 
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
			<input type="button" value=" 비밀번호 변경 " class="btn2" 
			onclick="location='<%=cp%>/join/updatePwd.do';"/>
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
			<td colspan="2" align="center"><b>비밀번호 찾기</b></td>
		</tr>
		
		<tr height="2">
			<td colspan="2" bgcolor="#cccccc"></td>
		</tr>
		
		<tr height="25">
			<td width="80" bgcolor="#e6e4e6" align="center">아이디</td>
			<td width="120" style="padding-left: 5px;">
			<input type="text" name="userId" maxlength="20" size="15"/>
			</td>
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
			<td width="80" bgcolor="#e6e4e6" align="center">생년월일</td>
			<td width="120" style="padding-left: 5px;">
			<input type="text" name="userBirth" maxlength="10" size="15"/>
			</td>
		</tr>
		
		<tr height="2">
			<td colspan="2" bgcolor="#cccccc"></td>
		</tr>
		
		<tr height="30">
			<td colspan="2" align="center">
			<input type="button" value=" 확인 " class="btn2" onclick="searchPwd();"/>
			<input type="button" value=" 메인화면 " class="btn2" 
			onclick="location='<%=cp%>';"/>
			<input type="button" value=" 비밀번호 변경 " class="btn2"
			onclick="location='<%=cp%>/join/updatePwd.do';"/>
			</td>
		</tr>
	</table>
	</c:otherwise>
</c:choose>


</form>
</body>
</html>