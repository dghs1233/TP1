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
//시간을 재는 필터

	private FilterConfig config;
	
	@Override
	public void destroy() {
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		
		//시작할 때의 시스템 시간을 잴 것
		long start = System.currentTimeMillis();
		
		//필터를 넘겨주는 작업(사용자의 req, 해당 req에 따른 resp)
		chain.doFilter(request, response);
		
		//끝날 때의 시스템 시간을 잴 것
		long end = System.currentTimeMillis();
		
		String uri;
		
		if(request instanceof HttpServletRequest) {
			
			//필터를 통과하는 순간 object형으로 바뀌기 때문에 다운 캐스팅
			HttpServletRequest req = (HttpServletRequest)request;
			
			uri = req.getRequestURI();
			
			//데이터 전송시간
			config.getServletContext().log(uri + ":" + (end - start) + "ms");
			
			//콘솔창에 보이는 결과
			//System.out.println(uri + ":" + (end-start) + "ms");
		}
		
	}

	//시작할 때 filterConfig 값 넣어줌 -> doFilter에서 config에 초기화값
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		
		this.config = filterConfig;
		
	}
	
}
