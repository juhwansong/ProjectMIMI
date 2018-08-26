package myboard.controller;

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

/**
 * Servlet implementation class MyBoardDeleteServlet
 */
@WebServlet("/myboarddelete")
public class MyBoardDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MyBoardDeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String boardNoStr = (String)request.getParameter("boardNoStr");
		
		String[] boardNoArr = boardNoStr.split(" ");
		ArrayList<String> boardNoList = new ArrayList<String>();
		for(String boardNo : boardNoArr)
			boardNoList.add(boardNo);
		
		AllBoardService service = new AllBoardService();
		RequestDispatcher view = null;
		try {
			int result = service.deleteAllBoard(boardNoList);
			
			if(result <= 0) {
				view = request.getRequestDispatcher("views/admin/adminPageError.jsp");
				request.setAttribute("message", "삭제할 목록이 없습니다.");
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
