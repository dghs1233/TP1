package com.join;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class MemberDAO {
	
	private Connection conn;
	
	public MemberDAO(Connection conn) {
		this.conn = conn;
	}
	
	//회원가입
	public int insertData(MemberDTO dto) {
		
		int result = 0;
		
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			
			sql = "insert into member (userId, userPwd, userName, ";
			sql += "userBirth, userTel) values (?, ?, ?, ?, ?)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getUserId());
			pstmt.setString(2, dto.getUserPwd());
			pstmt.setString(3, dto.getUserName());
			pstmt.setString(4, dto.getUserBirth());
			pstmt.setString(5, dto.getUserTel());
		
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}
	
	public MemberDTO getReadData(String userId) {
		
		MemberDTO dto = null;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			
			sql = "select userId, userPwd, userName, ";
			sql += "to_char(userBirth, 'yyyy-mm-dd') userBirth, userTel from member ";
			sql += "where userId=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userId);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				dto = new MemberDTO();
				
				dto.setUserId(rs.getString("userId"));
				dto.setUserPwd(rs.getString("userPwd"));
				dto.setUserName(rs.getString("userName"));
				dto.setUserBirth(rs.getString("userBirth"));
				dto.setUserTel(rs.getString("userTel"));
				
			}
			
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
		
	}
	
	//비밀번호 찾기 오버로딩
	public MemberDTO getReadData(String userId, String userName, String userBirth) {
		
		MemberDTO dto = null;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			
			sql = "select userPwd from member ";
			sql += "where userId=? and userName=? and userBirth=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userId);
			pstmt.setString(2, userName);
			pstmt.setString(3, userBirth);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				dto = new MemberDTO();
				
				dto.setUserPwd(rs.getString("userPwd"));
				
			}
			
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
		
	}
	
	//아이디 찾기 오버로딩
	public MemberDTO getReadData(String userName, String userTel) {
		
		MemberDTO dto = null;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			
			sql = "select userId, userTel from member ";
			sql += "where userName=? and userTel=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userName);
			pstmt.setString(2, userTel);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				dto = new MemberDTO();
				
				dto.setUserId(rs.getString("userId"));
				dto.setUserTel(rs.getString("userTel"));
				
			}
			
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
		
	}
	
	//수정
	public int updateData(MemberDTO dto) {
		
		int result = 0;
		
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			
			sql = "update member set userName=?, userBirth=?, userTel=? ";
			sql += "where userId=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getUserName());
			pstmt.setString(2, dto.getUserBirth());
			pstmt.setString(3, dto.getUserTel());
			pstmt.setString(4, dto.getUserId());

			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
	
	//계정삭제(탈퇴)
	public int deleteData(String userId) {
		
		int result = 0;
		
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			
			sql = "delete member where userId=?";
			
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
