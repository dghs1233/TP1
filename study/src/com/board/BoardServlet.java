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

	//��������� ���� url�� �ݿ��ż� ������ �۾��� ���� ����
	protected void forward(HttpServletRequest req, HttpServletResponse resp, String url) throws ServletException, IOException {
		
		RequestDispatcher rd = 
				req.getRequestDispatcher(url);
		
		rd.forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//����Ʈ ������� �� �� req�� UTF-8 �������� �޾Ƶ���
		//req.setCharacterEncoding("UTF-8");
		String cp = req.getContextPath();
		
		Connection conn = DBConn.getConnection();
		BoardDAO dao = new BoardDAO(conn);
		
		MyUtil myUtil = new MyUtil();
		
		//'/study/bbs/list.do'
		//�ּ� �Է°��� uri�� �־���
		String uri = req.getRequestURI();
		
//		System.out.println(uri);
		
		String url;
		
		//uri�� created.do�� ������ url = "/boardTest/created.jsp";�� ������
		if(uri.indexOf("created.do")!=-1) {
			
			//���� �ҷ���
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
		
		//����ϱ� ��ư ������ dto�� ������ ��Ƽ� DB�� ���� �� url�� �����̷�Ʈ	
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
			
			//������ �ּҷ� �����̷�Ʈ
			url = cp + "/bbs/list.do";
			resp.sendRedirect(url);
			
		/*
		list.do�� ���ų� �˻����� ��
		created.do���� �Խñ� ����ϰų� �ۼ���� ���� ��
		article.do���� ����Ʈ ������ �� ����
		*/
		}else if(uri.indexOf("list.do")!=-1) {
			//��ü ������ �о���� ����¡ ó�� ����� ��
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
			
//			//����� ����
//			String param = "";
//			
//			//�ּ� ���� �˻�������
//			if(!searchValue.equals("")) {
//				param = "?searchKey=" + searchKey;
//				param += "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
//			}
//			
//			//�ۺ��� �ּ� ����
//			String articleUrl = cp + "/board/article.jsp";
//			
//			if(param.equals("")) {
//				articleUrl += "?pageNum=" + currentPage;
//			}else {
//				articleUrl += param + "&pageNum=" + currentPage;
//			}
//			
//			//����¡ó��
//			//���� ������=1, ��ü ������ ��=12, list �ּ�="list.jsp"���� �־����� ��
//			//������ �ϴܿ� ����� pageIndexList�� ��
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
			
			//�������� ������(Ŭ�������� jsp�� �Ѱ��� �� �ʿ�)
			req.setAttribute("lists", lists);
			req.setAttribute("pageIndexList", pageIndexList);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("articleUrl", articleUrl);
			req.setAttribute("params", param);
			
			
			//���� �����س��� ������ ������ �Ʒ� url�� ��
			//�ּҴ� list.do�� �����ְ� ���� ��µǴ� �ּҴ� list.jsp
			url = "/boardTest/list.jsp";
			
			forward(req, resp, url);
			
		//�Խñ��� Ŭ���ؼ� �� �� ����
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
			
			//��ȸ�� ����
			dao.updateHitCount(num);
			
			BoardDTO dto = dao.getReadData(num);
			
			//article.do�� �����Ա� ������ ������ ��Ű�� �ȵǰ� �����̷�Ʈ
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
			//�ּ� ����ȭ��
			req.setAttribute("params", param);
			req.setAttribute("searchKey", searchKey);
			req.setAttribute("searchValue", searchValue);
			
			url = "/boardTest/updated.jsp";
			
			forward(req, resp, url);
		
		}else if(uri.indexOf("updated_ok.do")!=-1) {
		
			String pageNum = req.getParameter("pageNum");
			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");
			
			/*searchValue�� ����ؾ� �ϴ� ��쿣 ���ڵ� ����� ������
			�׳� ���� �ް� �ٷ� �Ѿ�� ��� ��� ��
			if(searchValue!=null) {
				searchValue = 
						URLDecoder.decode(searchValue, "UTF-8");
			}
			*/
			//������ ���� �׸� ����
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
//				//get������� �Ѿ���� �ѱ��� �����Ƿ� ó��
//				if(req.getMethod().equalsIgnoreCase("GET")) {
//					searchValue = URLDecoder.decode(searchValue, "UTF-8");
//				}
//					
//			//�˻� �������� searchKey�� �⺻���� subject, searchValue�� �⺻���� null
//			//��ü ������ �����ֵ��� ��
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
				
				//get������� �Ѿ���� �ѱ��� �����Ƿ� ó��
				if(req.getMethod().equalsIgnoreCase("GET")) {
					searchValue = URLDecoder.decode(searchValue, "UTF-8");
				}
					
			//�˻� �������� searchKey�� �⺻���� subject, searchValue�� �⺻���� null
			//��ü ������ �����ֵ��� ��
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
