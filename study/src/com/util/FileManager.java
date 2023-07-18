package com.util;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletResponse;

public class FileManager {

	//파일 다운로드 메소드
	public static boolean doFileDownload(HttpServletResponse response,
			String saveFileName, String originalFileName, String path) {
		
		try {
			
			String filePath = path + File.separator + saveFileName;
			
			if(originalFileName==null || originalFileName.equals("")) {
				
				originalFileName = saveFileName;
			
			}
			/*
			//파일 이름이 한글일 때 한글이 깨지지 않게 함 
			originalFileName =
					new String(originalFileName.getBytes("euc-kr"), "ISO-8859-1");
			*/
			//
			File f = new File(filePath);
			
			//파일 없으면 종료
			if(!f.exists()) {
				return false;
			}
			
			//파일 이름 클라이언트한테 알려줌(?)
			response.setContentType("application/octet-stream");
			response.setHeader("Content-disposition", 
					"attachment;fileName=" + originalFileName);
			
			//파일을 읽어냄
			BufferedInputStream bis = new BufferedInputStream(
					new FileInputStream(f));
			
			//읽어낸 파일 정보를 출력(전송)
			OutputStream out = response.getOutputStream();
			
			int data;
			byte bytes[] = new byte[4096];
			while((data=bis.read(bytes, 0, 4096))!=-1) {
				
				out.write(bytes, 0, data);
				
			}
			
			out.flush();
			out.close();
			bis.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
			return false;
		}
		
		return true;
	}
	
	//물리적 파일 삭제 메소드
	public static void doFileDelete(String fileName, String path) {
		
		try {
			
			String filePath = path + File.separator + fileName;
			
			File f = new File(filePath);
			
			if(f.exists()) {
				f.delete();//물리적 파일 삭제
			}
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
	}
	
	
}
