package bookmark.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bookmark.exception.BookmarkException;
import bookmark.model.service.BookmarkService;

/**
 * Servlet implementation class BookmarkInsertServlet
 */
@WebServlet("/bookmarkinsert")
public class BookmarkInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BookmarkInsertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

//		response.setContentType("text/html; charset=utf-8");	
//		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession(false);
		String userId = (String)session.getAttribute("userId");
		String boardNo = request.getParameter("boardNo");
		
		//System.out.println("받은 값 확인중... : " + userId + ", " + "boardNo : " + boardNo);
		RequestDispatcher view = null;
		try {
			int result = new BookmarkService().insertBookmark(userId, boardNo);
			
			if(result > 0){ //즐겨찾기 추가 성공
				//response.sendRedirect("/mimi/bookmarklist");

			}else{
				view = request.getRequestDispatcher("views/board/boardError.jsp");
				request.setAttribute("message", "즐겨찾기 실패...ㄴ");
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
