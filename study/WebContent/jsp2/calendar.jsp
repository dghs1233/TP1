<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	//jsp 영역
	//현재 일자 받아오기
	Calendar cal = Calendar.getInstance();//static
	
	int nowYear = cal.get(Calendar.YEAR);//2023
	int nowMonth = cal.get(Calendar.MONTH)+1;//7
	int nowDay = cal.get(Calendar.DAY_OF_MONTH);//3
	
	//아직 null값 들어가 있음
	String strYear = request.getParameter("year");
	String strMonth = request.getParameter("month");

	int year = nowYear;//2023
	int month = nowMonth;//7
	
	if(strYear!=null) {
		year = Integer.parseInt(strYear);//클라이언트가 보낸 년도
	}
	
	if(strMonth!=null) {
		month = Integer.parseInt(strMonth);//클라이언트가 보낸 월
	}
	
	int preYear = year, preMonth = month-1;
	
	if(preMonth<1) {
		preYear = year-1;
		preMonth = 12;
	}

	int nextYear = year, nextMonth = month+1;
	
	if(nextMonth>12) {
		nextYear = year+1;
		nextMonth = 1;
	}
	
	cal.set(year,month-1,1);
	
	int startDay = 1;
	int endDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);//마지막날
	
	int week = cal.get(Calendar.DAY_OF_WEEK);
	
	//out.print(nextMonth);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>만년달력</title>
<script type="text/javascript">

	//채워줌
	function init() {
		
		var f = document.myForm;
		
		//f.year를 변수화 한 것으로 꼭 필요하지는 않음
		var fyear = f.year;
		
		//jsp 영역에서 현재 년도는 year에 담기기 때문에 해당 값을 가져옴
		var nowYear = <%=year %>;
		var startYear = nowYear-5;
		
		//년도 선택창 출력
		for(i=0;i<11;i++) {
			
			fyear[i] = new Option(startYear, startYear);
			
			//fyear의 i번째 값이 nowYear과 같으면 선택값으로 만들어 줌
			if(fyear[i].value==nowYear) {
				fyear[i].selected = true;
			}
			
			startYear++;
			
		}
		
		var fmonth = f.month;
		
		for(i=0;i<12;i++) {
			fmonth[i] = new Option(i+1, i+1);
		}
		
		var nowMonth = <%=month %>;
		fmonth[nowMonth-1].selected = true
		
	}

	function calendarChange() {
		
		var f = document.myForm;
		
		//데이터 보내라
		f.submit();
		
	}

</script>
<style type="text/css">

body {
	font-size: 10pt;
}

td {
	font-size: 10pt;
}

a {
	text-decoration: none;
	color: blue;
}

</style>

</head>

<!-- init();을 통해 option 보여줌 -->
<body onload="init();">

<br/><br/>

<!-- action을 비워두면 무조건 자기 자신을 찾아감 -->
<form action="" method="get" name="myForm">

<!-- 테이블 가운데 정렬 -->
<table align="center" width="210px" cellpadding="2" cellspacing="1">
<tr>
	<!-- 열의 글자 가운데 정렬 -->
	<td align="center">
	
	<a href="calendar.jsp?year=<%=nowYear %>&month=<%=nowMonth %>"><img src="./image/today.jpg" align="left"></a>
		
	<!-- 위에 있는 변수값 가져와야함 -->
	<a href="calendar.jsp?year=<%=preYear %>&month=<%=preMonth %>">◀</a>
	
	<!-- year를 선택하면 onchange로 바꿔줌 -->
	<select name="year" onchange="calendarChange();">
	
	<!-- 	<option value="2018">2018</option>
		<option value="2019">2019</option>
		<option value="2020">2020</option>
		<option value="2021">2021</option>
		<option value="2022">2022</option>
		<option value="2023">2023</option>
		<option value="2024">2024</option>
		<option value="2025">2025</option>
		<option value="2026">2026</option>
		<option value="2027">2027</option>
		<option value="2028">2028</option> -->
		
	</select>년&nbsp;&nbsp;
	<select name="month" onchange="calendarChange();">
	
	<!-- 	<option value="1">1</option>
		<option value="2">2</option>
		<option value="3">3</option>
		<option value="4">4</option>
		<option value="5">5</option>
		<option value="6">6</option>
		<option value="7">7</option>
		<option value="8">8</option>
		<option value="9">9</option>
		<option value="10">10</option>
		<option value="11">11</option>
		<option value="12">12</option> -->
		
	</select>월
	
	<!-- <b>&nbsp;<%=year %>년&nbsp;&nbsp;<%=month %>월</b> -->
	
	<a href="calendar.jsp?year=<%=nextYear %>&month=<%=nextMonth %>">▶</a>
	</td>
</tr>	
</table>

<table align="center" width="210" cellpadding="0" cellspacing="1"
bgcolor="#cccccc">
<tr>
	<td bgcolor="#e6e4e6" align="center"><font color="red">일</font></td>
	<td bgcolor="#e6e4e6" align="center">월</td>
	<td bgcolor="#e6e4e6" align="center">화</td>
	<td bgcolor="#e6e4e6" align="center">수</td>
	<td bgcolor="#e6e4e6" align="center">목</td>
	<td bgcolor="#e6e4e6" align="center">금</td>
	<td bgcolor="#e6e4e6" align="center"><font color="blue">토</font></td>
</tr>

<%
	int newLine = 0;
	out.print("<tr height='20'>");
	
	//주의 수 활용해 공백 만들기
	for(int i=1;i<week;i++) {
		out.print("<td bgcolor='#ffffff'>&nbsp;</td>");
		newLine++;
	}
	
	//날짜 찍기
	for(int i=startDay;i<=endDay;i++) {
		String fontColor = (newLine==0)?"red":(newLine==6)?"blue":"black";
		String bgColor = (nowYear==year)&&(nowMonth==month)&&
				(nowDay==i)?"#e6e4e6":"#ffffff";
		
		out.print("<td align='center' bgcolor='" + bgColor + 
				"'><font color='" + fontColor +"'>" + i + "</font></td>");
		//<td align='center' bgcolor='#ffffff'>
		//	<font color='red'>2</font></td>
		
		newLine++;
		
		if(newLine==7&&i!=endDay) {
			out.print("</tr><tr height='20'>");
			newLine = 0;//줄 바꿨으니 newLine 초기화
		}
		
		
	}

	while(newLine>0 && newLine<7) {
		out.print("<td bgcolor='#ffffff'>&nbsp;</td>");
		newLine++;
	}
	
	out.print("</tr>");

%>

</table>
</form>
</body>
</html>