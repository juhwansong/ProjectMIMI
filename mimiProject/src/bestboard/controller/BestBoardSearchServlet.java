package bestboard.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bestboard.exception.BestBoardException;
import bestboard.model.service.BestBoardService;
import common.model.vo.Board;

/**
 * Servlet implementation class BestBoardSearchServlet
 */
@WebServlet("/bestboardsearch")
public class BestBoardSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BestBoardSearchServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String keyword = request.getParameter("search-text");
		keyword = (keyword == null) ? "" : keyword.replaceAll("(^\\p{Z}+|\\p{Z}+$)", "");		
		//System.out.println("keyword 확인 : " + keyword);
		
		
		response.setContentType("text/html; charset=utf-8");
		int currentPage = 1; //맨 첫화면은 1페이지
		int countList = 10;	//한 화면에 출력될 리스트 개수
		int countPage = 10; //한 화면에 출력될 페이지 개수
		
		if(request.getParameter("page") != null) {
			currentPage = Integer.parseInt(request.getParameter("page"));
		}
		
		RequestDispatcher view = null;
		try {
			
			ArrayList<Board> boardList = new BestBoardService().searchBestBoard(keyword, currentPage, countList);
						
			int totalCount = new BestBoardService().getSearchListCount(keyword);
			int maxPage = totalCount / countList;
			if(totalCount % countList > 0)
				maxPage++;
			
			if(maxPage < currentPage)
				currentPage = maxPage;		
			
			int startPage = ((currentPage - 1) / 10) * 10 + 1;
			int endPage = startPage + countPage - 1;
			
			if(endPage > maxPage)
				endPage = maxPage;			

//			if(boardList.size() > 0){
				view = request.getRequestDispatcher("views/bestReview/bestReviewList.jsp");
				request.setAttribute("boardList", boardList);
				request.setAttribute("currentPage", currentPage);
				request.setAttribute("maxPage", maxPage);
				request.setAttribute("startPage", startPage);
				request.setAttribute("endPage", endPage);
				request.setAttribute("totalCount", totalCount);
				view.forward(request, response);
//			}else{
//				view = request.getRequestDispatcher("views/board/boardError.jsp");
//				request.setAttribute("message", "게시글이 없습니다...!");
//				view.forward(request, response);
//		}
			
		} catch (BestBoardException e) {
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
