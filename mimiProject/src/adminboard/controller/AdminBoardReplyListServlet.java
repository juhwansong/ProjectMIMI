package adminboard.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import adminboard.exception.AdminBoardException;
import adminboard.model.service.AdminBoardService;
import common.model.vo.Board;

/**
 * Servlet implementation class AdminBoardReplyListServlet
 */
@WebServlet("/adminboardreplylist")
public class AdminBoardReplyListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminBoardReplyListServlet() {
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
		AdminBoardService bservice = new AdminBoardService();
		
		try {
			//댓글 전체 목록 갯수 조회함
			int listCount = bservice.getListReplyCount(boardNo);
			
			ArrayList<Board> list = bservice.selectAdminBoardReplyList(boardNo, currentPage, limit);


			int maxPage = (int)((double)listCount / limit + 0.9);


			int startPage = (((int)((double)currentPage / limit + 0.9)) - 1) * limit + 1;

			int endPage = startPage + limit - 1;
			if(maxPage < endPage)
				endPage = maxPage;
			
			//페이지가 0일떄 1로 교체
			if(maxPage <= 0)
				maxPage = 1;
			
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
		} catch (AdminBoardException e) {
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
