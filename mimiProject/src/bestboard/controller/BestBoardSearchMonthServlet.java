package bestboard.controller;

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

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import bestboard.exception.BestBoardException;
import bestboard.model.service.BestBoardService;
import common.model.vo.Board;

/**
 * Servlet implementation class BestBoardSearchServlet
 */
@WebServlet("/bestboardsearchmonth")
public class BestBoardSearchMonthServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BestBoardSearchMonthServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String year = request.getParameter("year");
		String month = request.getParameter("month");
		String selectedMonth = year + "/" + month;
		
		System.out.println("선정월 : " + selectedMonth);
		
		response.setContentType("text/html; charset=utf-8");
				
		RequestDispatcher view = null;
		try {
			
			ArrayList<Board> boardList = new BestBoardService().searchMothBestBoard(selectedMonth);
						
			JSONObject json = new JSONObject();
			JSONArray jarr = new JSONArray();
			
			
			for(Board board : boardList){
				JSONObject job = new JSONObject();
				
				job.put("boardNo", board.getBoardNo());
				job.put("title", board.getTitle());
				job.put("contents", board.getContents());
				job.put("thumbnail", board.getThumbnailName());
				job.put("nickname", board.getNickName());
				job.put("commentNum", board.getCommentNum());
				job.put("recommend", board.getRecommed());
				job.put("hits", board.getHits());

				job.put("selectedMonth", board.getGradeName()); //안 쓰는 변수 대신 사용...
				job.put("rank", board.getLongitude()); //안쓰는 변수 대신 사용...
				
				jarr.add(job);
			}
			
			json.put("list", jarr); //board 내용들
							
					
			PrintWriter out = response.getWriter();
			out.print(json.toJSONString());
			out.flush();
			out.close();


			
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
