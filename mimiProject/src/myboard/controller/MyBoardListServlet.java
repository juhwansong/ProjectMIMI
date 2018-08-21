package myboard.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.model.vo.Board;
import myboard.exception.MyBoardException;
import myboard.model.service.MyBoardService;

/**
 * Servlet implementation class MyBoardListServlet
 */
@WebServlet("/myboardlist")
public class MyBoardListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MyBoardListServlet() {
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
		String nickname = request.getParameter("nickname");
		String user = request.getParameter("user");
		
		if(searchText == null) 
			searchText = request.getParameter("searchText");
		
		HashMap<String, String> searchMap = new HashMap<String, String>();
		searchMap.put(nickname, user);
		
		int currentPage = 1;
		int limit = 15;
		int pageLimit = 10;
		
		if(category == null || category.equals("ALL")) {
			category = "ALL";
		}
		
		if(request.getParameter("page") != null) {
			currentPage = Integer.parseInt(request.getParameter("page"));
		}
		
		MyBoardService service = new MyBoardService();
		RequestDispatcher view = null;
		try {
			int searchListCount = service.getSearchListCount(searchMap);
			ArrayList<Board> list = service.searchMyBoard(searchMap);
			
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
			
			view = request.getRequestDispatcher("views/board/myContent.jsp");
			request.setAttribute("list", currentList);
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("maxPage", maxPage);
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);
			request.setAttribute("listCount", searchListCount);
			request.setAttribute("category", category);
			request.setAttribute("searchText", searchText);
			request.setAttribute("nickname", nickname);
			request.setAttribute("user", user);
			view.forward(request, response);
		} catch (MyBoardException e) {
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
