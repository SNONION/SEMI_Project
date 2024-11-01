package com.kh.unionBoard.model.dao;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;

import com.kh.common.JDBCTemplate;
import com.kh.common.model.vo.PageInfo;
import com.kh.request.model.dao.RequestDao;
import com.kh.unionBoard.model.vo.UnionBoard;

public class UnionBoardDao {

	private Properties pro = new Properties();
	private PreparedStatement pstmt = null;
	private ResultSet rset = null;
	
	public UnionBoardDao() {
		
		String filePath = (RequestDao.class).getResource("/resources/driver/driver.properties").getPath();
		
		try {
			pro.loadFromXML(new FileInputStream(filePath));
			
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	
	   //총 게시글 개수 조회
	public int listCount(Connection conn) {
		
		 int listCount = 0;
		 
		 String sql = pro.getProperty("listCount");
		 
		 
		     try {
				pstmt = conn.prepareStatement(sql);
				
				rset = pstmt.executeQuery();
				
				if(rset.next()) {
					
					listCount = rset.getInt("COUNT");
				}
				
				
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				
				JDBCTemplate.close(rset);
				JDBCTemplate.close(pstmt);
			}
		
		
		
		return listCount;
	}


	//게시글 목록 조회
	public ArrayList<UnionBoard> selectList(Connection conn, PageInfo pi) {
		
		
		
		 
		 
		 ArrayList<UnionBoard> list = new ArrayList<>();
		 
		 
		 String sql = pro.getProperty("selectList");
		 
		 
		 
		 int startRow = (pi.getCurrentPage()-1) * pi.getUnionBoardLimit() +1;
		 
		 
		 int endRow = pi.getCurrentPage() * pi.getUnionBoardLimit();
		 
		 
		 
		    try {
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
				
				rset = pstmt.executeQuery();
				
			
				
			
								
				
				
				
			} catch (SQLException e) {
				
				e.printStackTrace();
			} finally {
				
				
				JDBCTemplate.close(rset);
				JDBCTemplate.close(pstmt);
			}
		
		
		return list;
	}
	
	
	//게시글 목록 조회 메소드
	
	
	
	
	
	
	
}
