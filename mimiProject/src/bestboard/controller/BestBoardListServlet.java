package bestboard.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bestboard.exception.BestBoardException;
import bestboard.model.service.BestBoardService;
import common.model.vo.Board;

/**
 * Servlet implementation class BestBoardListServlet
 */
@WebServlet("/bestboardlist")
public class BestBoardListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BestBoardListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8");
		RequestDispatcher view = null;
		try {
			
			ArrayList<Board> boardList = new BestBoardService().selectBestBoardList();

			
//			if(boardList.size() > 0){
				view = request.getRequestDispatcher("views/bestReview/bestReviewList.jsp");
				request.setAttribute("boardList", boardList);
				
				//검색 후 필요해서...
				request.setAttribute("currentPage", 1);
				request.setAttribute("maxPage", 1);
				request.setAttribute("startPage", 1);
				request.setAttribute("endPage", 1);
				request.setAttribute("totalCount", 1);
				view.forward(request, response);
//			}else{
//				view = request.getRequestDispatcher("views/board/boardError.jsp");
//				request.setAttribute("message", "게시글이 없습니다...!");
//				view.forward(request, response);
//		}
			
		} catch (BestBoardException e) {
			view = request.getRequestDispatcher("views/board/boardError.jsp");
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
