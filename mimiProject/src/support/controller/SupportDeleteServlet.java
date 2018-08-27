package support.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import support.exception.SupportException;
import support.model.service.SupportService;
import support.model.vo.Support;

/**
 * Servlet implementation class SupportDeleteServlet
 */
@WebServlet("/sdelete")
public class SupportDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SupportDeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//게시글 삭제
		
		String boardNo = request.getParameter("sno");
		response.setContentType("text/html; charset=utf-8");
		
		try{
			int result = new SupportService().deleteSupport(boardNo);
			
			if(result > 0){
				response.sendRedirect("/mimi/supportlist");
			}
			else{
				RequestDispatcher view= request.getRequestDispatcher("views/member/customerError.jsp");
				request.setAttribute("message", boardNo +"번 공지 삭제 실패");
				view.forward(request, response);
			}	
			
		}catch (SupportException e) {
			RequestDispatcher view= request.getRequestDispatcher("views/member/customerError.jsp");
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
