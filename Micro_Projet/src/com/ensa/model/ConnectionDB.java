package com.ensa.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;


public class ConnectionDB {
	private Connection conn;
	private Statement st;
	
	public ConnectionDB() {
		conn = null;
		try {
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/market", "root", "");
			st=conn.createStatement();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public Connection getConn() {
		return conn;
	}

	public void setConn(Connection conn) {
		this.conn = conn;
		try {
			this.setSt(conn.createStatement());
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public Statement getSt() {
		return st;
	}

	public void setSt(Statement st) {
		this.st = st;
	}
	
	public void close() {
		try {
			if(conn!=null) conn.close();
		}catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
}
