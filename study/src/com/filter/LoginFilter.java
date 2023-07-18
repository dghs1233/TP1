package com.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class LoginFilter implements Filter{

	//나갈 때는 잘 안함
	@Override
	public void destroy() {
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		
		boolean flag = false;
		
		if(request instanceof HttpServletRequest) {
			
			HttpServletRequest req = (HttpServletRequest)request;
			
			//세션 생성
			HttpSession session = req.getSession();
			
			//로그인 했을 때
			if(session!=null) {
				
				//세션이 있을 때
				if(session.getAttribute("customInfo")!=null) {
					flag = true;
				}
				
			}
			
		}
		
		if(flag) {
			chain.doFilter(request, response);
		
		//로그인 안돼있으면 포워딩
		}else {
			RequestDispatcher rd = 
					request.getRequestDispatcher("/member/login.jsp");
			rd.forward(request, response);
		}
		
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
	}

}
