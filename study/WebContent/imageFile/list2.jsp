<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String cp = request.getContextPath();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>이미지 게시판</title>

<link rel="stylesheet" href="<%=cp%>/imageFile/data/style.css" type="text/css">

</head>

<body>

<br/>&nbsp;<br/>

<table width="600" border="2" cellspacing="0" cellpadding="0" 
bordercolor="#D6D4A6" style="margin: auto;">
<tr height="40"> 
<td style="padding-left:25px;">
<b>이미지 게시판</b>
</td>
</tr>
</table>
<br/>

<table width="600" border="0" cellpadding="0" cellspacing="0" style="margin: auto;">
<tr height="30">
	<td align="left" width="50%">
        전체데이터 수:${dataCount}, 전체페이지 수: ${totalPage}, 현재페이지:${pageNum}
	</td>
	<td align="right">
        <input type="button" value=" 게시물 등록 " onclick="javascript:location.href='<%=cp%>/image/write.do'" class="btn1"/>
	</td>
</tr>
</table>

<table width="600" border="0" cellpadding="0" cellspacing="0" style="margin: auto;">
<tr><td height="3" bgcolor="#DBDBDB" align="center"></td></tr>
</table>

<table width="600" border="0" cellspacing="1" cellpadding="3"
   bgColor="#FFFFFF" style="margin: auto;">

	<c:set var="n" value="0"/>
	<c:forEach var="dto" items="${lists}">
		<c:if test="${n==0}">
			<tr bgcolor="#FFFFFF" >
		</c:if>
		<c:if test="${n!=0&&n%3==0 }">
			</tr><tr bgcolor="#FFFFFF" >
		</c:if>
      <td width="200" align="center">
	<a href="${imagePath}/${dto.saveFileName}">  
	    <img src="${imagePath}/${dto.saveFileName}" width="180" height="180"/>
	</a>
	    <br/>${dto.subject}&nbsp;
	    <a href="<%=cp%>/image/delete.do?num=${dto.num}&pageNum=${pageNum}">삭제</a>
	</td>
	<c:set var="n" value="${n+1}"/>
	</c:forEach>	

	<c:if test="${n>0||n%3!=0 }">
		<c:forEach var="i" begin="${n%3+1}" end="3" step="1">
			<td>&nbsp;</td>
		</c:forEach>
	</c:if>
	
	<c:if test="${n!=0 }">
		</tr>
	</c:if>
	
	<c:if test="${dataCount != 0}">
	<tr bgcolor="#FFFFFF">
	   <td align="center" height="30" colspan="3">${pageIndexList}</td>
    </tr>
	</c:if>
	
	<c:if test="${dataCount == 0}">
	<tr bgcolor="#FFFFFF">
       <td align="center" colspan="3" height="30">등록된 자료가 없습니다.</td>
    </tr>
	</c:if>
</table>

<table width="600" border="0" cellpadding="0" cellspacing="0" style="margin: auto;">
<tr><td height="3" bgcolor="#DBDBDB" align="center"></td></tr>
</table>

<br/><br/>
<br/><br/>
</body>
</html>
