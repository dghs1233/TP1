package com.naver;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class NaverDAO {
	
	private Connection conn;
	
	//스프링에서는 의존성 주입이라고 함
	public NaverDAO(Connection conn) {
		this.conn = conn;
	}
	
	//입력
	public int insertData(NaverDTO dto) {
		
		int result = 0;
		
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			
			sql = "insert into naver (userId, pwd, email, name, birth, ";
			sql += "telecom, sex, foreigner, phone) ";
			sql += "values (?, ?, ?, ?, ?, ?, ?, ?, ?)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getUserId());
			pstmt.setString(2, dto.getPwd());
			pstmt.setString(3, dto.getEmail());
			pstmt.setString(4, dto.getName());
			pstmt.setInt(5, dto.getBirth());
			pstmt.setString(6, dto.getTelecom());
			pstmt.setString(7, dto.getSex());
			pstmt.setString(8, dto.getForeigner());
			pstmt.setString(9, dto.getPhone());
			
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}
	
	//전체데이터 꺼내오기
	public List<NaverDTO> getlists() {
		
		List<NaverDTO> lists = new ArrayList<NaverDTO>();
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			
			sql = "select userId, pwd, email, name, birth, ";
			sql += "telecom, sex, foreigner, phone ";
			sql += "from naver order by name asc";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				NaverDTO dto = new NaverDTO();
				
				dto.setUserId(rs.getString("userId"));
				dto.setPwd(rs.getString("pwd"));
				dto.setEmail(rs.getString("email"));
				dto.setName(rs.getString("name"));
				dto.setBirth(rs.getInt("birth"));
				dto.setTelecom(rs.getString("telecom"));
				dto.setSex(rs.getString("sex"));
				dto.setForeigner(rs.getString("foreigner"));
				dto.setPhone(rs.getString("phone"));
				
				lists.add(dto);
			}
			
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return lists;
		
	}
	
	//수정할 데이터 가져오기
	public NaverDTO getReadData(String userId) {
		
		NaverDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			
			sql = "select userId, pwd, email, name, birth, telecom, ";
			sql += "sex, foreigner, phone from naver where userId=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userId);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				dto = new NaverDTO();
				
				dto.setUserId(rs.getString("userId"));
				dto.setPwd(rs.getString("pwd"));
				dto.setEmail(rs.getString("email"));
				dto.setName(rs.getString("name"));
				dto.setBirth(rs.getInt("birth"));
				dto.setTelecom(rs.getString("telecom"));
				dto.setSex(rs.getString("sex"));
				dto.setForeigner(rs.getString("foreigner"));
				dto.setPhone(rs.getString("phone"));
				
			}
			
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
	}
	
	//수정
	public int updateData(NaverDTO dto) {
		
		int result = 0;
		
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			
			sql = "update naver set email=?, telecom=?, foreigner=?, phone=? ";
			sql += "where userId=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getEmail());
			pstmt.setString(2, dto.getTelecom());
			pstmt.setString(3, dto.getForeigner());
			pstmt.setString(4, dto.getPhone());
			pstmt.setString(5, dto.getUserId());
			
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
	
	//삭제
	public int deleteData(String userId) {
		
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "delete naver where userId=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userId);
			
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
	
}
