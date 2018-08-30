package support.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import notice.exception.NoticeException;
import notice.model.service.NoticeService;
import support.exception.SupportException;
import support.model.service.SupportService;
import support.model.vo.Support;

/**
 * Servlet implementation class SupportInsertServlet
 */
@WebServlet("/supportinsert")
public class SupportInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SupportInsertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher view = null;
			response.setContentType("text/html; charset=utf-8");
			request.setCharacterEncoding("utf-8");
			Support support = new Support();
			
			support.setBoardNo(request.getParameter("board_no"));			
			support.setUserId((String)request.getSession().getAttribute("userId"));
			support.setTitle(request.getParameter("title"));
			support.setContents(request.getParameter("contents"));
			support.setState(request.getParameter("state"));
			support.setCategory(Integer.parseInt(request.getParameter("ctype")));
			try {
				if(new SupportService().insertSupport(support) > 0){
					response.sendRedirect("/mimi/supportlist");
				}else{
					System.out.println("게시글작성 실패");
					
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
