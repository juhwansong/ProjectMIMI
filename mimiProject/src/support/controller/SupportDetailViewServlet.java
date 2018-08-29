package support.controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import notice.exception.NoticeException;
import notice.model.service.NoticeService;
import notice.model.vo.Notice;
import support.exception.SupportException;
import support.model.service.SupportService;
import support.model.vo.Support;

/**
 * Servlet implementation class SupportDetailViewServlet
 */
@WebServlet("/supportdetailview")
public class SupportDetailViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SupportDetailViewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
    	response.setContentType("text/html; charset=utf-8");
    
    	String boardNo = request.getParameter("sno");
				
		RequestDispatcher view = null;
		
		try {
			SupportService sservice = new SupportService();
			Support support = sservice.selectSupport(boardNo);
			
			if(support != null){
				view = request.getRequestDispatcher("views/member/customerView.jsp");
				request.setAttribute("support", support);
				view.forward(request, response);
			}else{
				view = request.getRequestDispatcher("views/member/customerError.jsp");
				request.setAttribute("message", boardNo + "번 글이 존재하지 않습니다");
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
