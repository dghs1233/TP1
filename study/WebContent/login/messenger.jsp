<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<style type="text/css">

body {
	font-size: 10pt;
}

.itemBtn{
	font-size: 9pt;
	color: rgb(0,0,0);
	background-color: rgb(240,240,240);
	width: 30pt;
}

.btn{
	font-size: 9pt;
	color: rgb(0,0,0);
	background-color: rgb(240,240,240);
}

.itemList{
	font-size: 9pt;
	width: 100pt;

}

</style>

<script type="text/javascript">
	
	function itemAdd() {
		
		var f = document.myForm;
		var leftItem = f.leftItem;
		
		//Option(보이는 값, value)
		leftItem[0] = new Option('배수지', '배수지');		
		leftItem[1] = new Option('서예지', '서예지');		
		leftItem[2] = new Option('고문영', '고문영');		
		leftItem[3] = new Option('박신혜', '박신혜');		
		leftItem[4] = new Option('손예진', '손예진');		
		leftItem[5] = new Option('김태희', '김태희');		
		leftItem[6] = new Option('연진이', '연진이');		
		
	}

	function itemMove(val) {
		
		var f = document.myForm;
		var source, target;
		
		//오른쪽에 있는 것(source)을 왼쪽(target)으로 옮길 때
		if(val=="left"){
			source = f.rightItem;
			target = f.leftItem;
		}else if(val=="right") {
			source = f.leftItem;
			target = f.rightItem;
		}
		
		var n, i;
		//n은 타겟의 길이
		n = target.length;
		
		for(i=source.length-1;i>=0;i--) {
			
			//소스에서 i번째 값이 선택되면
			if(source.options[i].selected) {
				
				//target의 n++ 자리에 옵션값 넣어줌
				target[n++] = 
					new Option(source.options[i].text,
							source.options[i].value);
				
				source[i] = null;
				
			}
		}
	}
	
	function sendMessage() {
		var f = document.myForm;
		
		if(f.rightItem.length==0) {
			alert("쪽지를 보낼 사람을 선택하세요.");
			f.leftItem.focus();
			return;
		}
		
		if(!f.msg.value) {
			alert("메세지를 입력하세요.");
			f.msg.focus();
			return;
		}
		
		for(i=0;i<f.rightItem.length;i++) {
			f.rightItem[i].selected = true;
		}
		
		
		f.submit();
	}

</script>
</head>

<!-- body가 뜰 때 itemAdd();를 띄워줌 -->
<body onload="itemAdd();">

<form action="messenger_ok.jsp" method="post" name="myForm">

<table border="0" style="font-size: 10pt;" align="center">

<tr align="center">
	<td width="150">전체리스트</td>
	<td width="70">&nbsp;</td>
	<td width="150">받는사람</td>
</tr>

<tr align="center">
	<td width="150">
		<select name="leftItem" multiple="multiple" size="7" class="itemList">
			<!-- <option value="배수지">배수지</option> -->
		</select>
	</td>
	<td width="70">
		<input type="button" value="&gt;" class="itemBtn" onclick="itemMove('right')"/><br/>	
		<input type="button" value="&lt;" class="itemBtn" onclick="itemMove('left')"/><br/>	
	</td>
	<td width="150">
		<select name="rightItem" multiple="multiple" size="7" class="itemList">
		</select>
	</td>
</tr>

<tr>
	<td colspan="3">
		<br/>메세지<br/>
		<textarea rows="5" cols="52" name="msg"></textarea>	
	</td>
</tr>

<tr>
	<td colspan="3" align="center">
		<input type="button" value="쪽지보내기" class="btn" onclick="sendMessage();"/><br/>
	</td>
</tr>

</table>


</form></body>
</html>