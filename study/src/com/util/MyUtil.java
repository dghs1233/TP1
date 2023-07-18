package com.util;

public class MyUtil {
	
	//��ü ������ �� ���ϱ�
	public int getPageCount(int numPerPage, int dataCount) {
		
		int pageCount = 0;
		//��ü ������ �� = ��ü ������ �� / �������� �����ִ� ������ ��
		pageCount = dataCount / numPerPage;
		
		//��ü ������ ���� �������� �����ִ� ���� ������ �� 
		//���� �������� ������ �� ������ �߰�
		if(dataCount % numPerPage != 0) {
			pageCount++;
		}
		
		return pageCount;
		
	}
	
	//������ ó�� �޼ҵ�(���� �� ���������� �޾Ƽ� ���)
	public String pageIndexList(int currentPage, int totalPage, String listUrl) {
		
		//������ �����ϴ� ��� �������� �Ѹ��ų�?(���� ����)
		int numPerBlock = 5;
		
		//���� �������� ���� ��(ǥ���� ù ������ -1)
		int currentPageSetup;
		
		//for���� i�� ���� ����
		int page;
		
		StringBuffer sb = new StringBuffer();
		
		if(currentPage==0 || totalPage==0) {
			return "";
		}
		
		//list.jsp -> + ?pageNum=2
		//list.jsp?searchKey=subject&searchValue=suzi -> + &pageNum=2
		//�˻� ���ο� ���� Url�� ?pageNum ���� &pageNum ���� ����
		if(listUrl.indexOf("?")!=-1) {
			listUrl += "&";
		}else {
			listUrl += "?";
		}
		
		/*
		������ 6 7 8 9 10 ������
		������ 11 12 13 14 15 ������
		"������"�� ���� ������ ��ȣ�� ���ϴ� ����(�� �������� ������ ��ȣ)
		���� ������ ������ ��ȣ / �� ���� ���̴� ������ ���� * �� ���� ���̴� ������ ����
		numPerBlock=5 �̸� currentPageSetup(����)���� 5�� ����� ��
		
		���� �Ʒ��� ���ǹ��� ���� �ʹٸ�
		currentPageSetup = (currentPage-1/numPerBlock)*numPerBlock;
		�� ó���ص� ��(����� ����)
		 */
		currentPageSetup = (currentPage/numPerBlock)*numPerBlock;
		
		/*
		���� ���̴� ������ ��ȣ�� �ش� ���� ������ ��ȣ�� ���
		�� ���Ŀ����� �������� ���� ������ ��ȣ ���� ���� ������
		numPerBlock ��ŭ ����� ��
		*/
		if(currentPage % numPerBlock == 0) {
			currentPageSetup = currentPageSetup - numPerBlock;
		}
		
		/*
		��ü ������ ���� numPerBlock���� ũ�� 
		�������� ���� 0���� ũ��(��, ���� ������ �������� �ּ� �ι�° ��)
		������ �����۸�ũ�� �����ϰ� url�� pageNum�� currentPageSetup ���� ������
		 */
		if(totalPage > numPerBlock && currentPageSetup > 0) {
			sb.append("<a href=\"" + listUrl + "pageNum=" +
					currentPageSetup + "\">������</a>&nbsp;");
			
			//<a href="list.jsp?pageNum=5">������</a>&nbsp;
		}
		
		/*
		������ 6 7 8 9 10 ������
		������ 11 12 13 14 15 ������
		�ٷΰ��� ������
		������ �ٷ� ������ �ٴ� ������ ��ȣ ����(numPerBlock=5 �̸� 5n+1)
		 */
		page = currentPageSetup + 1;
		
		/*
		�������� ��ü ������ ������ ũ�ų� 
		��������+numPerBlock �ʰ��ϸ� �ݺ��� ��������
		 */
		while(page <= totalPage && page <= (currentPageSetup+numPerBlock)) {
			
			//page���� ���� ������ ������ ��ȣ�� ������ ��ȫ������ ǥ���ϰ�
			//�����۸�ũ X
			if(page==currentPage) {
				sb.append("<font color=\"Fuchsia\">" + page + "</font>&nbsp;");
				//<font color = "Fuchsia">9</font>&nbsp;
			
			//������ ������ �̿ܿ��� �ش� ������ ��ȣ�� �ּҰ��� �־ �����۸�ũ ó��
			}else {
				sb.append("<a href=\"" + listUrl + "pageNum=" + page +
						"\">" + page + "</a>&nbsp;");
				//<a href="list.jsp?pageNum=8">8</a>
			}
			
			//������ ��ȣ ���������� �־���
			page++;
			
		}
		
		//������ 6 7 8 9 10 ������
		//������ ������ �� ������ ��� ���� ������ ǥ���ϰ� �����۸�ũ
		if(totalPage - currentPageSetup > numPerBlock) {
			
			sb.append("<a href=\"" + listUrl + "pageNum=" + page +
					"\">������</a>&nbsp;");
			//<a href="list.jsp?pageNum=11">������</a>&nbsp;
			
		}
		
		return sb.toString();
		
	}
	
}
