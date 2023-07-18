package com.svt;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Test3 extends HttpServlet{

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//한글이 깨지지 않게끔 하는 코드
		req.setCharacterEncoding("UTF-8");
		
		String name = req.getParameter("name");
		String age = req.getParameter("age");
		
		String str = name + "의 나이는 " + age + "살 입니다";
		
		//result라는 변수에 str을 넣을 것
		req.setAttribute("result", str);
		
		//포워딩
		RequestDispatcher rd = 
				req.getRequestDispatcher("/servlet/result.jsp");
		
		rd.forward(req, resp);
		
	}
	
}
