<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">

	function sendIt() {
		f = document.myForm;	
		
		if(!f.id.value) {
			alert("아이디를 입력하세요.")
			f.id.focus();
			return;
		}
		
		if(!f.pwd.value) {
			alert("비밀번호를 입력하세요.")
			f.pwd.focus();
			return;
		}
		
		if(!f.chk.checked) {
			alert("약관에 동의해주세요!!")
			return;
		}
		
		alert("회원가입 성공!");
		
		f.action = "test1_ok.jsp";
		f.submit();

	}
	
	function onlyNum() {
		//숫자 0~9까지
		if(event.keyCode<48||event.keyCode>57) {
			event.returnValue = false;
		}
	}
	
	function hangul() {
		//한글 
		if(event.keyCode<12592||event.keyCode>12687) {
			event.returnValue = false;
		}
	}

</script>
</head>
<body>

<form action="" method="post" name="myForm">

아이디: <input type="text" name="id"/><br/>
패스워드: <input type="password" name="pwd"/><br/>

<!-- 이름에 키보드를 누를 때 hangul(); 불러오기 -->
이름: <input type="text" name="name" onkeypress="hangul();">
성별: <input type="radio" name="gender" checked="checked" value="M"/>남자
<input type="radio" name="gender" value="F"/>여자<br/>
전화:
<select name="tel1">
	<option value="">선택</option>
	<option value="010">010</option>
	<option value="034">034</option>
	<option value="070">070</option>
</select>

<input type="text" name="tel2" onkeypress="onlyNum();"/>
<input type="text" name="tel3" onkeypress="onlyNum();"/><br/>

취미:
<select multiple="multiple" size="4" name="hobby">
	<option value="영화">영화</option>
	<option value="게임">게임</option>
	<option value="운동">운동</option>
	<option value="노래">노래</option>
</select><br/>

좋아하는 분야?<br/>
<input type="checkbox" name="type" value="정치">정치<br/>
<input type="checkbox" name="type" value="과학">과학<br/>
<input type="checkbox" name="type" value="사회">사회<br/>
<input type="checkbox" name="type" value="인문">인문<br/><br/>

동의합니까? <input type="checkbox" name="chk" value="Y"/><br/>
메모:
<textarea rows="5" cols="20" name="memo"></textarea><br/><br/>

<input type="button" value="회원가입" onclick="sendIt();"/>

<!-- document.myForm을 f로 쓸 수 없음 -->
<input type="reset" value="다시입력" onclick="document.myForm.id.focus();"/>
<input type="button" value="취소"/>


</form>

</body>
</html>