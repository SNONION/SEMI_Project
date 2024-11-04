package com.kh.request.model.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.request.model.vo.Request;
import com.kh.user.model.service.UserService;

/**
 * Servlet implementation class RequestInsertController
 */
@WebServlet("/insertRequest.rq")
public class RequestInsertController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RequestInsertController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String userNo = request.getParameter("userNo");
		String requestTitle = request.getParameter("requestTitle");
		String requestContent = request.getParameter("requestContent");
		
		Request r = new Request();
		r.setRequestTitle(requestTitle);
		r.setRequestContent(requestContent);
		r.setRequestWriter(userNo);
		
		int result = new UserService().insertRequest(r);
		String alertMsg = null;
		
		if(result > 0) {
			alertMsg = "등록되었습니다.";
		}
		else {
			alertMsg = "요청 오류";
		}
		
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().print(alertMsg);
	}

}