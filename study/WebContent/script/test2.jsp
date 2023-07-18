<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">

	function colorTest(color) {
		document.bgColor = color;
	}

</script>
</head>
<body>

<h1>배경색 선택하기</h1>


<input type="radio" name="r1" onclick="colorTest('white')" checked="checked">white<br/>
<input type="radio" name="r1" onclick="colorTest('red')">red<br/>
<input type="radio" name="r1" onclick="colorTest('blue')">blue<br/>
<input type="radio" name="r1" onclick="colorTest('yellow')">yellow<br/>

</body>
</html>