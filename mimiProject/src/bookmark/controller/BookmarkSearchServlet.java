package bookmark.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

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
		
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession(false);
		String userId = (String)session.getAttribute("userId");
		
		String category = request.getParameter("category"); //board_gb
		String keyword = request.getParameter("keyword"); //title + contents + shop_name + shop_address

		//System.out.println(category + ", " + keyword);	//확인용
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
/*				view = request.getRequestDispatcher("views/board/bookmarkList.jsp");
				request.setAttribute("list", list);
				request.setAttribute("currentPage", currentPage);
				request.setAttribute("maxPage", maxPage);
				request.setAttribute("startPage", startPage);
				request.setAttribute("endPage", endPage);
				request.setAttribute("totalCount", totalCount);
				view.forward(request, response);*/
				
				
				JSONObject json = new JSONObject();
				JSONArray jarr = new JSONArray();
				
				SimpleDateFormat sdf = new SimpleDateFormat("MM.dd");
				
				for(Board board : list){
					JSONObject job = new JSONObject();
					String date = sdf.format(board.getBoardDate());
					
					job.put("boardNo", board.getBoardNo());
					job.put("commentNum", board.getCommentNum());
					job.put("recommend", board.getRecommed());
					job.put("thumbnail", board.getThumbnailName());
					job.put("title", board.getTitle());
					job.put("boardDate", date);
					job.put("boardGb", board.getBoardGb());
					job.put("nickname", board.getNickName());
					
					jarr.add(job);
				}
				
				json.put("list", jarr); //board 내용들
								
				//페이지 처리용
				json.put("currentPage", currentPage);
				json.put("maxPage", maxPage);
				json.put("startPage", startPage);
				json.put("endPage", endPage);
				json.put("totalCount", totalCount);
				
					
				//System.out.println("adminsearch에서 보낸 값 : \n" + json.toJSONString()); //확인용
					
				PrintWriter out = response.getWriter();
				out.print(json.toJSONString());
				out.flush();
				out.close();

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
