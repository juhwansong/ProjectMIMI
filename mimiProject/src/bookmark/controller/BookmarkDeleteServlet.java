package bookmark.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bookmark.exception.BookmarkException;
import bookmark.model.service.BookmarkService;

/**
 * Servlet implementation class BookmarkDeleteServlet
 */
@WebServlet("/bookmarkdelete")
public class BookmarkDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BookmarkDeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("text/html; charset=utf-8");	
		String userId = "user01"; //임시..수정해야됨////////////////////////////////////////
		String[] checkedNo = request.getParameterValues("checkOne");
		
		
		RequestDispatcher view = null;
		try {
			int result = new BookmarkService().deleteBookmark(userId, checkedNo);
			
			if(result > 0){
				response.sendRedirect("/mimi/bookmarklist");

			}else{
				view = request.getRequestDispatcher("views/board/boardError.jsp");
				request.setAttribute("message", "즐겨찾기 게시물 삭제 실패...");
				view.forward(request, response);
			}
		} catch (BookmarkException e) {
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
