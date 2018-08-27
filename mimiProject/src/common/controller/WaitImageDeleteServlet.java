package common.controller;

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
 * Servlet implementation class WaitImageDeleteServlet
 */
@WebServlet("/waitimagedelete")
public class WaitImageDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public WaitImageDeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//세션에 저장된 임시폴더의 이미지 파일들 삭제
				HttpSession imgSession = request.getSession(false);
				if(imgSession != null){
					if (imgSession.getAttribute("imgList") != null) {
						ArrayList<String> removeImgList = (ArrayList<String>)imgSession.getAttribute("imgList");
						for (String removeImg : removeImgList) {
							File removeFile = new File(removeImg);
							removeFile.delete();
						}
						// 임시폴더 안 이미지 경로들을 담고있는 세션 제거
						imgSession.removeAttribute("imgList");
					}
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
