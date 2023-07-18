package com.board;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.Connection;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.join.CustomInfo;
import com.util.DBConn;
import com.util.MyUtil;

public class BoardServlet extends HttpServlet{

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	//사용자한테 받은 url이 반영돼서 포워딩 작업에 들어가게 만듦
	protected void forward(HttpServletRequest req, HttpServletResponse resp, String url) throws ServletException, IOException {
		
		RequestDispatcher rd = 
				req.getRequestDispatcher(url);
		
		rd.forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//포스트 방식으로 할 때 req를 UTF-8 형식으로 받아들임
		//req.setCharacterEncoding("UTF-8");
		String cp = req.getContextPath();
		
		Connection conn = DBConn.getConnection();
		BoardDAO dao = new BoardDAO(conn);
		
		MyUtil myUtil = new MyUtil();
		
		//'/study/bbs/list.do'
		//주소 입력값을 uri에 넣어줌
		String uri = req.getRequestURI();
		
//		System.out.println(uri);
		
		String url;
		
		//uri에 created.do가 있으면 url = "/boardTest/created.jsp";로 포워딩
		if(uri.indexOf("created.do")!=-1) {
			
			//세션 불러옴
			HttpSession session = req.getSession();
			
			CustomInfo info = 
					(CustomInfo)session.getAttribute("customInfo");
			
			if(info == null) {
				
				url = "/member/login.jsp";
				forward(req, resp, url);
				return;
				
			}
			
			url = "/boardTest/created.jsp";
			forward(req, resp, url);
		
		//등록하기 버튼 누르면 dto에 데이터 담아서 DB에 저장 후 url로 리다이렉트	
		}else if(uri.indexOf("created_ok.do")!=-1) {
			
			BoardDTO dto = new BoardDTO();
			
			int maxNum = dao.getMaxNum();
			
			dto.setNum(maxNum + 1);
			dto.setSubject(req.getParameter("subject"));
			dto.setName(req.getParameter("name"));
			dto.setEmail(req.getParameter("email"));
			dto.setPwd(req.getParameter("pwd"));
			dto.setContent(req.getParameter("content"));
			dto.setIpAddr(req.getRemoteAddr());
			
			dao.insertData(dto);
			
			//가상의 주소로 리다이렉트
			url = cp + "/bbs/list.do";
			resp.sendRedirect(url);
			
		/*
		list.do로 들어가거나 검색했을 때
		created.do에서 게시글 등록하거나 작성취소 했을 때
		article.do에서 리스트 눌렀을 때 실행
		*/
		}else if(uri.indexOf("list.do")!=-1) {
			//전체 데이터 읽어오고 페이징 처리 해줘야 함
			String pageNum = req.getParameter("pageNum");
			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");
			
			int currentPage = 1;
			
			if(pageNum!=null) {
				currentPage = Integer.parseInt(pageNum);
			}
			
			if(searchValue==null) {
				
				searchKey = "subject";
				searchValue = "";
				
			}else {
				
				if(req.getMethod().equalsIgnoreCase("GET")) {
					
					searchValue = URLDecoder.decode(searchValue, "UTF-8");
					
				}
			}
			
			int dataCount = dao.getDataCount(searchKey, searchValue);
			int numPerPage = 5;
			int totalPage = myUtil.getPageCount(numPerPage, dataCount);
			
			if(currentPage>totalPage) {
				currentPage = totalPage;
			}
			
			int start = (currentPage - 1) * numPerPage + 1;
			int end = currentPage*numPerPage;
			
			List<BoardDTO> lists = 
					dao.getLists(start, end, searchKey, searchValue);
			
//			//사용자 정의
//			String param = "";
//			
//			//주소 정리 검색했으면
//			if(!searchValue.equals("")) {
//				param = "?searchKey=" + searchKey;
//				param += "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
//			}
//			
//			//글보기 주소 정리
//			String articleUrl = cp + "/board/article.jsp";
//			
//			if(param.equals("")) {
//				articleUrl += "?pageNum=" + currentPage;
//			}else {
//				articleUrl += param + "&pageNum=" + currentPage;
//			}
//			
//			//페이징처리
//			//현재 페이지=1, 전체 페이지 수=12, list 주소="list.jsp"값을 넣어줬을 때
//			//페이지 하단에 생기는 pageIndexList의 값
//			String listUrl = "list.jsp" + param;
//			String pageIndexList = 
//					myUtil.pageIndexList(currentPage, totalPage, listUrl);
//			
//			DBConn.close();
			
			String param = "";
			if(searchValue!=null && !searchValue.equals("")) {
				
				param = "searchKey=" + searchKey;
				param += "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
			
			}
			
			String listUrl = cp + "/bbs/list.do";
			
			if(!param.equals("")) {
				listUrl = listUrl + "?" + param;
			}
			
			String pageIndexList = 
					myUtil.pageIndexList(currentPage, totalPage, listUrl);
			
			String articleUrl = cp + "/bbs/article.do?&pageNum=" +currentPage;
			
			if(!param.equals("")) {
				articleUrl = articleUrl + "&" + param;
			}
			
			//포워딩할 데이터(클래스에서 jsp로 넘겨줄 때 필요)
			req.setAttribute("lists", lists);
			req.setAttribute("pageIndexList", pageIndexList);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("articleUrl", articleUrl);
			req.setAttribute("params", param);
			
			
			//위에 세팅해놓은 데이터 가지고 아래 url로 감
			//주소는 list.do로 보여주고 실제 출력되는 주소는 list.jsp
			url = "/boardTest/list.jsp";
			
			forward(req, resp, url);
			
		//게시글을 클릭해서 볼 때 실행
		}else if(uri.indexOf("article.do")!=-1) {
			
			int num = Integer.parseInt(req.getParameter("num"));
			String pageNum = req.getParameter("pageNum");
			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");
			
			if(searchValue!=null) {
				
				searchValue = URLDecoder.decode(searchValue, "UTF-8");
			
			}else {
				
				searchKey = "subject";
				searchValue = "";
			
			}
			
			//조회수 증가
			dao.updateHitCount(num);
			
			BoardDTO dto = dao.getReadData(num);
			
			//article.do를 가져왔기 때문에 포워드 시키면 안되고 리다이렉트
			if(dto==null) {
				url = cp + "/bbs/list.do";
				resp.sendRedirect(url);
			}
			
			int lineSu = dto.getContent().split("\n").length;
			
			dto.setContent(dto.getContent().replaceAll("\n", "<br/>"));
			
			String param = "pageNum=" + pageNum;
			
			if(searchValue!=null && !searchValue.equals("")) {
				
				param += "&searchKey=" + searchKey;
				param += "&searchValue=" + 
						URLEncoder.encode(searchValue,"UTF-8");
				
			}
			
			req.setAttribute("dto", dto);
			req.setAttribute("lineSu", lineSu);
			req.setAttribute("searchKey", searchKey);
			req.setAttribute("searchValue", searchValue);
			req.setAttribute("params", param);
			req.setAttribute("pageNum", pageNum);
			
			url = "/boardTest/article.jsp";
			
			forward(req, resp, url);
			
		}else if(uri.indexOf("updated.do")!=-1) {
			
			int num = Integer.parseInt(req.getParameter("num"));
			String pageNum = req.getParameter("pageNum");
			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");
			
			if(searchValue!=null) {
				searchValue = 
						URLDecoder.decode(searchValue, "UTF-8");
			}
			
			BoardDTO dto = dao.getReadData(num);
			
			if(dto==null) {
				url = cp + "/bbs/list.do";
				resp.sendRedirect(url);
			}
			
			String param = "pageNum=" + pageNum;
			
			if(searchValue!=null && !searchValue.equals("")) {
				param += "&searchKey=" + searchKey;
				param += "&searchValue=" + 
						URLEncoder.encode(searchValue, "UTF-8");				
			}
			
			req.setAttribute("dto", dto);
			req.setAttribute("pageNum", pageNum);
			//주소 간소화값
			req.setAttribute("params", param);
			req.setAttribute("searchKey", searchKey);
			req.setAttribute("searchValue", searchValue);
			
			url = "/boardTest/updated.jsp";
			
			forward(req, resp, url);
		
		}else if(uri.indexOf("updated_ok.do")!=-1) {
		
			String pageNum = req.getParameter("pageNum");
			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");
			
			/*searchValue를 사용해야 하는 경우엔 디코딩 해줘야 하지만
			그냥 값만 받고 바로 넘어가는 경우 없어도 됨
			if(searchValue!=null) {
				searchValue = 
						URLDecoder.decode(searchValue, "UTF-8");
			}
			*/
			//데이터 받을 그릇 생성
			BoardDTO dto = new BoardDTO();
			
			dto.setNum(Integer.parseInt(req.getParameter("num")));
			dto.setSubject(req.getParameter("subject"));
			dto.setName(req.getParameter("name"));
			dto.setEmail(req.getParameter("email"));
			dto.setPwd(req.getParameter("pwd"));
			dto.setContent(req.getParameter("content"));
			
			dao.updateData(dto);
			
			
			String param = "pageNum=" + pageNum;
			
			if(searchValue!=null && !searchValue.equals("")) {
				
				param += "&searchKey=" + searchKey;
				param += "&searchValue=" +
						URLEncoder.encode(searchValue, "UTF-8");
				
			}
			
			url = cp + "/bbs/list.do?" + param;
			resp.sendRedirect(url);
		
		}else if(uri.indexOf("deleted_ok.do")!=-1) {
			
//			int num = Integer.parseInt(req.getParameter("num"));
//			String pageNum = req.getParameter("pageNum");
//			
//			String searchKey = req.getParameter("searchKey");
//			String searchValue = req.getParameter("searchValue");
//			
//			if(searchValue!=null) {
//				
//				//get방식으로 넘어오면 한글이 깨지므로 처리
//				if(req.getMethod().equalsIgnoreCase("GET")) {
//					searchValue = URLDecoder.decode(searchValue, "UTF-8");
//				}
//					
//			//검색 안했으면 searchKey의 기본값은 subject, searchValue의 기본값은 null
//			//전체 데이터 보여주도록 함
//			}else {
//				searchKey = "subject";
//				searchValue = "";
//			}
//			
//			dao.deleteData(num);
//			
//			String param = "pageNum=" + pageNum;
//			
//			if(searchValue!=null && searchValue.equals("")) {
//				
//				param += "&searchKey=" + searchKey;
//				param += "&searchValue=" +
//						URLEncoder.encode(searchValue, "UTF-8");
//				
//			}
			
			int num = Integer.parseInt(req.getParameter("num"));
			String pageNum = req.getParameter("pageNum");
			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");
			
			if(searchValue!=null) {
				
				//get방식으로 넘어오면 한글이 깨지므로 처리
				if(req.getMethod().equalsIgnoreCase("GET")) {
					searchValue = URLDecoder.decode(searchValue, "UTF-8");
				}
					
			//검색 안했으면 searchKey의 기본값은 subject, searchValue의 기본값은 null
			//전체 데이터 보여주도록 함
			}else {
				searchKey = "subject";
				searchValue = "";
			}
			
			dao.deleteData(num);
			
			DBConn.close();
			
			String param = "pageNum=" + pageNum;
			
			if(searchValue!=null && !searchValue.equals("")) {
				
				param += "&searchKey=" + searchKey;
				param += "&searchValue=" +
						URLEncoder.encode(searchValue, "UTF-8");
				
			}
			
//			resp.sendRedirect("list.jsp?" + param + "&num=" + num);
			
			url = cp + "/bbs/list.do?" + param + "&num=" + num;
			resp.sendRedirect(url);
			
		}
	}
	
	

}
