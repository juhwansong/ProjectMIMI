package support.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import support.model.service.SupportService;
import support.model.vo.Support;

/**
 * Servlet implementation class SupportSearchServlet
 */
@WebServlet("/supportsearch")
public class SupportSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SupportSearchServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8");
		// 공지사항 게시물 리스트
		request.setCharacterEncoding("utf-8");
		int currentPage = 1;
		int limit = 10;
		String column = request.getParameter("col");
		String keyword = request.getParameter("keword").trim();
		
			
		if(request.getParameter("page") != null){
			currentPage = Integer.parseInt(request.getParameter("page"));

		}
		
		SupportService sservice = new SupportService();
		
		RequestDispatcher view = null;
		try {
			int listCount = sservice.getSearchListCount(column, keyword);
			ArrayList<Support> slist = sservice.searchSupport(currentPage, limit, column, keyword);
			
			int maxPage = (int)((double)listCount / limit + 0.9);
			int startPage = (((int)((double)currentPage / limit + 0.9)) - 1) * limit + 1;
			int endPage = startPage + limit - 1;
			
			if(maxPage < endPage)
				endPage = maxPage;
		
			if(slist.size() > 0){
				view = request.getRequestDispatcher("views/member/customer1.jsp");

				request.setAttribute("slist", slist);
				request.setAttribute("currentPage", currentPage);
				request.setAttribute("maxPage", maxPage);
				request.setAttribute("startPage", startPage);
				request.setAttribute("endPage", endPage);
				request.setAttribute("listCount", listCount);
				request.setAttribute("col", column);
				request.setAttribute("keword", keyword);
				
				view.forward(request, response);
			}else{
				view = request.getRequestDispatcher("views/member/customerError.jsp");
				request.setAttribute("message", "게시글이 없습니다");
				view.forward(request, response);
			}
			
		}catch (Exception e) {
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
