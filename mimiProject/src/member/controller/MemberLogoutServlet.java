package member.controller;

import java.io.File;
import java.io.IOException;

import java.util.ArrayList;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class MemberLogoutServlet
 */
@WebServlet("/memberlogout")
public class MemberLogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberLogoutServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);//생성된 섹션이 없으면 null을 리턴
		
		if(session != null){
			//로그인 상태라면
			session.removeAttribute("userId");
			session.removeAttribute("authority");
			session.removeAttribute("nickName");
			

			//파일 업로드 시 바로 로그아웃 할 경우
			if (session.getAttribute("imgList") != null) {
				ArrayList<String> removeImgList = (ArrayList<String>)session.getAttribute("imgList");
				for (String removeImg : removeImgList) {
					File removeFile = new File(removeImg);
					removeFile.delete();
				}
				// 임시폴더 안 이미지 경로들을 담고있는 세션 제거
				session.removeAttribute("imgList");
			}


			session.invalidate(); //섹션 삭제
				
		}
		
		response.sendRedirect("index.jsp");
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
