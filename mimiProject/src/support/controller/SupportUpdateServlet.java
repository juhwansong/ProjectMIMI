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
 * Servlet implementation class SupportUpdateServlet
 */
@WebServlet("/supdate")
public class SupportUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SupportUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//게시글 수정
		response.setContentType("text/html; charset=utf-8");
		
		String boardNo = request.getParameter("sno");
		int currentPage = Integer.parseInt(request.getParameter("page"));

		RequestDispatcher view = null;
		
		try {
			Support support = new SupportService().selectSupport(boardNo);
			if(support != null){
				view = request.getRequestDispatcher(
						"views/member/cupdateView.jsp");
				request.setAttribute("support", support);
				request.setAttribute("page", currentPage);
				view.forward(request, response);
			}else{
				view = request.getRequestDispatcher(
						"views/member/customerError.jsp");
				request.setAttribute("message", "수정페이지로 이동 실패!");				
				view.forward(request, response);
			}
		} catch (SupportException e) {
			view = request.getRequestDispatcher("views/member/customerError.jsp");
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
