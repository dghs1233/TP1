package com.util;

public class MyUtil {
	
	//전체 페이지 수 구하기
	public int getPageCount(int numPerPage, int dataCount) {
		
		int pageCount = 0;
		//전체 페이지 수 = 전체 데이터 수 / 페이지당 보여주는 데이터 수
		pageCount = dataCount / numPerPage;
		
		//전체 데이터 수를 페이지당 보여주는 수로 나눴을 때 
		//나눠 떨어지지 않으면 한 페이지 추가
		if(dataCount % numPerPage != 0) {
			pageCount++;
		}
		
		return pageCount;
		
	}
	
	//페이지 처리 메소드(현재 몇 페이지인지 받아서 출력)
	public String pageIndexList(int currentPage, int totalPage, String listUrl) {
		
		//페이지 선택하는 몇개의 페이지를 뿌릴거냐?(임의 설정)
		int numPerBlock = 5;
		
		//이전 페이지에 들어가는 값(표시할 첫 페이지 -1)
		int currentPageSetup;
		
		//for문의 i와 같은 역할
		int page;
		
		StringBuffer sb = new StringBuffer();
		
		if(currentPage==0 || totalPage==0) {
			return "";
		}
		
		//list.jsp -> + ?pageNum=2
		//list.jsp?searchKey=subject&searchValue=suzi -> + &pageNum=2
		//검색 여부에 따라 Url에 ?pageNum 할지 &pageNum 할지 결정
		if(listUrl.indexOf("?")!=-1) {
			listUrl += "&";
		}else {
			listUrl += "?";
		}
		
		/*
		◀이전 6 7 8 9 10 다음▶
		◀이전 11 12 13 14 15 다음▶
		"◀이전"에 들어가는 페이지 번호를 구하는 공식(전 페이지의 마지막 번호)
		현재 지정된 페이지 번호 / 한 블럭당 보이는 페이지 갯수 * 한 블럭당 보이는 페이지 갯수
		numPerBlock=5 이면 currentPageSetup(이전)에는 5의 배수가 들어감
		
		만약 아래의 조건문을 빼고 싶다면
		currentPageSetup = (currentPage-1/numPerBlock)*numPerBlock;
		로 처리해도 됨(방식의 차이)
		 */
		currentPageSetup = (currentPage/numPerBlock)*numPerBlock;
		
		/*
		현재 보이는 페이지 번호가 해당 블럭의 마지막 번호인 경우
		위 공식에서는 ◀이전에 현재 페이지 번호 값이 들어가기 때문에
		numPerBlock 만큼 빼줘야 함
		*/
		if(currentPage % numPerBlock == 0) {
			currentPageSetup = currentPageSetup - numPerBlock;
		}
		
		/*
		전체 페이지 수가 numPerBlock보다 크고 
		◀이전의 값이 0보다 크면(즉, 현재 지정된 페이지가 최소 두번째 블럭)
		◀이전 하이퍼링크를 생성하고 url에 pageNum에 currentPageSetup 값을 데려감
		 */
		if(totalPage > numPerBlock && currentPageSetup > 0) {
			sb.append("<a href=\"" + listUrl + "pageNum=" +
					currentPageSetup + "\">◀이전</a>&nbsp;");
			
			//<a href="list.jsp?pageNum=5">◀이전</a>&nbsp;
		}
		
		/*
		◀이전 6 7 8 9 10 다음▶
		◀이전 11 12 13 14 15 다음▶
		바로가기 페이지
		◀이전 바로 다음에 붙는 페이지 번호 지정(numPerBlock=5 이면 5n+1)
		 */
		page = currentPageSetup + 1;
		
		/*
		페이지가 전체 페이지 수보다 크거나 
		◀이전값+numPerBlock 초과하면 반복문 빠져나감
		 */
		while(page <= totalPage && page <= (currentPageSetup+numPerBlock)) {
			
			//page값이 현재 지정된 페이지 번호와 같으면 분홍색으로 표시하고
			//하이퍼링크 X
			if(page==currentPage) {
				sb.append("<font color=\"Fuchsia\">" + page + "</font>&nbsp;");
				//<font color = "Fuchsia">9</font>&nbsp;
			
			//지정된 페이지 이외에는 해당 페이지 번호를 주소값에 넣어서 하이퍼링크 처리
			}else {
				sb.append("<a href=\"" + listUrl + "pageNum=" + page +
						"\">" + page + "</a>&nbsp;");
				//<a href="list.jsp?pageNum=8">8</a>
			}
			
			//페이지 번호 순차적으로 넣어줌
			page++;
			
		}
		
		//◀이전 6 7 8 9 10 다음▶
		//마지막 페이지 블럭 제외한 모든 블럭에 다음▶ 표시하고 하이퍼링크
		if(totalPage - currentPageSetup > numPerBlock) {
			
			sb.append("<a href=\"" + listUrl + "pageNum=" + page +
					"\">다음▶</a>&nbsp;");
			//<a href="list.jsp?pageNum=11">다음▶</a>&nbsp;
			
		}
		
		return sb.toString();
		
	}
	
}
