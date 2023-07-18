package com.imageFile;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
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

public class ImageFileServlet extends HttpServlet{

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
		ImageDAO dao = new ImageDAO(conn);
		MyUtil myUtil = new MyUtil();
		
		String cp = req.getContextPath();
		String uri = req.getRequestURI();
		
		String url;
		
		//servercore���� ���
		String root = getServletContext().getRealPath("/");
		//���� ���� ���
		String path = root + "pds" + File.separator + "saveFile";
		
		File f = new File(path);
		
		//��� �������� ������ ���丮 �������
		if(!f.exists()) {
			f.mkdirs();
		}
		
		if(uri.indexOf("write.do")!=-1) {
			
			url = "/imageFile/write.jsp";
			forward(req, resp, url);
			
		}else if(uri.indexOf("write_ok.do")!=-1) {
		
			//�ѱ۸� ������ �ʰ� ó��
			String encType = "UTF-8";
			int maxSize = 10 * 1024 * 1024;//10mb
			
			//������ ���� ���ε�
			MultipartRequest mr = 
					new MultipartRequest(req, path, maxSize, encType,
							new DefaultFileRenamePolicy());
			
			//DB�� ���� ���� insert
			if(mr.getFile("upload")!=null) {
				
				int maxNum = dao.getMaxNum();
				
				ImageDTO dto = new ImageDTO();
				
				dto.setNum(maxNum + 1);
				dto.setSubject(mr.getParameter("subject"));
				dto.setSaveFileName(mr.getFilesystemName("upload"));
				dto.setOriginalFileName(mr.getOriginalFileName("upload"));
				
				dao.insertData(dto);
				
			}
			
			url = cp + "/image/list.do";
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
			int numPerPage = 9;
			int totalPage = myUtil.getPageCount(numPerPage, dataCount);
			
			if(currentPage>totalPage) {
				currentPage = totalPage;
			}
			
			int start = (currentPage - 1) * numPerPage + 1;
			int end = currentPage*numPerPage;
			
			//���� ���� �ҷ�����
			List<ImageDTO> lists = dao.getLists(start, end);
			
			String listUrl = cp + "/image/list.do";
			
			String pageIndexList = 
					myUtil.pageIndexList(currentPage, totalPage, listUrl);
			
			//String fileUrl = cp + "/file/download.do?&pageNum=" +currentPage;
			
			//�ٿ�ε� ���
			String downloadPath = cp + "/image/download.do";
			
			//���� ���
			String deletePath = cp + "/image/delete.do";
			
			//�̹��� ������ ���� ��θ� ��� ��
			String imagePath = cp + "/pds/saveFile";
			
			//�������� ������(Ŭ�������� jsp�� �Ѱ��� �� �ʿ�)
			req.setAttribute("imagePath", imagePath);
			req.setAttribute("pageIndexList", pageIndexList);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("pageNum", pageNum);
			req.setAttribute("totalPage", totalPage);
			//req.setAttribute("fileUrl", fileUrl);
			req.setAttribute("deletePath", deletePath);
			req.setAttribute("downloadPath", downloadPath);
			req.setAttribute("lists", lists);
			
			url = "/imageFile/list2.jsp";
			forward(req, resp, url);
			
		}else if(uri.indexOf("download.do")!=-1) {
			
			int num = Integer.parseInt(req.getParameter("num"));
			
			ImageDTO dto = dao.getReadData(num);
			
			//���� �ٿ�ε�
			boolean flag = 
					FileManager.doFileDownload(resp, 
							dto.getSaveFileName(), 
							dto.getOriginalFileName(), path);
			
			//�ٿ�ε� ���� �� alert�ϰ� ����ȭ������ ���ư���
			if(flag==false) {
				
				resp.setContentType("text/html;charset=UTF-8");
				
				//Ŭ���̾�Ʈ���� Servlet���� Javascript ������
				PrintWriter out = resp.getWriter();
				out.print("<script type='text/javascript'>");
				out.print("alert('Download Error');");
				
				//����ȭ��
				out.print("history.back();");
				out.print("</script>");
				
			}
		
		}else if(uri.indexOf("delete.do")!=-1) {
			
			int num = Integer.parseInt(req.getParameter("num"));
			
			//num���� ���� ������ ������ DTO�� �־��
			ImageDTO dto = dao.getReadData(num);
			
			//������ ���� ����
			//DTO�� ���õ� SaveFileName �޾ƿͼ� ��ġ�ϴ� ���� ����
			FileManager.doFileDelete(dto.getSaveFileName(), path);
			
			//���̺��� ���� ���� ����
			dao.deleteData(num);
			
			//�����̷�Ʈ
			url = cp + "/image/list.do";
			resp.sendRedirect(url);
			
		}
	}
	

}
