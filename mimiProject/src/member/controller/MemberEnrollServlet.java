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
 * Servlet implementation class MemberEnrollServlet
 */
@WebServlet("/memberenroll")
public class MemberEnrollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberEnrollServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		int result = 0;
		String message = null;
		
		String userId = request.getParameter("userid");
		String userPwd = request.getParameter("userpassword");
		String userName = request.getParameter("username");
		String nickName = request.getParameter("nickname");
		String birth = request.getParameter("birthyear")+request.getParameter("birthmonth")+request.getParameter("birthday");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		
		Member member = new Member();
		member.setUserId(userId);
		member.setUserPwd(userPwd);
		member.setUserName(userName);
		member.setNickName(nickName);
		member.setBirth(birth);
		member.setEmail(email);
		member.setPhone(phone);
		
		try{
			
			result =new MemberService().insertMember(member);
			
			if( result > 0){
				HttpSession session = request.getSession();
				session.setAttribute("userId", userId);
				session.setAttribute("authority", "U");
				
				message = String.valueOf(result);
			}
			else{
				message = "회원가입에 실패했습니다.";
			}
		}catch(MemberException e){
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
