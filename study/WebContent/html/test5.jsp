<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- a href는 네이버로 연결되는 하이퍼 링크(파일도 띄울 수 있음) -->
<!-- target="_blank"를 통해 새 탭에 띄울 수 있음 -->
<!-- 그림에도 하이퍼링크를 걸어줄 수 있음-->
<!-- tr은 테이블의 행이고 그 안에 td를 통해 열 설정 가능-->
<!-- table에 border를 통해 선 삽입 가능-->
<!-- cellpadding은 -->
<!-- colspan="2"를 통해 나란한 두 칸을 병합 -->
<!-- rowspan="2"를 통해 수직의 두 칸을 병합 -->

<a href="https://www.naver.com" target="_blank">네이버</a><br/>

<a href="test1.html" target="_blank">네이버</a>

<a href="https://kr.canon/main"><img src="./image/m0828-1-19031.jpg"/></a>

<hr/>

<table border="1" width="40%" height="200"
	cellpadding="100" cellspacing="0" align="center">

<tr align="center">
	<td>A</td><td colspan="2">B</td>
</tr>

<tr>
	<td>가</td><td align="left">나</td><td rowspan="2">다</td>
</tr>

<tr>
	<td>1</td><td>2</td>
</tr>

</table>

<hr/>

<table border="1" width="600">

<tr align="center" height="50">
<td> 화면 상단 부분</td>
</tr>
<tr>
	<td>
		<table border="1" height="150" align="center">
			<tr align="center">
				<td width="200">화면 중간<br/>왼쪽부분</td>
				<td width="200">화면 중간<br/>왼쪽부분</td>
				<td width="200">화면 중간<br/>왼쪽부분</td>
			</tr>		
		</table>
	</td>
</tr>
<tr align="center" height="50">
<td> 화면 하단 부분</td>
</tr>
</table>

</body>
</html>