package userboard.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.model.vo.Board;
import userboard.exception.UserBoardException;
import userboard.model.service.UserBoardService;

/**
 * Servlet implementation class UserBoardDeleteServlet
 */
@WebServlet("/userboarddelete")
public class UserBoardDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserBoardDeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String boardNum = request.getParameter("bnum");
		String buserId = request.getParameter("buserId");
		
		HttpSession session = request.getSession();	
		String authority = (String)session.getAttribute("authority");
		String userId = (String)session.getAttribute("userId");	
		
		RequestDispatcher view = null;
		try {
			if((authority != null && authority.equals("A")) || (userId != null && userId.equals(buserId))){
				UserBoardService bservice = new UserBoardService();
				Board board = bservice.selectUserBoard(boardNum);
				
				if(bservice.deleteUserBoard(boardNum) > 0){
					//삭제 성공시, 첨부파일이 있을 경우
					String oldContent = request.getParameter("content_tag");				
					//html코드에서 img태그부분만 추출하는 부분		
					ArrayList<String> oldImgList = new ArrayList<>();
					int oldCount = 0;
					if(oldContent.contains("<img src=")){ //그림첨부를 했을때만
						while(oldCount <= oldContent.lastIndexOf("<img src=\"")+42){ //html포함 컨텐츠에서 img 경로만 빼는 작업
							int firstIndex = oldContent.indexOf("<img src=\"", oldCount)+42; //폴더경로에 따라 달라질수있음
							int lastIndex = oldContent.indexOf("\"", oldContent.indexOf("<img src=\"", oldCount)+42);
							oldImgList.add(oldContent.substring(firstIndex, lastIndex));				
							oldCount = oldContent.indexOf("\"", oldContent.indexOf("<img src=\"", oldCount)+10) + 1;	
						}
						
						String newSavePath = request.getSession().getServletContext().getRealPath("resources/files/userboard");
						
						for(String oldImg : oldImgList){ 
							File oldContentFile = new File(newSavePath + "/" + oldImg);
							oldContentFile.delete();
						}
						
					}
					//bupfiles 폴더에 해당 파일 삭제 처리함
					/*
					if(board.getBoardOriginalFileName() != null){
						String savePath = request.getSession()
							.getServletContext().getRealPath(
									"/bupfiles");
						File removeFile = new File(savePath + 
							"\\" + board.getBoardRenameFileName());
						removeFile.delete();
					}
					*/				
					response.sendRedirect("/mimi/userboardlist");
				}else{
					view = request.getRequestDispatcher(
							"views/userReview/userReviewError.jsp");
					request.setAttribute("message", 
							boardNum + "번글 삭제 실패!");
					view.forward(request, response);
				}
			}else{ //관리자가 아닐때
				view = request.getRequestDispatcher("views/userReview/userReviewError.jsp");
				request.setAttribute("message", "로그인이 필요합니다.");
				view.forward(request, response);
			}
		} catch (UserBoardException e) {
			view = request.getRequestDispatcher(
					"views/userReview/userReviewError.jsp");
			request.setAttribute("message", e.getMessage());
			view.forward(request, response);
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
