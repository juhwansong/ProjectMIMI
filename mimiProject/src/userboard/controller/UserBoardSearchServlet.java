package userboard.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.model.vo.Board;
import userboard.exception.UserBoardException;
import userboard.model.service.UserBoardService;

/**
 * Servlet implementation class UserBoardSearchServlet
 */
@WebServlet("/userboardsearch")
public class UserBoardSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserBoardSearchServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		
		String categoryby = request.getParameter("category");	
		String category = (categoryby != null) ? categoryby : "C0";
		
		String keyword = request.getParameter("search-text");
		String sortby = request.getParameter("sort");
		String order = request.getParameter("order");
		//System.out.println("sortby : " + sortby + "\norder : " + order);
		String sort = (sortby != null && sortby.contains("up")) ? " ASC " : " DESC ";
//		System.out.println("sort 변환 확인 : " + sort);
//		System.out.println("검색한 category 값 : " + category);
//		System.out.println("검색한 keyword값 : " + keyword);

		
		keyword = (keyword == null) ? "" : keyword.replaceAll("(^\\p{Z}+|\\p{Z}+$)", ""); //null이면 전체검색, 아니면 공백 제거
		
		if(order == null)
			order = "BOARD_NO"; //기본 글번호 정렬

		
		String query = null;
		if(category.equals("C0")){//카테고리 미선택 OR 전체선택
			query = " WHERE ( TITLE LIKE '%" + keyword + "%' OR CONTENTS LIKE '%"
					+ keyword + "%' ) ORDER BY " + order + sort;
		}else{
			query = " WHERE CATEGORY_NO = '" + category + "' AND ( TITLE LIKE '%"
					+ keyword + "%' OR CONTENTS LIKE '%" + keyword + "%' ) ORDER BY " + order + sort;
		}
		
		//System.out.println("서블릿 쿼리확인 :" + query );
		response.setContentType("text/html; charset=utf-8");
		
		int currentPage = 1; //맨 첫화면은 1페이지
		int countList = 9;	//한 화면에 출력될 리스트 개수
		int countPage = 10; //한 화면에 출력될 페이지 개수
		
		if(request.getParameter("page") != null) {
			currentPage = Integer.parseInt(request.getParameter("page"));
		}
		
		RequestDispatcher view = null;
		try {
			
			ArrayList<Board> boardList = new UserBoardService().searchUserBoard(query, currentPage, countList);
			
			int totalCount = new UserBoardService().getSearchListCount(query);
			int maxPage = totalCount / countList;
			if(totalCount % countList > 0)
				maxPage++;
			
			if(maxPage < currentPage)
				currentPage = maxPage;
			
			
			int startPage = ((currentPage - 1) / 10) * 10 + 1;
			int endPage = startPage + countPage - 1;
			
			if(endPage > maxPage)
				endPage = maxPage;
			
			//System.out.println("검색한 전체 개수 : " + totalCount);
			//System.out.println("start page : " + startPage + "\nendPage : " + endPage + "\ncurrentPage : " + currentPage);
				
				
			System.out.println(boardList.size());
//			if(boardList.size() > 0){
				view = request.getRequestDispatcher("views/userReview/userReviewList.jsp");
				request.setAttribute("list", boardList);
				request.setAttribute("currentPage", currentPage);
				request.setAttribute("maxPage", maxPage);
				request.setAttribute("startPage", startPage);
				request.setAttribute("endPage", endPage);
				request.setAttribute("listCount", totalCount);
				view.forward(request, response);
//			}else{
//				view = request.getRequestDispatcher("views/board/boardError.jsp");
//				request.setAttribute("message", "게시글이 없습니다...!");
//				view.forward(request, response);
//			}
			
		} catch (UserBoardException e) {
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
