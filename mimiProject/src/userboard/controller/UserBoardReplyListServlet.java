package userboard.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.sql.Date;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import common.model.vo.Board;
import userboard.exception.UserBoardException;
import userboard.model.service.UserBoardService;

/**
 * Servlet implementation class UserBoardReplyListServlet
 */
@WebServlet("/userboardreplylist")
public class UserBoardReplyListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserBoardReplyListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8");
		
		//페이지 값 처리용 변수
		int currentPage = 1;
		//한 페이지당 출력할 목록 갯수
		int limit = 10;
		String boardNo = request.getParameter("bnum");
		if(request.getParameter("page") != null){
			currentPage = Integer.parseInt(request.getParameter("page"));
		}
		UserBoardService ubservice = new UserBoardService();
		
		try {
			//댓글 전체 목록 갯수 조회함
			int listCount = ubservice.getListReplyCount(boardNo);
			
			ArrayList<Board> list = ubservice.selectUserBoardReplyList(boardNo, currentPage, limit);
			//총 페이지수 계산 
			//목록이 최소 1개일 때 1 페이지로 처리하기
			//위해서 0.9를 더하기 함
			int maxPage = (int)((double)listCount / limit + 0.9);
			//현재 페이지에 보여줄 시작 페이지 수
			//1, 11, 21, ....
			//현재 페이지가 13페이지면 시작 페이지는 11페이지가 됨.
			int startPage = (((int)((double)currentPage / limit 
					+ 0.9)) - 1) * limit + 1;
			//만약, 목록 아래에 보여질 페이지 갯수가 10개이면
			//끝페이지수는 20페이지가 되어야 함
			int endPage = startPage + limit - 1;
			if(maxPage < endPage)
				endPage = maxPage;
			
			//페이지가 0일떄 1로 교체
			if(maxPage<=0)
				maxPage=1;
			
			JSONObject json = new JSONObject();
			JSONArray jarr = new JSONArray();
			
			for(Board b : list){
				JSONObject job = new JSONObject();
				job.put("cmtNo", b.getCommentNo());
				job.put("cmtUserId", b.getCommentUserId());
				job.put("cmtNickname", b.getCommentNickName());
				job.put("cmtGradename", b.getCommentGradeName());
				job.put("cmtDate", b.getCommentDate().toString());
				job.put("cmtContents", b.getCommentContents());	
				jarr.add(job);
			}
			
			json.put("list", jarr);
			json.put("currentPage", currentPage);
			json.put("maxPage", maxPage);
			json.put("startPage", startPage);
			json.put("endPage", endPage);
			json.put("listCount", listCount);

			response.setContentType(
					"application/json; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.write(json.toJSONString());
			out.flush();
			out.close();
		} catch (UserBoardException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
