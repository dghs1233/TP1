package com.guest;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.board.BoardDTO;

public class GuestDAO {
	
	private Connection conn = null;
	
	public GuestDAO(Connection conn) {
		this.conn = conn;
	}
	
	//num의 최댓값 구하기
	public int getMaxNum() {
		
		int maxNum = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			
			sql = "select nvl(max(num),0) from guest";
			
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
	
	//작성한 방명록 데이터 DB에 저장
	public int insertData(GuestDTO dto) {
		
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			
			sql = "insert into guest (num, name, email, homepage, content, ";
			sql += "created, ipAddr) values (?, ?, ?, ?, ?, sysdate, ?)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, dto.getNum());
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getEmail());
			pstmt.setString(4, dto.getHomepage());
			pstmt.setString(5, dto.getContent());
			pstmt.setString(6, dto.getIpAddr());
			
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
	
	//DB에 있는 방명록 데이터를 DTO를 통해 전부 꺼내기
	public List<GuestDTO> getLists() {
		
		List<GuestDTO> lists = new ArrayList<GuestDTO>();
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			
			sql = "select num, name, email, homepage, content, ";
			sql += "created, ipAddr from guest order by num desc";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				//담을 그릇
				GuestDTO dto = new GuestDTO();
				
				dto.setNum(rs.getInt("num"));
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
				dto.setHomepage(rs.getString("homepage"));
				dto.setContent(rs.getString("content"));
				dto.setCreated(rs.getString("created"));
				dto.setIpAddr(rs.getString("ipAddr"));
				
				lists.add(dto);
				
			}
			
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return lists;
	}
	
	//글 번호를 받아서 해당 데이터 삭제
	public int deleteData(int num) {
		
		int result = 0;
		
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			
			sql = "delete guest where num=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
	
	//총 데이터 갯수 구하기(페이징에 활용)
	public int getDataCount() {
		
		int totalCount = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			
			sql = "select nvl(count(*),0) from guest";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				GuestDTO dto = new GuestDTO();
				
				pstmt = conn.prepareStatement(sql);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					totalCount = rs.getInt(1);
				}
				
				rs.close();
				pstmt.close();
				
			}
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return totalCount;
	}
	
	//start값과 end값을 받아서 해당 페이지의 게시글 불러오기
	public List<GuestDTO> getLists(int start, int end) {
		
		List<GuestDTO> lists = new ArrayList<GuestDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			
			sql = "select * from (";
			sql += "select rownum rnum, data.* from (";
			sql += "select num, name, email, homepage, content, ipAddr, ";
			sql += "to_char(created, 'yyyy-mm-dd') created ";
			sql += "from guest order by num desc) data) ";
			sql += "where rnum>=? and rnum<=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				GuestDTO dto = new GuestDTO();
				
				dto.setNum(rs.getInt("num"));
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
				dto.setHomepage(rs.getString("homepage"));
				dto.setContent(rs.getString("content"));
				dto.setCreated(rs.getString("created"));
				dto.setIpAddr(rs.getString("ipAddr"));
				
				lists.add(dto);
			}
			
			pstmt.close();
			rs.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return lists;
	}
	
}
