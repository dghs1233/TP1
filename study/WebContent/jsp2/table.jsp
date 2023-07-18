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
		
		if(!f.su1.value) {
			alert("가로 값을 입력하세요.")
			f.su1.focus();
			return
		}
		
		if(!f.su2.value) {
			alert("세로 값을 입력하세요.")
			f.su2.focus();
			return
		}
		f.submit();
	}

</script>

</head>
<body>

<form action="table_ok.jsp" method="get" name="myForm">

가로 : <input type="text" name="su1"/><br/>
세로 : <input type="text" name="su2"/><br/>
<input type="button" value="결과" onclick="sendIt();"/><br/>

</form>
</body>
</html>