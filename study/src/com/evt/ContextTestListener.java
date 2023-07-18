package com.evt;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

//��Ĺ ������ �����ϰ� ������ ��
public class ContextTestListener implements ServletContextListener {

	//������ ���� ��
	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		
		System.out.println("���� �״´�...");
		
	}

	//������ ��Ƴ� ��
	@Override
	public void contextInitialized(ServletContextEvent sce) {
		
		System.out.println("���� ��Ƴ���...");
		
		ServletContext sc = sce.getServletContext();
		
		//name�̶�� ������ ������Ʈ ��𿡼��� ��� ����
		sc.setAttribute("name", "�����");
		
	}

}
