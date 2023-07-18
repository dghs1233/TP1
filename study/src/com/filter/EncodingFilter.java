package com.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

public class EncodingFilter implements Filter{

	private String charset;
	
	@Override
	public void destroy() {
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		
		String uri;
		
		if(request instanceof HttpServletRequest) {
			
			HttpServletRequest req = (HttpServletRequest)request;
			
			//사용자가 입력한 주소값
			uri = req.getRequestURI();
			
			if(req.getMethod().equalsIgnoreCase("POST")) {
				
				//특정 페이지는 euc-kr로 처리하고 그 외에는 UTF-8로 처리
				if(uri.indexOf("abcd.do")!=-1) {
					req.setCharacterEncoding("euc-kr");
				}else {
					req.setCharacterEncoding(charset);					
				}
				
			}
			
		}
		//반드시 실행해줘야 함
		chain.doFilter(request, response);
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		
		charset = filterConfig.getInitParameter("charset");
		
		if(charset == null) {
			charset = "UTF-8";
		}
		
	}

}
