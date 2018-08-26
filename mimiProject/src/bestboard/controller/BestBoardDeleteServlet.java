package bestboard.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bestboard.model.service.BestBoardService;

/**
 * Servlet implementation class BestBoardDeleteServlet
 */
@WebServlet("/bestboarddelete")
public class BestBoardDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BestBoardDeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String[] boardNoList = request.getParameterValues("checkOne");	//베스트리뷰에서 넘어오는 배열 값
		
		for(String no : boardNoList){
			System.out.println("값 확인 : " + no);
		}
		RequestDispatcher view = null;
		try {
			int result = new BestBoardService().deleteBestBoard(boardNoList);
			
			if(result > 0){ //성공시 새로고침
				response.sendRedirect("/mimi/bestboardlist");

			}else{
				view = request.getRequestDispatcher("views/board/boardError.jsp");
				request.setAttribute("message", "숨기기 실패...");
				view.forward(request, response);
			}
		} catch (Exception e) {
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
