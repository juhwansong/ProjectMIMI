package adminboard.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import adminboard.exception.AdminBoardException;
import adminboard.model.service.AdminBoardService;
import common.model.vo.Board;

/**
 * Servlet implementation class AdminBoardListServlet
 */
@WebServlet("/adminboardlist")
public class AdminBoardListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminBoardListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8");
		int currentPage = 1; //맨 첫화면은 1페이지
		int countList = 9;	//한 화면에 출력될 리스트 개수
		int countPage = 10; //한 화면에 출력될 페이지 개수
		
		if(request.getParameter("page") != null) {
			currentPage = Integer.parseInt(request.getParameter("page"));
		}
		
		RequestDispatcher view = null;
		try {
			ArrayList<Board> boardList = new AdminBoardService().selectAdminBoardList(currentPage, countList);
			
			int totalCount = new AdminBoardService().getListCount();
			int maxPage = totalCount / countList;
			if(totalCount % countList > 0)
				maxPage++;
			
			if(maxPage < currentPage)
				currentPage = maxPage;
			
			
			int startPage = ((currentPage - 1) / 10) * 10 + 1;
			int endPage = startPage + countPage - 1;
			
			if(endPage > maxPage)
				endPage = maxPage;

			
//			if(boardList.size() > 0){
				view = request.getRequestDispatcher("views/board/adminReview.jsp");
				request.setAttribute("boardList", boardList);
				request.setAttribute("currentPage", currentPage);
				request.setAttribute("maxPage", maxPage);
				request.setAttribute("startPage", startPage);
				request.setAttribute("endPage", endPage);
				request.setAttribute("totalCount", totalCount);
				view.forward(request, response);
//			}else{
//				view = request.getRequestDispatcher("views/board/boardError.jsp");
//				request.setAttribute("message", "게시글이 없습니다...!");
//				view.forward(request, response);
//			}
		} catch (AdminBoardException e) {
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
