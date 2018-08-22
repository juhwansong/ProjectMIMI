package userboard.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import common.model.vo.Board;
import userboard.exception.UserBoardException;
import userboard.model.service.UserBoardService;

/**
 * Servlet implementation class UserBoardReplyInsertServlet
 */
@WebServlet("/userboardreplyinsert")
public class UserBoardReplyInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserBoardReplyInsertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8");
		System.out.println("시작");
		String boardNum = request.getParameter("bnum");
		RequestDispatcher view = null;
		
		// 전송온 값 꺼내서 변수/객체에 저장하기
		Board board = new Board();
		board.setCommentUserId(request.getParameter("userid"));	//카테고리 연결필요
		//board.setCommentUserId(mrequest.getParameter("userId")); 세션에서 아이디 획득 필요
		board.setCommentContents(request.getParameter("cmtContent"));
		System.out.println(boardNum +" " + board.getCommentUserId() + " " + board.getCommentContents());
		try {
			int result = new UserBoardService().insertUserBoardReply(boardNum, board);
			
			String returnValue = null;
			if (result > 0) {
				System.out.println("성공");
				returnValue = "ok";
			} else {
				System.out.println("실패");
				returnValue = "fail";
			}

				PrintWriter out = response.getWriter();
				out.append(returnValue);
				out.flush();
				out.close();		
			} catch (UserBoardException e) {
			System.out.println("실패");
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
