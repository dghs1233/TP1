package com.util;

import java.sql.Connection;
import java.sql.DriverManager;

import org.omg.CORBA.PRIVATE_MEMBER;

public class DBConn {

	private static Connection conn = null;
		
	public static Connection getConnection() {
		String url = "jdbc:oracle:thin:@192.168.16.21:1521:xe";
		String user = "suzi";
		String pwd = "a123";
		
		if(conn==null) {
			try {
				
				Class.forName("oracle.jdbc.driver.OracleDriver");
				conn = DriverManager.getConnection(url, user, pwd);
				
			} catch (Exception e) {
				System.out.println(e.toString());
			}
		}
		
		return conn;
	}
		
	public static void close() {
		if(conn==null) {
			return;
		}
		
		try {
			if(!conn.isClosed()) {
				conn.close();
			}
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		//안해주면 나중에 adapter 오류가 뜸
		conn = null;
	}
	
	
	
	
	
}
