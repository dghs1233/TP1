<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width">
<title>네이버 : 회원가입</title>
<link rel="stylesheet" type="text/css" 
href="http://192.168.16.21:8080/study/css/naver.css"/>

<script type="text/javascript">

	function verifyCheck() {
		
		var f = document.myForm;
		
		//body에 있는 myForm에서 id의 값이 null이면
		if(!f.id.value){
			alert("아이디를 입력하세요");
			f.id.focus();
			return;
		}
		
		//body에 있는 myForm에서 pwd의 값이 null이면
		if(!f.pwd.value) {
			alert("비밀번호를 입력하세요");
			f.pwd.focus();
			return;
		}
		
		//body에 있는 myForm에서 email의 값이 null이면
		if(!f.email.value) {
			alert("이메일 주소를 입력하세요");
			f.email.focus();
			return;
		}
		
		//body에 있는 myForm에서 name의 값이 null이면
		if(!f.name.value) {
			alert("이름을 입력하세요");
			f.name.focus();
			return;
		}
		
		//body에 있는 myForm에서 birth의 값이 null이면
		if(!f.birth.value) {
			alert("생년월일을 입력하세요");
			f.birth.focus();
			return;
		}
		
		//body에 있는 myForm에서 telecom의 값이 null이면
		
		if(!f.telecom.value) {
			alert("통신사를 선택하세요");
			f.telecom.focus();
			return;
		}
		
		//body에 있는 myForm에서 sex의 값이 null이면
		var clength = document.myForm.sex.length;
		var sexData;
		
		for(var i=0;i<clength;i++) {
			//document의 myForm에 sul의 i번째 값이 체크되어있으면
			//==true는 안적어줘도 됨
			if(f.sex[i].checked) {
				sexData = f.sex[i].value;
			}
			if(!sexData){
				alert("성별을 선택하세요")
				return;
			}
			
		}
		
		//body에 있는 myForm에서 sex의 값이 null이면
		var clength = document.myForm.foreigner.length;
		var foreignerData;
		
		for(var i=0;i<clength;i++) {
			//document의 myForm에 sul의 i번째 값이 체크되어있으면
			//==true는 안적어줘도 됨
			if(f.foreigner[i].checked) {
				foreignerData = f.foreigner[i].value;
			}
			if(!foreignerData){
				alert("외국인 여부를 선택하세요")
				return;
			}
		}
		
		//body에 있는 myForm에서 phone의 값이 null이면
		if(!f.phone.value) {
			alert("휴대전화번호를 입력하세요");
			f.phone.focus();
			return;
		}
		
		//body에 있는 myForm에서 agree의 값이 null이면
		if(!f.agree.checked) {
			alert("약관 동의에 체크해주세요");
			f.agree.focus();
			return;
		}
		
		alert(f.id.value + " 회원가입 성공!!");
		
	}

</script>
</head>
<body>

<form action="" name="myForm">

<table width="450px" align="center">
	<tr>
		<td align="left">
		<a href="https://www.naver.com"><img src="./image/naver_icon.gif"/></a>
		</td>
	</tr>
</table>

<br/>
<br/>

<table width="450px" align="center" style="font-size: 12pt; border-radius: 5px" 
	border="1" bordercolor="#777" cellpadding="0" cellspacing="0">
	
<tr height="48">
	<td colspan="2" valign="middle"><img src="./image/naver_id.gif" align="middle"/>
		<input type="text" name="id" placeholder="아이디" style="background-color: #11ffee00; 
			width: 60%; height: 50%; align: middle;"/>@naver.com
	</td>
</tr>

<tr height="48">
	<td colspan="2" valign="middle"><img src="./image/naver_pw.gif" align="middle"/>
		<input type="password" name="pwd" placeholder="비밀번호" style="background-color: #11ffee00; 
			width: 60%; height: 50%;" align: middle;" >
	</td>
</tr>

