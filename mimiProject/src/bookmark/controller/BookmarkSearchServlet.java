package bookmark.controller;

import java.io.IOException;
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
 * Servlet implementation class BookmarkSearchServlet
 */
@WebServlet("/bookmarksearch")
public class BookmarkSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BookmarkSearchServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//LinkedHashMap<String, String> map = new LinkedHashMap<>();
		
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession(false);
		String userId = (String)session.getAttribute("userId");
		String category = request.getParameter("selectReview"); //board_gb
		String keyword = request.getParameter("textSearch"); //title + contents + shop_name + shop_address
		String gb = null;
		if(keyword == null)
			keyword = ""; //전부
		
		if(category.equals("allReview") || category == null){
			gb = "in ('AR', 'UR')";
			
		}else if(category.equals("mimiReview")){
			gb = "= 'AR'"; 
			
		}else{
			gb = "= 'UR'";
		}
		
		response.setContentType("text/html; charset=utf-8");		
		int currentPage = 1; //맨 첫화면은 1페이지
		int countList = 10;	//한 화면에 출력될 리스트 개수
		int countPage = 10; //한 화면에 출력될 페이지 개수
				
		if(request.getParameter("page") != null) {
			currentPage = Integer.parseInt(request.getParameter("page"));
		}
		
		RequestDispatcher view = null;
		try {
			ArrayList<Board> list = new BookmarkService().searchBookmark(userId, gb, keyword, currentPage, countList);
			
			int totalCount = new BookmarkService().getSearchListCount(userId, gb, keyword);
			int maxPage = totalCount / countList;
			if(totalCount % countList > 0)
				maxPage++;
			
			if(maxPage < currentPage)
				currentPage = maxPage;
			
			
			int startPage = ((currentPage - 1) / 10) * 10 + 1;
			int endPage = startPage + countPage - 1;
			
			if(endPage > maxPage)
				endPage = maxPage;

			if(userId != null){
				view = request.getRequestDispatcher("views/board/bookmarkList.jsp");
				request.setAttribute("list", list);
				request.setAttribute("currentPage", currentPage);
				request.setAttribute("maxPage", maxPage);
				request.setAttribute("startPage", startPage);
				request.setAttribute("endPage", endPage);
				request.setAttribute("totalCount", totalCount);
				view.forward(request, response);

			}else{
				//비회원 접근시 에러
				view = request.getRequestDispatcher("views/board/boardError.jsp");
				request.setAttribute("message", "잘못된 접근입니다.");
				view.forward(request, response);
			}
		} catch (BookmarkException e) {
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
