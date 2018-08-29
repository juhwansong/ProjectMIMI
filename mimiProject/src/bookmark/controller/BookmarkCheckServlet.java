package bookmark.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bookmark.exception.BookmarkException;
import bookmark.model.service.BookmarkService;
import common.model.vo.Board;

/**
 * Servlet implementation class BookmarkListServlet
 */
@WebServlet("/bookmarkCheck")
public class BookmarkCheckServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BookmarkCheckServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
		response.setContentType("text/html; charset=utf-8");
		HttpSession session = request.getSession();		
		
		String userId = (String)session.getAttribute("userId");
		String boardNo = request.getParameter("bnum");
		int result = 0;
		try {
			result = new BookmarkService().checkBookmark(userId, boardNo);

			PrintWriter out = response.getWriter();
			out.print(result);
			out.flush();
			out.close();
		} catch (BookmarkException e) {
			e.printStackTrace();
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
