package member.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.model.service.MemberService;

/**
 * Servlet implementation class MemberInfoCheckServlet
 */
@WebServlet("/memberinfocheck")
public class MemberInfoCheckServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberInfoCheckServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//회원가입시 회원정보 중복 체크 확인 처리용 컨트롤러
		request.setCharacterEncoding("utf-8");
		
		String userId = request.getParameter("userid");
		String nickname = request.getParameter("nickname");
		String email = request.getParameter("email");
		String result = null;
		
		if(userId != null){
			result = new MemberService().selectCheckInfo("user_id", userId);		
		}
	
		if(nickname != null){
			result = new MemberService().selectCheckInfo("nickname", nickname);
		}
		if(email != null){
			result = new MemberService().selectCheckInfo("email", email);
		}
		
		if(result == null){
			result = "";
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
