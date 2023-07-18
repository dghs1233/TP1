<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="com.board.BoardDTO"%>
<%@page import="com.board.BoardDAO"%>
<%@page import="com.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	int num = Integer.parseInt(request.getParameter("num"));
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	//검색-----------------------------------------------
	String searchKey = request.getParameter("searchKey");
	String searchValue = request.getParameter("searchValue");
		
	//검색한 경우 처리
	if(searchValue!=null) {
			
		//get방식으로 넘어오면 한글이 깨지므로 처리
		if(request.getMethod().equalsIgnoreCase("GET")) {
			searchValue = URLDecoder.decode(searchValue, "UTF-8");
		}
			
	//검색 안했으면 searchKey의 기본값은 subject, searchValue의 기본값은 null
	//전체 데이터 보여주도록 함
	}else {
		searchKey = "subject";
		searchValue = "";
	}
	
	//param은 url을 만드는 변수이기 때문에 그 자체로 searchValue와 searchKey를 가짐
	String param = "";
	
	if(searchValue!=null && !searchValue.equals("")) {
		
		param = "&searchKey=" + searchKey +
				"&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
		
	}
	
	Connection conn = DBConn.getConnection();
	BoardDAO dao = new BoardDAO(conn);
	
	BoardDTO dto = dao.getReadData(num);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게 시 판</title>

<link rel="stylesheet" type="text/css" href="<%=cp%>/board2/css/style.css"/>
<link rel="stylesheet" type="text/css" href="<%=cp%>/board2/css/created.css"/>

<script type="text/javascript" src="<%=cp%>/board2/js/util.js"></script>
<script type="text/javascript">

	function sendIt(){
		
		f = document.myForm;
		
		str = f.subject.value;
		str = str.trim();
		if(!str){
			alert("\n제목을 입력하세요.");
			f.subject.focus();
			return;
		}
		f.subject.value = str;
		
		str = f.name.value;
		str = str.trim();
		if(!str){
			alert("\n이름을 입력하세요.");
			f.name.focus();
			return;
		}
		/*
		if(!isValidKorean(str)){
			alert("\n이름을 정확히 입력하세요.");
			f.name.focus();
			return;
		}
		*/
		f.name.value = str;
		
		if(f.email.value){
			
			if(!isValidEmail(f.email.value)){
				alert("\n정상적인 E-Mail을 입력하세요.");
				f.email.focus();
				return;
			}
		}
		
		str = f.content.value;
		str = str.trim();
		if(!str){
			alert("\n내용을 입력하세요.");
			f.content.focus();
			return;
		}
		
		f.content.value = str;
		
		str = f.pwd.value;
		str = str.trim();
		
		if(!str){
			alert("\n패스워드를 입력하세요.");
			f.pwd.focus();
			return;
		}
		
		if(str!="<%=dto.getPwd() %>") {
			alert("패스워드가 틀립니다.");
			f.pwd.focus();
			return;
		}
		
		f.pwd.value = str;
		f.action = "<%=cp%>/board/updated_ok.jsp?num=<%=num %>&pageNum=<%=pageNum %><%=param%>";
		f.submit();
		
	}

</script>
</head>
<body>

<div id="bbs">
	<div id="bbs_title">
		게 시 판
	</div>
	
	<form action="" method="post" name="myForm">
	<div id="bbsCreated">
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>제&nbsp;&nbsp;&nbsp;&nbsp;목</dt>
				<dd>
				<input type="text" name="subject" size="60" maxlength="100"
				class="boxTF" value="<%=dto.getSubject() %>"/>
				</dd>
			</dl>
		</div>
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>작성자</dt>
				<dd>
				<input type="text" name="name" size="35" maxlength="20"
				class="boxTF" value="<%=dto.getName() %>"/>
				</dd>
			</dl>
		</div>
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>E-Mail</dt>
				<dd>
				<input type="text" name="email" size="35" maxlength="50"
				class="boxTF" value="<%=dto.getEmail()==null?"":dto.getEmail() %>"/>
				</dd>
			</dl>
		</div>
		<div id="bbsCreated_content">
			<dl>
				<dt>내&nbsp;&nbsp;&nbsp;&nbsp;용</dt>
				<dd>
				<textarea rows="12" cols="63" name="content" class="boxTA"
				style="resize: none; background-color: #ffffff"><%=dto.getContent() %></textarea>
				</dd>
			</dl>
		</div>
		<div class="bbsCreated_noLine">
			<dl>
				<dt>패스워드</dt>
				<dd>
				<input type="password" name="pwd" size="35" maxlength="7"
				class="boxTF"/>&nbsp;(게시물 수정 및 삭제시 필요!!)
				</dd>
			</dl>
		</div>	
	</div>	
	<div id="bbsCreated_footer">
	<input type="button" value=" 수정하기 " class="btn2" onclick="sendIt();"/>
	<input type="reset" value=" 다시입력 " class="btn2" 
		onclick="document.myForm.subject.focus();"/>
	<input type="button" value=" 수정취소 " class="btn2" 
		onclick="javascript:location.href='<%=cp%>/board/list.jsp?pageNum=<%=pageNum %>';">
	
	<!-- 수정하기 버튼을 누르면 num이 안넘어가므로 hidden처리 -->
	<input type="hidden" name="num" value="<%=dto.getNum() %>"/>
	<input type="hidden" name="pageNum" value="<%=pageNum %>"/>
	<input type="hidden" name="searchKey" value="<%=searchKey %>"/>	
	<input type="hidden" name="searchValue" value="<%=searchValue %>"/>	
	</div>	
	</form>
	
</div>


</body>
</html>



