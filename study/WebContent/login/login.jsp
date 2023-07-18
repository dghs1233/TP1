<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	//session에 있는 userId를 가져와서 object 형태인 userId를 String으로 다운캐스팅
	String userId = (String)session.getAttribute("userId");
	session.setMaxInactiveInterval(10*60);
	int sTime = session.getMaxInactiveInterval() / 60;
	String str = String.format("%d", sTime);
	
	//자동 로그아웃 시간 10분 설정
	//session.setMaxInactiveInterval(10*60);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인</title>

<script type="text/javascript">

	function sendIt() {
		
		var f = document.myForm;
		
		if(!f.userId.value) {
			alert("아이디 입력!");
			f.userId.focus();
			return;
		}
		
		if(!f.userPwd.value) {
			alert("아이디 입력!");
			f.userPwd.focus();
			return;
		}
		
		f.submit();
		
	}

	function loginAlert() {
		
		var f = document.myForm;

		alert("로그인부터 해주세요!");
		f.userId.focus();
		return;
	}

	function schedule() {
		alert("일정관리를 통해 효율적으로 시간을 활용하세요!");
	}
</script>

</head>
<body style="font-size: 10pt;">

<table border="1" width="600" align="center" style="font-size: 10pt">

<tr height="20">
	<td colspan="2" align="right">
	|
	<%if(userId==null) {%>
	<a href="login.jsp" onclick="loginAlert();">메시지</a>
	<%}else{ %>
	<a href="login.jsp" value="messenger">메시지</a>
	<%} %>
	|
	<%if(userId==null) {%>
	<a href="login.jsp" onclick="loginAlert();">일정관리</a>
	<%}else{ %>
	<a href="schedule.jsp" onclick="schedule();">일정관리</a>
	<%} %>
	|
	</td>
</tr>

<tr height="400">
	<td width="100" valign="top">
	<%if(userId==null) {%>
	<form action="login_ok.jsp" method="post" name="myForm">
		아이디 : <input type="text" name="userId" size="10"/><br/>
		패스워드 : <input type="password" name="userPwd" size="10"/><br/>
		<input type="button" value="로그인" onclick="sendIt();">
	</form>
	<%}else{ %>
	<%=userId %>
	님 방가방가<br/>
	<a href="logout.jsp">로그아웃</a><br/><br/>
	세션 유효시간은 <font color="red"><%=sTime %>분</font> 입니다.
	
	<%} %>
	</td>
	<td valign="middle" align="center">
	<%if(userId==null) {%>
		<b>로그인하면 새로운 세상이 보입니다</b>
	<%}else{ %>
		<!-- <font color="red"><b>새로운 세상입니다.</b></font> -->
		<%@ include file="calendar.jsp" %>
	<%} %>
	</td>
</tr>

</table>


</body>
</html>