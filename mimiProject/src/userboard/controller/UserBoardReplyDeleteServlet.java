package userboard.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.model.vo.Board;
import userboard.exception.UserBoardException;
import userboard.model.service.UserBoardService;

/**
 * Servlet implementation class UserBoardReplyDeleteServlet
 */
@WebServlet("/userboardreplydelete")
public class UserBoardReplyDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserBoardReplyDeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8");
		RequestDispatcher view = null;
		
		// 전송온 값 꺼내서 변수/객체에 저장하기
		Board board = new Board();
		//board.setCommentUserId(mrequest.getParameter("userId")); 세션에서 아이디 획득 필요
		String cmtNo = request.getParameter("cmtNo");
		try {
			int result = new UserBoardService().deleteUserBoardReply(cmtNo);
			
			String returnValue = null;
			if (result > 0) {
				returnValue = "ok";
			} else {
				returnValue = "fail";
			}

				PrintWriter out = response.getWriter();
				out.append(returnValue);
				out.flush();
				out.close();		
			} catch (UserBoardException e) {
			view = request.getRequestDispatcher("views/userReview/userReviewError.jsp");
			request.setAttribute("message", e.getMessage());
			view.forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
