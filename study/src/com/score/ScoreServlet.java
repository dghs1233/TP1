package com.score;

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

import com.board.BoardDTO;
import com.util.DBConn;
import com.util.MyUtil;

public class ScoreServlet extends HttpServlet{

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
	
	//포워딩할 때 사용
	protected void forward(HttpServletRequest req, HttpServletResponse resp, String url) throws ServletException, IOException {
		
		RequestDispatcher rd = 
				req.getRequestDispatcher(url);
		
		rd.forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String cp = req.getContextPath();
		
		Connection conn = DBConn.getConnection();
		ScoreDAO dao = new ScoreDAO(conn);
		MyUtil myUtil = new MyUtil();
		
		String uri = req.getRequestURI();
		
		String url;
		
		if(uri.indexOf("list.do")!=-1) {
			
			List<ScoreDTO> lists = dao.getlists();
			
			DBConn.close();
		
			//lists 데이터를 넘겨줘야 db에 있는 데이터 뜸
			req.setAttribute("lists", lists);
			
			url = "/scoreTest/list.jsp";
			
			forward(req, resp, url);
		
		}else if(uri.indexOf("write.do")!=-1) {
			
			url = "/scoreTest/write.jsp";
			
			forward(req, resp, url);
			
		}else if(uri.indexOf("write_ok.do")!=-1) {
			
			ScoreDTO dto = new ScoreDTO();
			
			dto.setHak(req.getParameter("hak"));
			dto.setName(req.getParameter("name"));
			dto.setKor(Integer.parseInt(req.getParameter("kor")));
			dto.setEng(Integer.parseInt(req.getParameter("eng")));
			dto.setMat(Integer.parseInt(req.getParameter("mat")));

			dao.insertData(dto);
			
			DBConn.close();
			
			url = cp + "/jumsu/list.do";
			resp.sendRedirect(url);
			
			
		}else if(uri.indexOf("update.do")!=-1) {
		
			String hak = req.getParameter("hak");

			ScoreDTO dto = dao.getReadData(hak);
			
			DBConn.close();
			
			if(dto==null) {
				url = cp + "/jumsu/list.do";
				resp.sendRedirect(url);
			}
			
			//update 화면에 넘길 데이터
			req.setAttribute("dto", dto);
			
			//update.jsp에서 입력값 받고 update_ok.do로 넘길 예정
			url = "/scoreTest/update.jsp";
			
			forward(req, resp, url);
		
		}else if(uri.indexOf("update_ok.do")!=-1) {
			
			ScoreDTO dto = new ScoreDTO();
			
			//updateData에 4가지 데이터가 들어가야 작동함
			dto.setKor(Integer.parseInt(req.getParameter("kor")));
			dto.setEng(Integer.parseInt(req.getParameter("eng")));
			dto.setMat(Integer.parseInt(req.getParameter("mat")));
			dto.setHak(req.getParameter("hak"));
			
			dao.updateData(dto);
			
			DBConn.close();
			
			url = cp + "/jumsu/list.do";
			resp.sendRedirect(url);
		
		}else if(uri.indexOf("delete_ok.do")!=-1) {
			
			String hak = req.getParameter("hak");
			
			dao.deleteData(hak);
			
			DBConn.close();
			
			url = cp + "/jumsu/list.do";
			resp.sendRedirect(url);
			
		}
		
	}
}
