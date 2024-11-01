package com.kh.unionBoard.model.service;

import java.sql.Connection;

import com.kh.common.JDBCTemplate;
import com.kh.unionBoard.model.dao.UnionBoardDao;

public class UnionBoardService{
	
	
	//총 게시글 개수 조회

	public int listCount() {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int  listCount = new UnionBoardDao().listCount(conn);
		
		
		JDBCTemplate.close(conn);
		
		return listCount;
		
		
		
		
	}
	
	
	
	
	
	
	
}
