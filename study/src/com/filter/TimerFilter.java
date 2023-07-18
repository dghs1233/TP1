package com.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

public class TimerFilter implements Filter{
//�ð��� ��� ����

	private FilterConfig config;
	
	@Override
	public void destroy() {
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		
		//������ ���� �ý��� �ð��� �� ��
		long start = System.currentTimeMillis();
		
		//���͸� �Ѱ��ִ� �۾�(������� req, �ش� req�� ���� resp)
		chain.doFilter(request, response);
		
		//���� ���� �ý��� �ð��� �� ��
		long end = System.currentTimeMillis();
		
		String uri;
		
		if(request instanceof HttpServletRequest) {
			
			//���͸� ����ϴ� ���� object������ �ٲ�� ������ �ٿ� ĳ����
			HttpServletRequest req = (HttpServletRequest)request;
			
			uri = req.getRequestURI();
			
			//������ ���۽ð�
			config.getServletContext().log(uri + ":" + (end - start) + "ms");
			
			//�ܼ�â�� ���̴� ���
			//System.out.println(uri + ":" + (end-start) + "ms");
		}
		
	}

	//������ �� filterConfig �� �־��� -> doFilter���� config�� �ʱ�ȭ��
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		
		this.config = filterConfig;
		
	}
	
}
