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

import adminboard.exception.AdminBoardException;
import adminboard.model.service.AdminBoardService;
import common.model.vo.Board;

/**
 * Servlet implementation class AdminBoardUpdateServlet
 */
@WebServlet("/adminboardoriginupdate")
public class AdminBoardUpdateOriginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminBoardUpdateOriginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String newSavePath = request.getSession().getServletContext().getRealPath("resources/files/adminboard");   //옮기는 저장폴더 경로
		String boardNum = request.getParameter("bnum");
		int currentPage = Integer.parseInt(request.getParameter("page"));
		
		//int maxSize = 1024 * 1024 * 10;
		
		RequestDispatcher view = null;


		// 전송온 값 꺼내서 변수/객체에 저장하기
		Board board = new Board();
		board.setBoardNo(boardNum);	//카테고리 연결필요
		board.setCategoryNo(request.getParameter("categoryNo"));	//카테고리 연결필요
		
		board.setUserId((String)request.getSession().getAttribute("userId"));
		board.setTitle(request.getParameter("title"));
		board.setContents(request.getParameter("content"));
		board.setContentsTag(request.getParameter("content_tag").replaceAll("resources/waitimage", "resources/files/adminboard"));//임시폴더경로를 새폴더경로로 바꿔서 저장
		board.setShopName(request.getParameter("shopName"));
		board.setShopAddress(request.getParameter("shopAddress"));
		board.setShopCall(request.getParameter("shopCall"));
		board.setLatitude(Double.parseDouble(request.getParameter("latitude")));
		board.setLongitude(Double.parseDouble(request.getParameter("longitude")));
		
		
		//html코드에서 img태그부분만 추출하는 부분		
		String oldContent = request.getParameter("oldcontent_tag");
		ArrayList<String> oldImgList = new ArrayList<>();
		int oldCount = 0;
		if(oldContent.contains("<img src=")){ //그림첨부를 했을때만
			while(oldCount <= oldContent.lastIndexOf("<img src=\"")+43){ //html포함 컨텐츠에서 img 경로만 빼는 작업
				int firstIndex = oldContent.indexOf("<img src=\"", oldCount)+43; //폴더경로에 따라 달라질수있음
				int lastIndex = oldContent.indexOf("\"", oldContent.indexOf("<img src=\"", oldCount)+43);
				oldImgList.add(oldContent.substring(firstIndex, lastIndex));				
				oldCount = oldContent.indexOf("\"", oldContent.indexOf("<img src=\"", oldCount)+10) + 1;	
			}
		}
			
		String content = board.getContentsTag(); //request.getParameter("content_tag");
		ArrayList<String> imgList = new ArrayList<>();
		int count = 0;
		if(content.contains("<img src=")){ //그림첨부를 했을때만
				
			while(count <= content.lastIndexOf("<img src=\"")+43){ //html포함 컨텐츠에서 img 경로만 빼는 작업
				int firstIndex = content.indexOf("<img src=\"", count)+43; //폴더경로에 따라 달라질수있음
				int lastIndex = content.indexOf("\"", content.indexOf("<img src=\"", count)+43);
				imgList.add(content.substring(firstIndex, lastIndex));
				if(count == 0){
					board.setThumbnailName(content.substring(firstIndex, lastIndex));
				}				
				count = content.indexOf("\"", content.indexOf("<img src=\"", count)+10) + 1;
				//System.out.println("현재태그 그림파일 : " + content.substring(firstIndex, lastIndex));		
			}
		}
		
		//수정 전 태그 컨텐츠안에 img파일이 있을경우 수정된 태그 컨텐츠에 없는 img파일이 있을 경우 비교해서 삭제
		if(oldImgList.size() > 0){
			if(imgList.size() == 0){
				for(String oldImg : oldImgList){
					File oldContentFile = new File(newSavePath + "/" + oldImg);
					oldContentFile.delete();
					
				}
			}
			else{
				
				for(String img : imgList){  
					for(String oldImg : oldImgList){
						if(img.contains(oldImg)){
							oldImgList.remove(oldImg); //수정 후에도 존재하는 수정 전 이미지는   수정 전 이미지 모음 배열에서 제거				
							break;
						}
					}
				}
				
				
				if(oldImgList.size() > 0){ // 수정 후 안쓰이는 수정 전 이미지가 있을때
					for(String oldImg : oldImgList){ //수정 후 쓰이지 않는 수정 전 이미지를 전부 삭제
						File oldContentFile = new File(newSavePath + "/" + oldImg);
						oldContentFile.delete();
					}
				}
				
				
			}
		}
		
		//세션에 저장된 upload된 이미지와 실질적으로 게시글에 올라간 이미지와 비교해서
		//일치하는 파일은 임시폴더에서 저장 폴더로 옮긴다
		ArrayList<String> uploadImgList = (ArrayList<String>)request.getSession().getAttribute("imgList");
		
		if(uploadImgList != null){				
			for (String uploadImg : uploadImgList) {
				for (String img : imgList) {
					if (uploadImg.contains(img)) {					
						File oldFile = new File(uploadImg);
						File newFile = new File(newSavePath + "/" + img);
						oldFile.renameTo(newFile);
						break;
					}
				}
			}
		}

		try {
			if (new AdminBoardService().updateAdminBoard(board) > 0) {
				response.sendRedirect("/mimi/adminboarddetailview?bnum="+ boardNum+"&page="+currentPage);
				//response.sendRedirect("/mimi/userboardlist");
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
