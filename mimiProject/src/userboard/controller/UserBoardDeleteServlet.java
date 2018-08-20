package userboard.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		response.setContentType("text/html; charset=utf-8");
		
		String boardNum = request.getParameter("bnum");
		
		RequestDispatcher view = null;
		try {
			UserBoardService bservice = new UserBoardService();
			Board board = bservice.selectUserBoard(boardNum);

			if(bservice.deleteUserBoard(boardNum) > 0){
				//삭제 성공시, 첨부파일이 있을 경우
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
