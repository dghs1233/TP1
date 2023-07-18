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
	
		//jsp������ <%@ page contentType="text/html; charset=UTF-8"%>
		response.setContentType("text/html;charset=utf-8");
	
		try {
			
			PrintWriter out = response.getWriter();
			out.print("<html>");
			out.print("<head>");
			out.print("<title>");
			out.print("servlet ����</title></head>");
			out.print("<body style='font-size:9pt;'>");
			out.print("ȭ�� �������� Servlet���� JSP�� ���ϴ�");
			out.print("</body>");
			out.print("</html>");
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
	}

}
