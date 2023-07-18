package com.fileTest;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.sql.Connection;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.util.DBConn;
import com.util.FileManager;
import com.util.MyUtil;

public class FileTestServlet extends HttpServlet{

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
	
	protected void forward(HttpServletRequest req, HttpServletResponse resp, String url) throws ServletException, IOException {
		
		RequestDispatcher rd = req.getRequestDispatcher(url);
		rd.forward(req, resp);
	
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		
		Connection conn = DBConn.getConnection();
		FileTestDAO dao = new FileTestDAO(conn);
		MyUtil myUtil = new MyUtil();
		
		String cp = req.getContextPath();
		String uri = req.getRequestURI();
		
		String url;
		
		//파일 저장 경로
		String root = getServletContext().getRealPath("/");
		String path = root + "pds" + File.separator + "saveFile";
		
		File f = new File(path);
		if(!f.exists()) {
			f.mkdirs();
		}
		
		if(uri.indexOf("write.do")!=-1) {
			
			url = "/fileTest/write.jsp";
			forward(req, resp, url);
			
		}else if(uri.indexOf("write_ok.do")!=-1) {
		
			String encType = "UTF-8";
			int maxSize = 10 * 1024 * 1024;
			
			//파일 업로드
			MultipartRequest mr = 
					new MultipartRequest(req, path, maxSize, encType,
							new DefaultFileRenamePolicy());
			
			//DB에 파일 정보 입력
			if(mr.getFile("upload")!=null) {
				
				int maxNum = dao.getMaxNum();
				
				FileTestDTO dto = new FileTestDTO();
				
				dto.setNum(maxNum + 1);
				dto.setSubject(mr.getParameter("subject"));
				dto.setSaveFileName(mr.getFilesystemName("upload"));
				dto.setOriginalFileName(mr.getOriginalFileName("upload"));
				
				dao.insertData(dto);
				
			}
			
			url = cp + "/file/list.do";
			resp.sendRedirect(url);
		
		}else if(uri.indexOf("list.do")!=-1) {
			
			String pageNum = req.getParameter("pageNum");
			//String searchKey = req.getParameter("searchKey");
			//String searchValue = req.getParameter("searchValue");
			
			int currentPage = 1;
			
			if(pageNum!=null) {
				currentPage = Integer.parseInt(pageNum);
			}
			
			/*
			if(searchValue==null) {
				
				searchKey = "subject";
				searchValue = "";
				
			}else {
				
				if(req.getMethod().equalsIgnoreCase("GET")) {
					
					searchValue = URLDecoder.decode(searchValue, "UTF-8");
					
				}
			}
			*/
			
			int dataCount = dao.getDataCount();
			int numPerPage = 5;
			int totalPage = myUtil.getPageCount(numPerPage, dataCount);
			
			if(currentPage>totalPage) {
				currentPage = totalPage;
			}
			
			int start = (currentPage - 1) * numPerPage + 1;
			int end = currentPage*numPerPage;
			
			//파일 정보 불러오기
			List<FileTestDTO> lists = dao.getLists(start, end);
			
			String listUrl = cp + "/file/list.do";
			
			String pageIndexList = 
					myUtil.pageIndexList(currentPage, totalPage, listUrl);
			
			//String fileUrl = cp + "/file/download.do?&pageNum=" +currentPage;
			
			//다운로드할 경로
			String downloadPath = cp + "/file/download.do";
			String deletePath = cp + "/file/delete.do";
			
			//이미지 파일은 실제 경로를 줘야 함
			//String imagePath = cp + "/pds/saveFile";
			
			//포워딩할 데이터(클래스에서 jsp로 넘겨줄 때 필요)
			//req.setAttribute("imagePath", imagePath);
			req.setAttribute("pageIndexList", pageIndexList);
			req.setAttribute("dataCount", dataCount);
			//req.setAttribute("fileUrl", fileUrl);
			req.setAttribute("deletePath", deletePath);
			req.setAttribute("downloadPath", downloadPath);
			req.setAttribute("lists", lists);
			
			url = "/fileTest/list.jsp";
			forward(req, resp, url);
			
		}else if(uri.indexOf("download.do")!=-1) {
			
			int num = Integer.parseInt(req.getParameter("num"));
			
			FileTestDTO dto = dao.getReadData(num);
			
			//파일 다운로드
			boolean flag = 
					FileManager.doFileDownload(resp, 
							dto.getSaveFileName(), 
							dto.getOriginalFileName(), path);
			
			//다운로드 실패 시
			if(flag==false) {
				
				resp.setContentType("text/html;charset=UTF-8");
				
				//클라이언트에게 Servlet으로 Javascript 내보냄
				PrintWriter out = resp.getWriter();
				out.print("<script type='text/javascript'>");
				out.print("alert('Download Error');");
				out.print("history.back();");
				out.print("</script>");
				
			}
		
		}else if(uri.indexOf("delete.do")!=-1) {
			
			int num = Integer.parseInt(req.getParameter("num"));
			
			//num으로 파일 데이터 꺼내옴
			FileTestDTO dto = dao.getReadData(num);
			
			//물리적 파일 삭제
			FileManager.doFileDelete(dto.getSaveFileName(), path);
			
			//테이블에서 파일 정보 삭제
			dao.deleteData(num);
			
			//리다이렉트
			url = cp + "/file/list.do";
			resp.sendRedirect(url);
			
		}
	}
	
}
