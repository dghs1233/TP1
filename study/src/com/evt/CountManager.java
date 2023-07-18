package com.evt;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

//������ ������ ����Ŭ�� �Ӽ�
//HTTPSessionListener : ������ ���� �Ǵ� ����� ���� ������ ����Ŭ�� ���� �̺�Ʈ
//ServletContextListener : ������ ���� �Ǵ� ������ �� ����ϴ� �̺�Ʈ
public class CountManager implements HttpSessionListener{
	
	//�̱��ϰ� ���(�ڱ� �ڽ��� ��ü�� ����)
	private static CountManager countManager;
	private static int count;

	public CountManager() {
		//�ڱ� �ڽ��� ��ü�� �־���
		countManager = this;
	}
	
	//����ȭ(���ÿ�x)
	//����� �����ص� �� ���� �����
	public static synchronized CountManager getInstance() {
		
		if(countManager==null) {
			//��ü ����
			countManager = new CountManager();
		}
		
		return countManager;
		
	}
	
	public static int getCount() {
		return count;
	}
	
	@Override
	public void sessionCreated(HttpSessionEvent evt) {
		
		//�����ϸ� �� ��ü�� �̺�Ʈ�� �� ���� �����͸� �޾ƿ�
		HttpSession session = evt.getSession();
		session.setMaxInactiveInterval(5*60);//5��
		
		count++;
		
		System.out.print(session.getId() + " : ���ǻ���, ");
		System.out.println("������ �� : " + count);
		
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent evt) {
		
		HttpSession session = evt.getSession();
		
		count--;
		
		//�����س��� 10���� �����µ� �ƹ��� �ൿ�� ������ ���� �Ҹ�ǰ�
		//������ ���� -1
		System.out.print(session.getId() + " : ���ǼҸ�, ");
		System.out.println("������ �� : " + count);
		
	}

}
