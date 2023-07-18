package com.join;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.board.BoardDTO;
import com.util.DBConn;

public class MemberServlet extends HttpServlet{

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
	
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
		MemberDAO dao = new MemberDAO(conn);
		
		String uri = req.getRequestURI();
		
		String url;
		
		if(uri.indexOf("index2.do")!=-1) {
			
			url = "/index2.jsp";
			
			forward(req, resp, url);
		
		}else if(uri.indexOf("created.do")!=-1) {
			
			url = "/member/created.jsp";
			
			forward(req, resp, url);
			
		}else if(uri.indexOf("created_ok.do")!=-1) {
			
			//저장할 공간 생성
			MemberDTO dto = new MemberDTO();
			
			dto.setUserId(req.getParameter("userId"));
			dto.setUserPwd(req.getParameter("userPwd"));
			dto.setUserName(req.getParameter("userName"));
			dto.setUserBirth(req.getParameter("userBirth"));
			dto.setUserTel(req.getParameter("userTel"));
			
			dao.insertData(dto);
			
			//회원가입 하면 index.jsp로 가게 만듦
			url = cp + "/index.jsp";
			resp.sendRedirect(url);
		
		}else if(uri.indexOf("login.do")!=-1) {
			
			//로그인 화면으로 보내주기만 하면 됨
			url = "/member/login.jsp";
			forward(req, resp, url);
			
		}else if(uri.indexOf("login_ok.do")!=-1) {
			
			//로그인 시 받아야 할 두 개의 데이터
			String userId = req.getParameter("userId");
			String userPwd = req.getParameter("userPwd");
			
			//아이디가 존재하는지 읽어옴
			MemberDTO dto = dao.getReadData(userId);
			
			//아이디가 틀리거나 패스워드가 틀린 경우
			if(dto==null || (!dto.getUserPwd().equals(userPwd))) {
			
				req.setAttribute("message", "아이디 또는 패스워드를 정확히 입력하세요.");
				url = "/member/login.jsp";
				forward(req, resp, url);
				
				//아래쪽 실행 안됨
				return;
			
			}
			
			//클래스 객체 생성해줘야 세션 쓸 수 있음
			HttpSession session = req.getSession();
			
			CustomInfo info = new CustomInfo();
			
			info.setUserId(dto.getUserId());
			info.setUserName(dto.getUserName());

			//CustomInfo 클래스를 세션에 올림
			session.setAttribute("customInfo", info);
			
			//세션이 바뀌면 index.jsp로 리다이렉트
			url = cp;
			resp.sendRedirect(url);
			
		//로그아웃은 세션 지워주면 됨
		}else if(uri.indexOf("logout_ok.do")!=-1) {
			
			HttpSession session = req.getSession();
			
			session.removeAttribute("customInfo");
			session.invalidate();
			
			url = cp;
			resp.sendRedirect(url);
		
		}else if(uri.indexOf("searchPwd.do")!=-1) {
			
			//비밀번호 찾기 화면으로 보내주기만 하면 됨
			url = "/member/searchPwd.jsp";
			forward(req, resp, url);
			
		}else if(uri.indexOf("searchPwd_ok.do")!=-1) {
			
			//비밀번호 확인 시 받아야 할 두 개의 데이터
			String userId = req.getParameter("userId");
			String userName = req.getParameter("userName");
			String userBirth = req.getParameter("userBirth");
			
			//아이디, 이름, 생년월일이 일치하는 데이터의 패스워드 읽어옴
			MemberDTO dto = dao.getReadData(userId, userName, userBirth);
			
			//아이디가 틀리거나 패스워드가 틀린 경우
			if(dto==null) {
			
				req.setAttribute("message", "아이디, 이름, 생년월일을 정확히 입력하세요.");
				url = "/member/searchPwd.jsp";
				forward(req, resp, url);
				return;
			
			}
			
			req.setAttribute("userPwd", dto.getUserPwd());
			req.setAttribute("userId", userId);
			
			//비밀번호 찾기 화면으로 보내주기만 하면 됨
			url = "/member/searchPwd.jsp";
			forward(req, resp, url);
			
		}else if(uri.indexOf("searchId.do")!=-1) {
		
			//아이디 찾기 화면으로 보내주기만 하면 됨
			url = "/member/searchId.jsp";
			forward(req, resp, url);
			
		}else if(uri.indexOf("searchId_ok.do")!=-1) {
			
			//아이디 확인 시 받아야 할 두 개의 데이터
			String userName = req.getParameter("userName");
			String userTel = req.getParameter("userTel");
			
			//이름과 전화번호가 일치하는 아이디 읽어옴
			MemberDTO dto = dao.getReadData(userName, userTel);
			
			//아이디가 틀리거나 패스워드가 틀린 경우
			if(dto==null) {
			
				req.setAttribute("message", "이름 또는 전화번호를 정확히 입력하세요.");
				url = "/member/searchId.jsp";
				forward(req, resp, url);
				return;
			
			}
			
			req.setAttribute("userId", dto.getUserId());
			req.setAttribute("userName", userName);
			
			//비밀번호 찾기 화면으로 보내주기만 하면 됨
			url = "/member/searchId.jsp";
			forward(req, resp, url);
			
		}else if(uri.indexOf("updated.do")!=-1) {
			
			HttpSession session = req.getSession();
			CustomInfo info = 
					(CustomInfo)session.getAttribute("customInfo");
			
			MemberDTO dto = dao.getReadData(info.getUserId());
			
			if(dto==null) {
				url = cp + "/join/login.do";
				resp.sendRedirect(url);
			}
			//dto 보내주고 updated.do 페이지에서 dto에 있는 데이터 호출
			req.setAttribute("dto", dto);
			
			//개인정보 수정 화면으로 보내주기만 하면 됨
			url = "/member/updated.jsp";
			forward(req, resp, url);
			
		}else if(uri.indexOf("updated_ok.do")!=-1) {
			
			MemberDTO dto = new MemberDTO();
			
			dto.setUserName(req.getParameter("userName"));
			dto.setUserBirth(req.getParameter("userBirth"));
			dto.setUserTel(req.getParameter("userTel"));
			dto.setUserId(req.getParameter("userId"));
			
			dao.updateData(dto);
			
			url = cp;
			resp.sendRedirect(url);
			
		}
	}
}
