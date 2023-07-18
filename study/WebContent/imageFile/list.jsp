<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/imageFile/data/style.css"/>
<link rel="stylesheet" type="text/css" href="<%=cp%>/imageFile/data/list.css"/>
<script type="text/javascript" src="<%=cp%>/imageFile/data/image.js"></script>

</head>
<body>
<div id="bbsList">
	<div id=bbsList_title>
		이미지 게시판
	</div>

	<div id="bbsList_header">
		<div id="leftHeader">
			전체데이터 수 : ${dataCount }
			전체페이지 수 : ${totalPage } 
			현재페이지 : ${pageNum }
		</div>
		<div id="rightHeader">
			<input type="button" value=" 업로드 " class="btn2"
			onclick="javascript:location.href='<%=cp %>/image/write.do';"/>
		</div>
	</div>
	
	<hr>
	
	<div id="bbsList_list">
		<div id="lists">
		<ul>
			<c:forEach var="dto" items="${lists }">
				<li>
					<div>
						<div><img src="${imagePath }/${dto.saveFileName }" 
						width="180" height="240"/>
						</div>
						<span>${dto.num }</span>			
						<span><a href="${deletePath }?num=${dto.num }">삭제</a></span>
					</div>
				</li>
			</c:forEach>
		</ul>
		</div>
		<div id="footer">
			<p>
				<c:if test="${dataCount!=0 }">
					${pageIndexList }
				</c:if>
				<c:if test="${dataCount==0 }">
					등록된 게시물이 없습니다.
				</c:if>
			</p>
		</div>
		<hr>
	</div>
</div>

</body>
</html>