<tr height="48">
	<td colspan="2" valign="middle"><img src="./image/naver_email.gif" align="middle"/>
	<input type="text" name="email" placeholder="[선택] 비밀번호 분실 시 확인용 이메일" style="background-color: #11ffee00; 
	width: 60%; height: 50%;" align: middle;" >
	</td>
</tr>

</table>

<br/>

<!-- 입력 안하면 글자 출력할 테이블 -->
<table width="450px" align="center" style="font-size: 12pt;"/>
<tr align="left"></tr>
</table>

<table width="450px" align="center" style="font-size: 10pt; border-radius: 5px" 
	border="1" bordercolor="#777" cellpadding="0" cellspacing="0">
	
<tr height="48">
	<td colspan="2" valign="middle"><img src="./image/naver_id.gif" align="middle" />
	<input type="text" name="name" placeholder="이름" style="background-color: #11ffee00; 
	width: 60%; height: 50%; align: middle;">
	</td>
</tr>

<tr height="48">
	<td colspan="2" valign="middle"><img src="./image/naver_birth.gif" align="middle"/>
	<input type="text" name="birth" placeholder="생년월일 8자리" style="background-color: #11ffee00; 
	width: 60%; height: 50%;" align="middle">
	</td>
</tr>

<tr height="48">
	<td colspan="2" valign="middle"><img src="./image/naver_telecom.gif" align="middle"/>
	<select name="telecom" style="background-color: #11ffee00; width: 90%; color: #777;">
	<option value="">통신사 선택</option>
	<option value="SKT">SKT</option>
	<option value="KT">KT</option>
	<option value="LG_U+">LG U+</option>
	<option value="SKT_알뜰폰">SKT 알뜰폰</option>
	<option value="KT_알뜰폰">KT 알뜰폰</option>
	<option value="LG_U+_알뜰폰">LG U+ 알뜰폰</option>
	</select>
	</td>
</tr>

<tr height="48">
	<td valign="middle" align="center">
		<input type="radio" name="sex" value="male">
		<font color="#777">남자</font>
		<input type="radio" name="sex" value="female">
		<font color="#777">여자</font>
		
		<input type="radio" name="foreigner" value="local"
			style="background-color: #777;">
		<font color="#777">내국인</font>
		<input type="radio" name="foreigner" value="foreigner">
		<font color="#777">외국인</font>
	</td>
</tr>

<tr height="48">
	<td colspan="2" valign="middle"><img src="./image/naver_phone.gif" align="middle"/>
	<input type="text" name="phone" placeholder="휴대전화번호" style="background-color: #11ffee00; 
	width: 60%; height: 50%; align: middle;">
	</td>
</tr>

</table>

<br/>

<table width="450px" align="center" style="font-size: 10pt; border-radius: 5px" 
	 cellpadding="0" cellspacing="0">

<tr height="48" border="1" bordercolor="#777">
	<td valign="middle"><input type="checkbox" name="agree" align="middle"/>
	<font color="green"><b>[필수]</b></font>
	<font color="white"><b>인증 약관 전체동의</b></font></td>
	<td border="0"><select style="background-color: #11ffee00; width: 90%; color: #777;">통신사 선택
	<option>개인정보 이용</option>
	<option>통신사 이용약관</option>
	<option>네이버 개인정보 수집</option>
	<option>고유식별정보 처리</option>
	<option>인증사 이용약관</option>
	</select>
	</td>
</tr>

<tr align="right">
	<td colspan="2" valign="middle">
		실명인증된 아이디로 가입<input type="button"/>
	</td>
</tr>

</table>

<br/>

<table width="450px" align="center" style="font-size: 12pt;" 
	 cellpadding="0" cellspacing="0">

<tr>
	<td width="55%" valign="bottom" align="center">
		<a href="javascript: verifyCheck()"><img src="./image/naver_verify.gif"/ width="500px"></a>
	</td>
</tr>

</table>
</form>
</body>
</html>