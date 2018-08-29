package support.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sun.rmi.server.Dispatcher;
import support.exception.SupportException;
import support.model.service.SupportService;

/**
 * Servlet implementation class SupportStateChangeServlet
 */
@WebServlet("/supportstatechange")
public class SupportStateChangeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SupportStateChangeServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String boardNo = request.getParameter("bnum");
		String state = request.getParameter("state");
		String result = "0";
		RequestDispatcher view = null;
		
		try {
			if(new SupportService().changeState(boardNo, state) > 0){
				result = "1";
			
			}else{
				System.out.println("수정 실패");
				
			}
			
		} catch (SupportException e) {
			view = request.getRequestDispatcher("views/member/customerError.jsp");
			request.setAttribute("message", e.getMessage());
			view.forward(request, response);
		}
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print(result);
		out.flush();
		out.close();
		
			
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
