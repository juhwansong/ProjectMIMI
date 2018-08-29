package userboard.controller;

import java.io.IOException;

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
 * Servlet implementation class UserBoardDetailViewServlet
 */
@WebServlet("/userboarddetailview")
public class UserBoardDetailViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserBoardDetailViewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8");
		
		String boardNum = request.getParameter("bnum");
		int currentPage = 1; // page파라미터 값이 없을땐 디테일뷰에서 목록버튼눌렀을때 1페이지 목록으로 가도록 초기값 설정
		if(request.getParameter("page") != null){
			currentPage = Integer.parseInt(request.getParameter("page"));
		}
		
		UserBoardService ubservice = new UserBoardService();
		
		RequestDispatcher view = null;
		try {
			//상세보기시 조회수 1 증가 처리
			ubservice.addReadCount(boardNum);
			//해당 게시글 조회해 옴
			Board board = ubservice.selectUserBoard(boardNum);
			System.out.println(board.getContentsTag());
			if(board != null){
				
				view = request.getRequestDispatcher("views/userReview/userReviewView.jsp");
				request.setAttribute("board", board);
				request.setAttribute("currentPage", currentPage);
				view.forward(request, response);
			
			}else{
				view = request.getRequestDispatcher("views/userReview/userReviewError.jsp");
				request.setAttribute("message", boardNum + "번 글 조회실패!");
				view.forward(request, response);
			}
			
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
