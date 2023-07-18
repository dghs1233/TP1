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
<title>개인정보 수정</title>
<link rel="stylesheet" type="text/css" href="<%=cp %>/member/css/style.css"/>
<link rel="stylesheet" type="text/css" href="<%=cp %>/member/css/created.css"/>
<script type="text/javascript" src="<%=cp%>/member/js/util.js"></script>
<script type="text/javascript">

	function update() {
		
		var f = document.myForm;
		
		str = f.userName.value;
		str = str.trim();
		
		if(!str) {
			alert("이름을 입력하세요!");
			f.userName.focus();
			return
		}
		
		f.userName.value = str;
		
		str = f.userBirth.value;
		str = str.trim();
		
		if(!str) {
			alert("생년월일을 입력하세요!");
			f.userBirth.focus();
			return
		}
		
		f.userBirth.value = str;
		
		str = f.userTel.value;
		str = str.trim();
		
		if(!str) {
			alert("전화번호를 입력하세요!");
			f.userTel.focus();
			return
		}
		
		f.userTel.value = str;
		
		str = f.userPwd.value;
		
		if(!str){
			alert("\n패스워드를 입력하세요.");
			f.userPwd.focus();
			return;
		}
		
		if(str!="${dto.userPwd }") {
			alert("패스워드가 틀립니다.");
			f.userPwd.focus();
			return;
		}
		
		f.userPwd.value = str;
		
		f.action = "<%=cp %>/join/updated_ok.do";
		f.submit();
		
	}

</script>
</head>
<body>

<br/><br/>

<div id="bbs">
	<div id="bbs_title">
	개인정보 수정
	</div>

	<form action="" method="post" name="myForm">
	<div id="bbsCreated">
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>아&nbsp;이&nbsp;디</dt>
				<dd>
				${dto.userId }
				</dd>
			</dl>
		</div>
		
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>이&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;름</dt>
				<dd>
				<input type="text" name="userName" size="35"
				maxlength="50" class="boxTF" value="${dto.userName }">
				</dd>
			</dl>
		</div>
		
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>생&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;일</dt>
				<dd>
				<input type="text" name="userBirth" size="35"
				maxlength="50" class="boxTF" value="${dto.userBirth }">[YYYY-MM-DD]
				</dd>
			</dl>
		</div>
		
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>전&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;화</dt>
				<dd>
				<input type="text" name="userTel" size="35"
				maxlength="50" class="boxTF" value="${dto.userTel }">
				</dd>
			</dl>
		</div>
		
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>패스워드</dt>
				<dd>
				<input type="password" name="userPwd" size="35"
				maxlength="50" class="boxTF">
				</dd>
			</dl>
		</div>
	</div>
	
	<div id="bbsCreated_footer">
	<input type="hidden" value="${dto.userId }" name="userId"/>
	<input type="button" value=" 수정하기 " class="btn2" onclick="update();"/>
	<input type="reset" value=" 재입력 " class="btn2"
	onclick="document.myForm.userName.focus()"/>
	<input type="button" value=" 수정취소 " class="btn2"
	onclick="location='<%=cp %>';">
	</div>
	
	</form>


</div>

</body>
</html>