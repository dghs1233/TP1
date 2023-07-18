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
			
			//������ ���� ����
			MemberDTO dto = new MemberDTO();
			
			dto.setUserId(req.getParameter("userId"));
			dto.setUserPwd(req.getParameter("userPwd"));
			dto.setUserName(req.getParameter("userName"));
			dto.setUserBirth(req.getParameter("userBirth"));
			dto.setUserTel(req.getParameter("userTel"));
			
			dao.insertData(dto);
			
			//ȸ������ �ϸ� index.jsp�� ���� ����
			url = cp + "/index.jsp";
			resp.sendRedirect(url);
		
		}else if(uri.indexOf("login.do")!=-1) {
			
			//�α��� ȭ������ �����ֱ⸸ �ϸ� ��
			url = "/member/login.jsp";
			forward(req, resp, url);
			
		}else if(uri.indexOf("login_ok.do")!=-1) {
			
			//�α��� �� �޾ƾ� �� �� ���� ������
			String userId = req.getParameter("userId");
			String userPwd = req.getParameter("userPwd");
			
			//���̵� �����ϴ��� �о��
			MemberDTO dto = dao.getReadData(userId);
			
			//���̵� Ʋ���ų� �н����尡 Ʋ�� ���
			if(dto==null || (!dto.getUserPwd().equals(userPwd))) {
			
				req.setAttribute("message", "���̵� �Ǵ� �н����带 ��Ȯ�� �Է��ϼ���.");
				url = "/member/login.jsp";
				forward(req, resp, url);
				
				//�Ʒ��� ���� �ȵ�
				return;
			
			}
			
			//Ŭ���� ��ü ��������� ���� �� �� ����
			HttpSession session = req.getSession();
			
			CustomInfo info = new CustomInfo();
			
			info.setUserId(dto.getUserId());
			info.setUserName(dto.getUserName());

			//CustomInfo Ŭ������ ���ǿ� �ø�
			session.setAttribute("customInfo", info);
			
			//������ �ٲ�� index.jsp�� �����̷�Ʈ
			url = cp;
			resp.sendRedirect(url);
			
		//�α׾ƿ��� ���� �����ָ� ��
		}else if(uri.indexOf("logout_ok.do")!=-1) {
			
			HttpSession session = req.getSession();
			
			session.removeAttribute("customInfo");
			session.invalidate();
			
			url = cp;
			resp.sendRedirect(url);
		
		}else if(uri.indexOf("searchPwd.do")!=-1) {
			
			//��й�ȣ ã�� ȭ������ �����ֱ⸸ �ϸ� ��
			url = "/member/searchPwd.jsp";
			forward(req, resp, url);
			
		}else if(uri.indexOf("searchPwd_ok.do")!=-1) {
			
			//��й�ȣ Ȯ�� �� �޾ƾ� �� �� ���� ������
			String userId = req.getParameter("userId");
			String userName = req.getParameter("userName");
			String userBirth = req.getParameter("userBirth");
			
			//���̵�, �̸�, ��������� ��ġ�ϴ� �������� �н����� �о��
			MemberDTO dto = dao.getReadData(userId, userName, userBirth);
			
			//���̵� Ʋ���ų� �н����尡 Ʋ�� ���
			if(dto==null) {
			
				req.setAttribute("message", "���̵�, �̸�, ��������� ��Ȯ�� �Է��ϼ���.");
				url = "/member/searchPwd.jsp";
				forward(req, resp, url);
				return;
			
			}
			
			req.setAttribute("userPwd", dto.getUserPwd());
			req.setAttribute("userId", userId);
			
			//��й�ȣ ã�� ȭ������ �����ֱ⸸ �ϸ� ��
			url = "/member/searchPwd.jsp";
			forward(req, resp, url);
			
		}else if(uri.indexOf("searchId.do")!=-1) {
		
			//���̵� ã�� ȭ������ �����ֱ⸸ �ϸ� ��
			url = "/member/searchId.jsp";
			forward(req, resp, url);
			
		}else if(uri.indexOf("searchId_ok.do")!=-1) {
			
			//���̵� Ȯ�� �� �޾ƾ� �� �� ���� ������
			String userName = req.getParameter("userName");
			String userTel = req.getParameter("userTel");
			
			//�̸��� ��ȭ��ȣ�� ��ġ�ϴ� ���̵� �о��
			MemberDTO dto = dao.getReadData(userName, userTel);
			
			//���̵� Ʋ���ų� �н����尡 Ʋ�� ���
			if(dto==null) {
			
				req.setAttribute("message", "�̸� �Ǵ� ��ȭ��ȣ�� ��Ȯ�� �Է��ϼ���.");
				url = "/member/searchId.jsp";
				forward(req, resp, url);
				return;
			
			}
			
			req.setAttribute("userId", dto.getUserId());
			req.setAttribute("userName", userName);
			
			//��й�ȣ ã�� ȭ������ �����ֱ⸸ �ϸ� ��
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
			//dto �����ְ� updated.do ���������� dto�� �ִ� ������ ȣ��
			req.setAttribute("dto", dto);
			
			//�������� ���� ȭ������ �����ֱ⸸ �ϸ� ��
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
