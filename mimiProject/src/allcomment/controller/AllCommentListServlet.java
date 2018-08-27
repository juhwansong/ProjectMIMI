package allcomment.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import allcomment.exception.AllCommentException;
import allcomment.model.service.AllCommentService;
import common.model.vo.Board;

/**
 * Servlet implementation class AllCommentListServlet
 */
@WebServlet("/allcommentlist")
public class AllCommentListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AllCommentListServlet() {
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
		
		
		AllCommentService service = new AllCommentService();
		RequestDispatcher view = null;
		try {
			int listCount = service.getListCount();
			ArrayList<Board> list = service.selectAllCommentList();
			
			int maxPage = (int)((double)listCount / limit + 0.9);
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
				endRow = startRow + (listCount - ((maxPage - 1) * limit)) - 1;
			} else if(listCount < limit) {
				endRow = listCount;
			} else {
				endRow = startRow + limit - 1;
			}
			
			ArrayList<Board> currentList = new ArrayList<Board>();
			for(int i = startRow; i <= endRow; i++) {
				currentList.add(list.get(i - 1));
			}
			
			view = request.getRequestDispatcher("views/admin/commentManage.jsp");
			request.setAttribute("list", currentList);
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("maxPage", maxPage);
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);
			request.setAttribute("listCount", listCount);
			request.setAttribute("category", category);
			request.setAttribute("searchText", searchText);
			view.forward(request, response);
		} catch (AllCommentException e) {
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
