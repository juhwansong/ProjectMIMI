package member.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.exception.MemberException;
import member.model.service.MemberService;

/**
 * Servlet implementation class MemberPasswordCheckServlet
 */
@WebServlet("/memberpasswordcheck")
public class MemberPasswordCheckServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberPasswordCheckServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html; charset=utf-8");
		
		String userId = (String)request.getSession().getAttribute("userId");
		String userPwd = request.getParameter("userpassword");
		String message = null;
		
		try{
			
			if(new MemberService().loginCheck(userId, userPwd) != null){
				message = "success";				
			}
			else{					
				message = "비밀번호가 일치하지 않습니다.";				
			}					
		} catch(MemberException e){
			message = "비밀번호가 일치하지 않습니다.";					
		}	
		PrintWriter out = response.getWriter();
		out.print(message);
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
