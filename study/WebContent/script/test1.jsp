<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">

	var str;//전역변수
	
	str = "변수 문자 입력";
	
	//document는 문서 전체이지만 보통 body를 가리킴
	//System.out.println(str);과 같음
	//typeof(str)은 str의 type 확인
	document.write(str + typeof(str) + "<br/>");

	str = 123;
	
	document.write(str + typeof(str) + "<br/>");
	
	str = true;
	
	document.write(str + typeof(str) + "<br/>");
	
	document.write("<br/>---------------<br/>");
	
	var hello = "함수 밖 전역변수 hello";
	
	function fthis() {
		
		var hello = "지역변수 hello";
		global = "함수 안 전역변수 global";
		var local = "지역변수 local"
		
		document.write(hello + "<br/>");
		document.write(global + "<br/>");
		document.write(local + "<br/>");
	}
	
	fthis();//함수 안에 있는 
	document.write(hello + "<br/>");
	//document.write(local + "<br/>");에러남(지역변수기 때문) -> 에러 이후에는 실행이 안됨
	document.write(global + "<br/>");
	
	
	document.write("<br/>---------------<br/>");
	
	var num1=10, num2=3;
	document.write("num1+num2=" + (num1+num2) + "<br/>");
	document.write("num1-num2=" + (num1-num2) + "<br/>");
	document.write("num1*num2=" + (num1*num2) + "<br/>");
	document.write("num1/num2=" + (num1/num2) + "<br/>");
	document.write("num1%num2=" + (num1%num2) + "<br/>");
	document.write("num1>num2=" + (num1>num2) + "<br/>");
	document.write("num1==num2=" + (num1==num2) + "<br/>");
	document.write("num1!=num2=" + (num1!=num2) + "<br/>");
	
	document.write("<br/>---------------<br/>");
	
	var answer;
	
	answer = 0;
	if(answer>0) {
		document.write(answer + "는 양수입니다");
	}else if(answer<0) {
		document.write(answer + "는 음수입니다");		
	}else {
		document.write(answer + "는 0입니다");				
	}
	
	document.write("<br/>---------------<br/>");
	
	for(var i=1;i<=10;i++) {
		document.write(i + "\t")
	}
	
	document.write("<br/>---------------<br/>");
	
	var j=1;
	while(j<=10) {
		document.write(j + "\t");
		j++;
	}
	
	function test1() {
		alert("나 불렀냐?");
	}
	
	//test1();
	
</script>

</head>
<body onload="test1();">

</body>
</html>