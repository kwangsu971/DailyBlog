package writing;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class WritingDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public WritingDAO () {
		try {
			String dbURL="jdbc:mysql://localhost:3306/blog";
			String dbID ="root";
			String dbPassword = "1234";
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(dbURL, dbID, dbPassword);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public String getDate() {
		String SQL = "SELECT NOW()";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return"";
	}
	
	public int getNext() {
		String SQL = "SELECT writingID FROM writing ORDER BY writingID DESC";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1;
			}
			return 1;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	public int write(String writingTitle, String userID, String writingContent) {
		String SQL = "INSERT INTO writing(writingID, writingTitle, userID, writingDate, writingContent, writingAvailable) VALUES (?, ?, ?, ?, ?, ?)";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, writingTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, writingContent);
			pstmt.setInt(6, 1);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	public ArrayList<Writing> getList(int pageNumber){
		String SQL = "SELECT * FROM writing WHERE writingID < ? AND writingAvailable = 1 ORDER BY writingID DESC LIMIT 10";
		ArrayList<Writing> list = new ArrayList<Writing>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Writing writing = new Writing();
				writing.setWritingID(rs.getInt(1));
				writing.setWritingTitle(rs.getString(2));
				writing.setUserID(rs.getString(3));
				writing.setWritingDate(rs.getString(4));
				writing.setWritingContent(rs.getString(5));
				writing.setWritingaVailable(rs.getInt(6));
				list.add(writing);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM writing WHERE writingID < ? AND writingAvailable = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
		}catch(Exception e) { 
			e.printStackTrace();
		}
		return false;
	}
	
	public Writing getWriting(int writingID) {
		String SQL = "SELECT * FROM writing where writingID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, writingID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Writing writing = new Writing();
				writing.setWritingID(rs.getInt(1));
				writing.setWritingTitle(rs.getString(2));
				writing.setUserID(rs.getString(3));
				writing.setWritingDate(rs.getString(4));
				writing.setWritingContent(rs.getString(5));
				writing.setWritingaVailable(rs.getInt(6));
				return writing;
			}
		}catch(Exception e) { 
			e.printStackTrace();
		}
		return null;
	}
}
	

