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
		HttpSession session = request.getSession(false);
		String userId = (String)session.getAttribute("userId");
		
		String[] boardNo = request.getParameterValues("checkOne");	//즐겨찾기 페이지에서 삭제하고 넘어오는 배열 값
		String bno = request.getParameter("boardNo");	//리뷰 상세보기에서 넘어오는 값
		
		//System.out.println("값 확인 : " + bno);
		
		if(bno != null){
			boardNo = new String[1];
			boardNo[0] = bno;
		}
		
		//System.out.println("값 확인 : " + boardNo[0]);
		RequestDispatcher view = null;
		try {
			int result = new BookmarkService().deleteBookmark(userId, boardNo);
			
			if(result > 0){
				response.sendRedirect("/mimi/bookmarklist");

			}else{
				view = request.getRequestDispatcher("views/board/boardError.jsp");
				request.setAttribute("message", "즐겨찾기 삭제 실패...");
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
