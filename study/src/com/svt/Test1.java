package com.svt;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.GenericServlet;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class Test1 extends GenericServlet{

	@Override
	public void service(ServletRequest request, ServletResponse response) 
			throws ServletException, IOException {
	
		//jsp파일의 <%@ page contentType="text/html; charset=UTF-8"%>
		response.setContentType("text/html;charset=utf-8");
	
		try {
			
			PrintWriter out = response.getWriter();
			out.print("<html>");
			out.print("<head>");
			out.print("<title>");
			out.print("servlet 예제</title></head>");
			out.print("<body style='font-size:9pt;'>");
			out.print("화면 디자인은 Servlet보다 JSP가 편하다");
			out.print("</body>");
			out.print("</html>");
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
	}

}
