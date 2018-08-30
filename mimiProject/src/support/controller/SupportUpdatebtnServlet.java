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
 * Servlet implementation class SupportUpdatebtnServlet
 */
@WebServlet("/updatebtn")
public class SupportUpdatebtnServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SupportUpdatebtnServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		RequestDispatcher view = null;
		
		Support support = new Support();
		support.setBoardNo(request.getParameter("bno"));
		support.setTitle(request.getParameter("title"));
		support.setContents(request.getParameter("contents"));
		support.setCategory(Integer.parseInt(request.getParameter("ctype")));
		support.setUserId((String)request.getSession().getAttribute("userId"));
		
		
		try {
			if (new SupportService().updateSupport(support) > 0) {
				response.sendRedirect("/mimi/supportlist");
			} else {
				view = request.getRequestDispatcher("views/member/customerError.jsp");
				request.setAttribute("message", "게시글수정 실패");
				view.forward(request, response);
			}
		} catch (SupportException e) {
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
