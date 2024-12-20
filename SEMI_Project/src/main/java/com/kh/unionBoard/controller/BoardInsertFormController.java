package com.kh.unionBoard.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.unionBoard.model.service.UnionBoardService;
import com.kh.unionBoard.model.vo.Category;
import com.kh.user.model.service.UserService;

/**
 * Servlet implementation class BoardInsertController
 */
@WebServlet("/boardEnrollForm.un")
public class BoardInsertFormController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardInsertFormController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int userNo = Integer.parseInt(request.getParameter("userNo"));
		String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date()); 
		String nickname = new UserService().selectNickname(userNo);
		ArrayList<Category> cList = new UnionBoardService().selectCategory();
		
		request.setAttribute("cList", cList);
		request.setAttribute("date", date);
		request.setAttribute("userNo", userNo);
		request.setAttribute("nickname", nickname);
		request.getRequestDispatcher("/views/unionBoard/boardEnrollFormView.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
