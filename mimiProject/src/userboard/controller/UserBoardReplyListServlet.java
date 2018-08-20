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
		
		UserBoardService ubservice = new UserBoardService();
		
		try {
			int listCount = ubservice.getListCount();
			
			ArrayList<Board> list = ubservice.selectUserBoardReplyList(currentPage, limit);
			
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
