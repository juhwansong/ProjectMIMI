package support.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;

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
 * Servlet implementation class SupportReplyInsertServlet
 */
@WebServlet("/supportreplyinsert")
public class SupportReplyInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SupportReplyInsertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher view = null;
		String result = "0";
		response.setContentType("text/html; charset=utf-8");
		request.setCharacterEncoding("utf-8");
		Support support = new Support();
		
		support.setBoardNo(request.getParameter("board_no"));
		support.setUserId((String)request.getSession().getAttribute("userId"));
		support.setCommentContents(request.getParameter("comment_contents"));
		try {
			if(new SupportService().insertSupportReply(support) > 0){
				result = "1";
			
			}else{
				System.out.println("댓글작성 실패");
				
			}
			
		} catch (SupportException e) {
			view = request.getRequestDispatcher("views/member/customerError.jsp");
			request.setAttribute("message", e.getMessage());
			view.forward(request, response);
		}
						
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print(result);
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
