<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">

	function sendIt() {
		f = document.myForm;
		
		if(!f.su1.value) {
			alert("수1을 입력하세요")
			f.su1.focus();
			return;
		}
		
		if(!f.su2.value) {
			alert("수2을 입력하세요")
			f.su2.focus();
			return;
		}
		//action을 찾아가서 넣어줌
		f.action = "hap_ok.jsp";
		//밑에 버튼은 안내를 못해주므로 submit 해줘야 함
		f.submit();
	}

</script>
</head>
<body>

<!-- get방식은 url에 담은 데이터를 보여주고 post방식은 주소만 보여줌 -->
<!-- 중요한 데이터 넘길 때는 post 아닌 경우 get -->
<!-- form 양식은 무조건 post -->
<form action="" method="get" name="myForm">

수1 : <input type="text" name="su1"/><br/>
수2 : <input type="text" name="su2"/><br/>
이름 : <input type="text" name="name"/><br/>
<input type="button" value="결과" onclick="sendIt();"/><br/>
<!-- submit은 버튼과 비슷하지만 submit은 무조건 action을 찾아감 -->
<!-- name은 변수 역할도 하기 때문에 su1과 su2에 각각 숫자가 들어가고 -->
<!-- submit을 누르면 해당 값을 request에 담아서 감 -->
<!-- request에 값을 담아서 톰캣 서버에 요청하고 결과물을 response로 보여줌 -->
<!-- js 쓸 경우 button을 넣어서 물길을 바꿔줌 -->

</form>

<a href="hap_ok.jsp?su1=100&su2=200&name=수지">get방식</a>

</body>
</html>