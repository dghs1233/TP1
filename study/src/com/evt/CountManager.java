package com.evt;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

//서블릿의 라이프 사이클과 속성
//HTTPSessionListener : 세션이 생성 또는 종료될 때의 라이프 사이클을 갖는 이벤트
//ServletContextListener : 서버가 시작 또는 중지될 때 사용하는 이벤트
public class CountManager implements HttpSessionListener{
	
	//싱글턴과 비슷(자기 자신을 객체로 생성)
	private static CountManager countManager;
	private static int count;

	public CountManager() {
		//자기 자신을 객체로 넣어줌
		countManager = this;
	}
	
	//동기화(동시에x)
	//몇번을 실행해도 한 번만 실행됨
	public static synchronized CountManager getInstance() {
		
		if(countManager==null) {
			//객체 생성
			countManager = new CountManager();
		}
		
		return countManager;
		
	}
	
	public static int getCount() {
		return count;
	}
	
	@Override
	public void sessionCreated(HttpSessionEvent evt) {
		
		//접속하면 그 자체가 이벤트고 그 세션 데이터를 받아옴
		HttpSession session = evt.getSession();
		session.setMaxInactiveInterval(5*60);//5분
		
		count++;
		
		System.out.print(session.getId() + " : 세션생성, ");
		System.out.println("접속자 수 : " + count);
		
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent evt) {
		
		HttpSession session = evt.getSession();
		
		count--;
		
		//설정해놓은 10분이 지났는데 아무런 행동이 없으면 세션 소멸되고
		//접속자 수는 -1
		System.out.print(session.getId() + " : 세션소멸, ");
		System.out.println("접속자 수 : " + count);
		
	}

}
