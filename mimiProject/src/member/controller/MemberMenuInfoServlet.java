package member.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import common.model.vo.Member;
import member.exception.MemberException;
import member.model.service.MemberService;

/**
 * Servlet implementation class MemberMenuInfoServlet
 */
@WebServlet("/membermenuinfo")
public class MemberMenuInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberMenuInfoServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		JSONObject json = new JSONObject();	
		String userId = (String)request.getSession().getAttribute("userId");
		Member member = null;
		try{
			member = new MemberService().selectMember(userId);
			
		}catch(MemberException e){
			e.printStackTrace();
			System.out.println("유저 정보를 찾아올수 없습니다.");
		}
			
		json.put("gradeName", URLEncoder.encode(member.getGradeName(), "utf-8"));
		json.put("nickName", URLEncoder.encode(member.getNickName(), "utf-8"));
			
	
		response.setContentType("application/json; charset=utf-8");
		
		PrintWriter out = response.getWriter();
		out.print(json.toJSONString());
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
