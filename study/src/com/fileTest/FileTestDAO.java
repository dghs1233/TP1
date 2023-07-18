package com.fileTest;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.guest.GuestDTO;
import com.join.MemberDTO;

public class FileTestDAO {

	private Connection conn = null;
	
	public FileTestDAO(Connection conn) {
		this.conn = conn;
	}
	
	public int getMaxNum() {
		
		int maxNum = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			
			sql = "select nvl(max(num),0) from fileTest";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				maxNum = rs.getInt(1);
			}
			
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return maxNum;
	}
	
	public int insertData(FileTestDTO dto) {
		
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			
			sql = "insert into fileTest (num, subject, saveFileName, originalFileName) ";
			sql += "values (?, ?, ?, ?)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, dto.getNum());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getSaveFileName());
			pstmt.setString(4, dto.getOriginalFileName());
			
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
		
	}
	
	//전체 데이터 불러와서 리스트에 페이징 후 출력
	//전체 데이터를 한 페이지에 출력 시에는 start, end가 없어도 됨
	//sql문도 단순히 테이블 내의 데이터를 가져오면 됨
	//검색을 추가하게 되면 내부쿼리에 where searchKey like=? 추가해주고
	//getLists에 변수 searchKey, searchValue 추가
	public List<FileTestDTO> getLists(int start, int end) {
		
		List<FileTestDTO> lists = new ArrayList<FileTestDTO>();
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			
			sql = "select * from (";
			sql += "select rownum rnum, data.* from (";
			sql += "select num, subject, saveFileName, originalFileName ";
			sql += "from fileTest order by num desc) data) ";
			sql += "where rnum>=? and rnum<=?";
			
			pstmt = conn.prepareStatement(sql);
			
			//pstmt.setString(1, searchValue);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				//담을 그릇
				FileTestDTO dto = new FileTestDTO();
				
				dto.setNum(rs.getInt("num"));
				dto.setSubject(rs.getString("subject"));
				dto.setSaveFileName(rs.getString("saveFileName"));
				dto.setOriginalFileName(rs.getString("originalFileName"));
				
				lists.add(dto);
				
			}
			
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return lists;
		
	}
	
	public FileTestDTO getReadData(int num) {
		
		FileTestDTO dto = null;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			
			sql = "select num, subject, saveFileName, originalFileName ";
			sql += "from fileTest where num=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				dto = new FileTestDTO();
				
				dto.setNum(rs.getInt("num"));
				dto.setSubject(rs.getString("subject"));
				dto.setSaveFileName(rs.getString("saveFileName"));
				dto.setOriginalFileName(rs.getString("originalFileName"));
				
			}
			
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
		
	}
	
	public int deleteData(int num) {
		
		int result = 0;
		
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			
			sql = "delete fileTest where num=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
		
	}
	
	//전체 데이터 갯수(검색할 시 받는 데이터로 결정)
	public int getDataCount() {
		
		int totalData = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			
			//검색어가 들어간 게시물 전부 출력하기 위해 % 사용
			//searchValue = "%" + searchValue + "%";
			
			sql = "select nvl(count(*),0) from fileTest";
			//sql += "where " + searchKey + " like ?";
			
			pstmt = conn.prepareStatement(sql);
			
			//pstmt.setString(1, searchValue);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				totalData = rs.getInt(1);
			}
			
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return totalData;
	}
	
}
