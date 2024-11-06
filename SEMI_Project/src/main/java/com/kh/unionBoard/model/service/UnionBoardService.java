package com.kh.unionBoard.model.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.kh.common.JDBCTemplate;
import com.kh.common.model.vo.PageInfo;
import com.kh.unionBoard.model.dao.UnionBoardDao;
import com.kh.unionBoard.model.vo.Category;
import com.kh.unionBoard.model.vo.UnionBoard;

public class UnionBoardService{
	
	
	//총 게시글 개수 조회메소드

	public int listCount() {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int  listCount = new UnionBoardDao().listCount(conn);
		
		
		JDBCTemplate.close(conn);
		
		return listCount;
		
		
		
		
	}
	
	
   //게시글 목록 조회 메소 드
	
	
	
	
	//조회수 증 가 메소드
	
	public int increaseCount(int bno) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new UnionBoardDao().increaseCount(conn,bno);
		
		if(result>0) {
			
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		
		JDBCTemplate.close(conn);
		
		
		return result;
	}


	public UnionBoard selectBoard(int bno) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		UnionBoard b = new UnionBoardDao().selectBoard(conn,bno);
		
		
		JDBCTemplate.close(conn);
		
		
		return b;
	
	
	}


	public ArrayList<UnionBoard> selectList(PageInfo pi) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<UnionBoard> list = new UnionBoardDao().selectList(conn,pi);
		
		
		JDBCTemplate.close(conn);

		return list;
		
		
		
	}
	
	
}
