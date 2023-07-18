package com.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BoardDAO {

	private Connection conn = null;
	
	public BoardDAO(Connection conn) {
		this.conn = conn;
	}
	
	/* 
	   따로 만들 필요 없이 getLists 메소드에서 내부쿼리를 통해
	   전체 데이터 수를 받아낼 예정
	   
	public int getDataCount() {
		
		int dataCount = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "select max(rownum) from board";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				//max(num)이 파생컬럼이므로 1을 써줘야 함
				dataCount = rs.getInt(1);
				
			}
			
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return dataCount;
	}
	*/
	
	//num의 최대값
	public int getMaxNum() {
		
		int maxNum = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "select nvl(max(num),0) from board";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				//max(num)이 파생컬럼이므로 1을 써줘야 함
				maxNum = rs.getInt(1);
				
			}
			
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return maxNum;
	}
	
	//입력
	public int insertData(BoardDTO dto) {
		
		int result = 0;
		
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			
			sql = "insert into board (num, name, pwd, email, ";
			sql += "subject, content, ipAddr, hitCount, created) ";
			sql += "values (?, ?, ?, ?, ?, ?, ?, 0, sysdate)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, dto.getNum());
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getPwd());
			pstmt.setString(4, dto.getEmail());
			pstmt.setString(5, dto.getSubject());
			pstmt.setString(6, dto.getContent());
			pstmt.setString(7, dto.getIpAddr());
			
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
	
	//전체 데이터 갯수(검색할 시 받는 데이터로 결정)
	public int getDataCount(String searchKey, String searchValue) {
		
		int totalData = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			
			//검색어가 들어간 게시물 전부 출력하기 위해 % 사용
			searchValue = "%" + searchValue + "%";
			
			sql = "select nvl(count(*),0) from board ";
			sql += "where " + searchKey + " like ?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, searchValue);
			
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
	
	
	//전체 데이터 가져오기
	public List<BoardDTO> getLists(int start, int end, String searchKey, String searchValue) {
	
		List<BoardDTO> lists = new ArrayList<BoardDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			
			//검색어가 포함된 모든 결과물 출력하기 위한 코드
			searchValue = "%" + searchValue + "%";
			
			sql = "select * from (";
			sql += "select rownum rnum, data.* from (";
			sql += "select num, name, subject, hitCount, ";
			sql += "to_char(created, 'yyyy-mm-dd') created ";
			sql += "from board where " + searchKey + " like ? order by num desc) data) ";
			sql += "where rnum>=? and rnum<=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, searchValue);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				BoardDTO dto = new BoardDTO();
				
				dto.setNum(rs.getInt("num"));
				dto.setName(rs.getString("name"));
				dto.setSubject(rs.getString("subject"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setCreated(rs.getString("created"));
				
				lists.add(dto);
			}
			
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return lists;
	}
	
	//조회수 증가
	public int updateHitCount(int num) {
		
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			
			sql = "update board set hitCount=hitCount+1 where num=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
	
	//num으로 조회한 하나의 데이터 -> article로 보여줌
	public BoardDTO getReadData(int num) {
		
		BoardDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			
			sql = "select num, name, pwd, email, subject, content, ipAddr, ";
			sql += "hitCount, created from board where num=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				//객체 생성해서 저장소 만듦
				dto = new BoardDTO();
				
				dto.setNum(rs.getInt("num"));
				dto.setName(rs.getString("name"));
				dto.setPwd(rs.getString("pwd"));
				dto.setEmail(rs.getString("email"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setIpAddr(rs.getString("ipAddr"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setCreated(rs.getString("created"));
				
			}
			
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}
	
	//수정
	public int updateData(BoardDTO dto) {
		
		int result = 0;
		
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			
			sql = "update board set name=?, pwd=?, email=?, subject=?,";
			sql += "content=? where num=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getPwd());
			pstmt.setString(3, dto.getEmail());
			pstmt.setString(4, dto.getSubject());
			pstmt.setString(5, dto.getContent());
			pstmt.setInt(6, dto.getNum());
			
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
	
	//삭제
	public int deleteData(int num) {
		
		int result = 0;
		
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			
			sql = "delete board where num=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
	
}
