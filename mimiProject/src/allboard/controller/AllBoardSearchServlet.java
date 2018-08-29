package allboard.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map.Entry;

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
 * Servlet implementation class AllBoardSearchServlet
 */
@WebServlet("/allboardsearch")
public class AllBoardSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AllBoardSearchServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8");
		
		String category = request.getParameter("category");
		String searchText = request.getParameter("search-text");
		
		if(searchText == null)
			searchText = request.getParameter("searchText");
			
		HashMap<String, String> searchMap = new HashMap<String, String>();
			searchMap.put(category, searchText);
		
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
		int searchListCount = 0;
		ArrayList<Board> list = null;
		try {
			if(!category.equals("ALL")) {
				searchListCount = service.getSearchListCount(searchMap);
				list = service.searchAllBoard(searchMap);
			} else {
				searchListCount = service.getListCount();
				list = service.selectAllBoardList();
			}
			
			int maxPage = (int)((double)searchListCount / limit + 0.9);
			int startPage = (((int)((double)currentPage / pageLimit + 0.9)) - 1) * pageLimit + 1;
			int endPage = startPage + pageLimit - 1;
			int startRow = (currentPage - 1) * limit + 1;
			int endRow = startRow;
			if(maxPage < endPage) {
				endPage = maxPage;
			}
			if(endPage == 0)
				endPage = 1;
			
			if(currentPage == maxPage) {
				endRow = startRow + (searchListCount - ((maxPage - 1) * limit)) - 1;
			} else if(searchListCount < limit) {
				endRow = searchListCount;
			} else {
				endRow = startRow + limit - 1;
			}

			ArrayList<Board> currentList = new ArrayList<Board>();
			if(list.size() > 0) {
				for(int i = startRow; i <= endRow; i++)
					currentList.add(list.get(i - 1));
			}
			
			view = request.getRequestDispatcher("views/admin/contentManage.jsp");
			request.setAttribute("list", currentList);
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("maxPage", maxPage);
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);
			request.setAttribute("listCount", searchListCount);
			request.setAttribute("category", category);
			request.setAttribute("searchText", searchText);
			view.forward(request, response);
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
