package member.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.model.vo.Member;
import member.exception.MemberException;
import member.model.service.MemberService;

/**
 * Servlet implementation class MemberLoginServlet
 */
@WebServlet("/memberlogin")
public class MemberLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberLoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userId = request.getParameter("userid");
		String userPassword = request.getParameter("userpassword");
		String message = null;
		Member member = null;
		
		try{
			//결과값으로 해당 유저의 권한을 갖고 옴.
			member = new MemberService().loginCheck(userId, userPassword);
			if(member != null){
				HttpSession session = request.getSession();
				//자동 로그 아웃 시간 설정할거면 여기서도 가능
				session.setAttribute("userId", userId);
				session.setAttribute("authority", member.getAuthority());
				session.setAttribute("nickName", member.getNickName());
				
				message = "success";
			}
			else{
				//로그인 실패시 
				message = "아이디와 암호가 일치하지 않습니다.!";
			}
			
		} catch(MemberException e){
			//로그인 실패시
			message = e.getMessage();
		}
		
		response.setContentType("text/html; charset=utf-8");
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
