package com.evt;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

//톰캣 서버가 시작하고 중지할 때
public class ContextTestListener implements ServletContextListener {

	//서버가 죽을 때
	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		
		System.out.println("서버 죽는다...");
		
	}

	//서버가 살아날 때
	@Override
	public void contextInitialized(ServletContextEvent sce) {
		
		System.out.println("서버 살아난다...");
		
		ServletContext sc = sce.getServletContext();
		
		//name이라는 변수는 프로젝트 어디에서나 사용 가능
		sc.setAttribute("name", "배수지");
		
	}

}
