package member.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.model.vo.Member;
import member.exception.MemberException;
import member.model.service.MemberService;

/**
 * Servlet implementation class MemberSelectServlet
 */
@WebServlet("/memberselect")
public class MemberSelectServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberSelectServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html; charset=utf-8");
		String userId = (String)request.getSession().getAttribute("userId");
		Member member = null;
		RequestDispatcher view = null;
		
		try{
			
			member = new MemberService().selectMember(userId);
			System.out.println("member : " + member);
			if(member != null){
				view = request.getRequestDispatcher("views/member/memberCorrectView.jsp");
				request.setAttribute("member", member);
				view.forward(request, response);
			}
			
		} catch(MemberException e){
			//현재 접속중인 회원이 본인 정보를 가져 올수 없을때
			System.out.println(e.getMessage());
			
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
