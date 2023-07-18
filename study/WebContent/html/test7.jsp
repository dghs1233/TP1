<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<table height="400px">
<tr>
	<td><img src="./image/tit_h1_0201.gif"/></td>
</tr>
<tr height="1">
	<td colspan="2" bgcolor="#dad6d7"></td>
</tr>
</table>

<table style="font-size: 10pt; font-family: 돋움;" cellpadding="3">
<tr>
	<td><b>이름</b></td>
	<td><input type="text"></td>
</tr>

<tr>
	<td><b>주민등록번호</b></td>
	<td><input type="text" size="12">-<input type="text" size="12"></td>
</tr>

<tr height="1">
	<td colspan="2" bgcolor="#dad6d7"></td>
</tr>

<tr>
	<td align="center" colspan="2"><img src="./image/btn_ok01.gif"></td>
</tr>
</table>

<hr/>

<table style="font-size: 10pt; font-family: 돋움;" cellpadding="3">
<tr>
	<td><b>아이디</b></td>
	<td><input type="text" style="width: 100px;height: 22px;"></td>
	<td></td>
</tr>

<tr>
	<td><b>아이디</b></td>
	<td><input type="text" style="width: 100px;height: 22px;"></td>
	<td><img src="./image/btn_login.gif"></td>
</tr>

<tr>
	<td colspan="3" align="center">
		<input type="checkbox">아이디 저장
		<input type="checkbox">보안 접속
	</td>
</tr>

<tr height="1">
	<td colspan="3" bgbgcolor="#dad6d7"></td>
</tr>
</table>

<hr/>

<table background="./image/bg_575x84.gif" width="575" height="84">
<tr>
	<td align="center">
	<table style="font-size: 10pt; font-family: 돋움;" cellpadding="3">
	<tr>
		<td>
			<input type="text" style="width: 300px; height: 22px;">
			<img src="./image/btn_search.gif" align="top">
		</td>
	</tr>
	
	<!-- radio타입은 하나만 선택 가능(라디오 주파수) -->
	<!-- name으로 묶음 설정 -->
	<tr>
			<td align="center">
				<input type="radio" name="r1">
				<font color="#339900"><b>카페명</b></font>
				<input type="radio" name="r1">
				<font color="#339900"><b>게시물</b></font>
				<input type="radio" name="r1">
				<font color="#339900"><b>관리자/ID</b></font>
			</td>
	</table>
</tr>

</table>

<br/>
<hr color="red"/>
<br/>

<table style="font-size: 10pt; font-family: 돋움;" cellpadding="3">
<tr>
	<td>
		희망 훈련 직종 안내 메일 서비스<br/>
		<font color="#afafaf">(아래 내용을 선택하시면 매월 15일에 
		맞춤 훈련 계획 정보를 메일로 전송해 드립니다.)</font>
	</td>
</tr>

<tr>
	<td><img src="./image/bull_02.gif" align="middle">
	희망(관심분야 훈련직종) (1개 이상, 3개 이하로 선택하세요)
	</td>
</tr>
</table>

<!-- 체크박스 -->
<table style="font-size: 10pt;font-family: 돋움;color: #5e5e5e" 
cellpadding="3">
<tr>
	<td width="10"></td>
	<td width="150">
		<input type="checkbox">농림, 어업, 광업<br/>
		<input type="checkbox">금속<br/>
		<input type="checkbox">전기<br/>
		<input type="checkbox">운송장비제조<br/>
		<input type="checkbox">서비스<br/>
		<input type="checkbox">의료<br/>
	</td>
	
	<td width="150">
		<input type="checkbox">섬유<br/>
		<input type="checkbox">기계장비<br/>
		<input type="checkbox">전자<br/>
		<input type="checkbox">산업응용<br/>
		<input type="checkbox">사무관리<br/>
		<input type="checkbox">환경<br/>
	</td>
	
	<td width="150">
		<input type="checkbox">화학제품<br/>
		<input type="checkbox">건설<br/>
		<input type="checkbox">정보통신<br/>
		<input type="checkbox">공예<br/>
		<input type="checkbox">금융, 보험, 증권<br/>
		<input type="checkbox">계층별 훈련분야<br/>
	</td>
</tr>
</table>

<br/>
<hr color="red"/>
<br/>

<!-- 파일 업로드 -->
<input type="file"
style="border-style: solid; border-width: 1px; border-color: #aaaaaa;
width: 400px; font-size: 10px">

<br/>
<hr color="red"/>
<br/>

<select>
	<option>선택</option>
	<option>010</option>
	<option>070</option>
	<option>001</option>
	<option>007</option>
</select>

<input type="text" size="4">

<input type="text" size="4"><br/>

<br/><br/>

<!-- multiple을 통해 여러개 선택 -->
<select multiple="multiple" size="4">
	<option>배수지</option>
	<option>유인나</option>
	<option>정인선</option>
	<option>박신혜</option>
</select>

<textarea rows="10" cols="20"></textarea>

<br/>
<hr color="red"/>
<br/>

<input type="button" value="가입">

</body>
</html>