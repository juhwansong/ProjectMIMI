package recommend.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import member.model.service.MemberService;
import recommend.exception.RecommendException;
import recommend.model.service.RecommendService;

/**
 * Servlet implementation class RecommendInsertServlet
 */
@WebServlet("/recommendcheck")
public class RecommendCheckServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RecommendCheckServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8");
		HttpSession session = request.getSession();		
		
		String userId = (String)session.getAttribute("userId");
		String boardNo = request.getParameter("bnum");
		int result = 0;
		int recommendCount = 0;
		try {
			result = new RecommendService().checkRecommend(userId, boardNo);
			recommendCount = new RecommendService().countRecommend(boardNo);
			//System.out.println("recommendCount 서블릿: "+ recommendCount);
			JSONObject json = new JSONObject();
			json.put("result", result);
			json.put("recommendCount", recommendCount);
			//json.put("result", "1212");
			
			//response.setContentType("text/html; charset=utf-8");
			response.setContentType("application/json; charset=utf-8");
			PrintWriter out = response.getWriter();
			//out.print(result);
			out.write(json.toJSONString());
			out.flush();
			out.close();
		} catch (RecommendException e) {
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
