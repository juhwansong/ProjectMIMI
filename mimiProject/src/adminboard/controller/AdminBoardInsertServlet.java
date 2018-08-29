package adminboard.controller;

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

import adminboard.exception.AdminBoardException;
import adminboard.model.service.AdminBoardService;
import common.model.vo.Board;

/**
 * Servlet implementation class AdminBoardInsertServlet
 */
@WebServlet("/adminboardinsert")
public class AdminBoardInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminBoardInsertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
							
		HttpSession session = request.getSession();	
		RequestDispatcher view = null;
		
		// 전송온 값 꺼내서 변수/객체에 저장하기
		Board board = new Board();
		board.setCategoryNo(request.getParameter("categoryNo"));	//카테고리 연결필요
		
		board.setUserId((String)session.getAttribute("userId"));
		board.setTitle(request.getParameter("title"));
		board.setContents(request.getParameter("content"));
		board.setContentsTag(request.getParameter("content_tag").replaceAll("resources/waitimage", "resources/files/adminboard"));//임시폴더경로를 새폴더경로로 바꿔서 저장
		board.setShopName(request.getParameter("shopName"));
		board.setShopAddress(request.getParameter("shopAddress"));
		board.setShopCall(request.getParameter("shopCall"));
		board.setLatitude(Double.parseDouble(request.getParameter("latitude")));
		board.setLongitude(Double.parseDouble(request.getParameter("longitude")));
		
		////html코드에서 img태그부분만 추출하는 부분
		String content = request.getParameter("content_tag");
		
		ArrayList<String> imgList = new ArrayList<>();
		int count = 0;
		if(content.contains("<img src=")){ //그림첨부를 했을때만
				
			while(count <= content.lastIndexOf("<img src=\"")+37){ //html포함 컨텐츠에서 img 경로만 빼는 작업
				int firstIndex = content.indexOf("<img src=\"", count)+37; //폴더경로에 따라 달라질수있음
				int lastIndex = content.indexOf("\"", content.indexOf("<img src=\"", count)+37);
				imgList.add(content.substring(firstIndex, lastIndex));
	
				if(count == 0){
					board.setThumbnailName(content.substring(firstIndex, lastIndex));
				}
				
				count = content.indexOf("\"", content.indexOf("<img src=\"", count)+10) + 1;	
			}
		}
		
		ArrayList<String> uploadImgList = (ArrayList<String>)request.getSession().getAttribute("imgList");
		//System.out.println("섹션 리스트 : " + uploadImgList);
		//세션에 저장된 upload된 이미지와 실질적으로 게시글에 올라간 이미지와 비교해서
		//일치하는 파일은 임시폴더에서 저장 폴더로 옮긴다
		if(uploadImgList != null){
			for (String uploadImg : uploadImgList) {
				for (String img : imgList) {
					if (uploadImg.contains(img)) {
						String newSavePath = request.getSession().getServletContext().getRealPath("resources/files/adminboard");   //옮기는 저장폴더 경로
				        File targetDir = new File(newSavePath);  
				        
				        if(!targetDir.exists()) {    //디렉토리 없으면 생성.
				        	targetDir.mkdirs();
				        }
						File oldFile = new File(uploadImg);
						File newFile = new File(newSavePath + "/" + img);
					
						oldFile.renameTo(newFile);
						break;
					}
				}
			}
		}
	
		try {
			if (new AdminBoardService().insertAdminBoard(board) > 0) {
				//response.sendRedirect("/mimi/userboarddetailview?bnum="+bnum+"&page="+1);
				if((String)session.getAttribute("userId") != null){
					response.sendRedirect("/mimi/adminboardlist?page=1");
				} else{
						//로그인 안하고 접근
						view = request.getRequestDispatcher("views/board/boardError.jsp");
						request.setAttribute("message", "잘못된 접근입니다.");
						view.forward(request, response);
					}
			} else {
				view = request.getRequestDispatcher("views/board/boardError.jsp");
				request.setAttribute("message", "게시글 등록 실패");
				view.forward(request, response);
			}
		} catch (AdminBoardException e) {
			view = request.getRequestDispatcher("views/board/boardError.jsp");
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
