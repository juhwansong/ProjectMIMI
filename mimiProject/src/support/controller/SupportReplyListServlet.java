package support.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import support.exception.SupportException;
import support.model.service.SupportService;
import support.model.vo.Support;
/**
 * Servlet implementation class SupportReplyListServlet
 */
@WebServlet("/supportreplylist")
public class SupportReplyListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SupportReplyListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8");
		RequestDispatcher view = null;
		String boardNo = request.getParameter("bno");
		JSONObject json = new JSONObject();
		JSONArray jarr = new JSONArray();
		ArrayList<Support> supportReplyList = null;
		try {
			supportReplyList = new SupportService().selectSupportReplyList(boardNo);
			if(supportReplyList.size() >= 1){
				
				for(Support s : supportReplyList){
					JSONObject job = new JSONObject();
					job.put("comment", URLEncoder.encode(s.getContents(), "UTF-8").replaceAll("\\+", "%20"));
					job.put("cwriter", s.getUserId());
					job.put("cdate", s.getCommentDate().toString());
					job.put("cno", s.getCommentNo());
					
					jarr.add(job);			
				}
				json.put("clist", jarr);
			}
			
		} catch (SupportException e) {
			view = request.getRequestDispatcher("/mimi/views/member/customerError.jsp");
			request.setAttribute("message", e.getMessage());
			view.forward(request, response);
		}
				
		response.setContentType("application/json charset=utf-8");
		PrintWriter out = response.getWriter();
		out.write(json.toJSONString());
		out.flush();
		out.close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
