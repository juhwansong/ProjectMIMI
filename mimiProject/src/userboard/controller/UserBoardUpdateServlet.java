package userboard.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.model.vo.Board;
import userboard.exception.UserBoardException;
import userboard.model.service.UserBoardService;

/**
 * Servlet implementation class UserBoardUpdateServlet
 */
@WebServlet("/userboardupdate")
public class UserBoardUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserBoardUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8");
		
		String boardNum = request.getParameter("bnum");
		int currentPage = Integer.parseInt(request.getParameter("page"));
		String buserId = request.getParameter("buserId");

		HttpSession session = request.getSession();	
		String authority = (String)session.getAttribute("authority");
		String userId = (String)session.getAttribute("userId");		
		
		RequestDispatcher view = null;
		try {
				if((authority != null && authority.equals("A")) || (userId != null && userId.equals(buserId))){
					Board board = new UserBoardService().selectUserBoard(boardNum);
					
					if(board != null){
						view = request.getRequestDispatcher(
								"views/userReview/userReviewUpdate.jsp");
						if(board.getShopCall()==null)
							board.setShopCall("");
						
						request.setAttribute("board", board);
						request.setAttribute("currentPage", currentPage);
						view.forward(request, response);
					}else{
					view = request.getRequestDispatcher(
							"views/userReview/userReviewError.jsp");
					request.setAttribute("message", "수정페이지로 이동 실패!");				
					view.forward(request, response);
				}
			}else{ //관리자가 아닐때
				view = request.getRequestDispatcher("views/userReview/userReviewError.jsp");
				request.setAttribute("message", "로그인이 필요합니다.");
				view.forward(request, response);
			}

		} catch (UserBoardException e) {
			view = request.getRequestDispatcher(
					"views/userReview/userReviewError.jsp");
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
