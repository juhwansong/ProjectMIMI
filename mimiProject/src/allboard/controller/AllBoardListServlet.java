package allboard.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import allboard.exception.AllBoardException;
import allboard.model.service.AllBoardService;
import common.model.vo.Board;

/**
 * Servlet implementation class AllBoardListServlet
 */
@WebServlet("/allboardlist")
public class AllBoardListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AllBoardListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8");
		
		String category = request.getParameter("category");
		String searchText = request.getParameter("searchText");
		
		int currentPage = 1;
		int limit = 15;
		int pageLimit = 10;
		
		if(category == null || category.equals("ALL")) {
			category = "ALL";
		}
		if(request.getParameter("page") != null) {
			currentPage = Integer.parseInt(request.getParameter("page"));
		}
		
		
		AllBoardService service = new AllBoardService();
		RequestDispatcher view = null;
		try {
			int listCount = service.getListCount();
			ArrayList<Board> list = service.selectAllBoardList();
			
			int maxPage = (int)((double)listCount / limit + 0.9);
			int startPage = (((int)((double)currentPage / pageLimit + 0.9)) - 1) * pageLimit + 1;
			int endPage = startPage + pageLimit - 1;
			int startRow = (currentPage - 1) * limit + 1;
			int endRow = startRow;
			if(maxPage < endPage) {
				endPage = maxPage;
			}
			if(currentPage == maxPage) {
				endRow = startRow + (listCount - ((maxPage - 1) * limit)) - 1;
			} else {
				endRow = startRow + limit - 1;
			}

			if(list.size() > 0) {
				ArrayList<Board> currentList = new ArrayList<Board>();
				for(int i = startRow; i <= endRow; i++) {
					currentList.add(list.get(i - 1));
				}
				
				view = request.getRequestDispatcher("views/admin/contentManage.jsp");
				request.setAttribute("list", currentList);
				request.setAttribute("currentPage", currentPage);
				request.setAttribute("maxPage", maxPage);
				request.setAttribute("startPage", startPage);
				request.setAttribute("endPage", endPage);
				request.setAttribute("listCount", listCount);
				request.setAttribute("category", category);
				request.setAttribute("searchText", searchText);
				view.forward(request, response);
			}
		} catch (AllBoardException e) {
			view = request.getRequestDispatcher("views/admin/adminPageError.jsp");
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
