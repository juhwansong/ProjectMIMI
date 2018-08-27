package userboard.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.model.vo.Board;
import userboard.exception.UserBoardException;
import userboard.model.service.UserBoardService;

/**
 * Servlet implementation class UserBoardInsertServlet
 */
@WebServlet("/userboardinsert")
public class UserBoardInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserBoardInsertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
						
		int maxSize = 1024 * 1024 * 10;
		
		HttpSession session = request.getSession();	
		RequestDispatcher view = null;
		
		/*
		if (!ServletFileUpload.isMultipartContent(request)) {
			view = request.getRequestDispatcher("views/userReview/userReviewError.jsp");
			request.setAttribute("message", "enctype 속성 값 에러!");
			view.forward(request, response);
		}
		*/
		// 파일이 업로드되어 저장될 폴더 지정
		//String savePath = request.getSession().getServletContext().getRealPath("/resources/files/userboard");

		// request 를 MultipartRequest 로 변환함
		/*MultipartRequest mrequest = new MultipartRequest(request, savePath, maxSize, "UTF-8",
				new DefaultFileRenamePolicy());*/
		
		// 전송온 값 꺼내서 변수/객체에 저장하기
		Board board = new Board();
		board.setCategoryNo(request.getParameter("categoryNo"));	//카테고리 연결필요
		
		board.setUserId((String)session.getAttribute("userId"));
		board.setTitle(request.getParameter("title"));
		board.setContents(request.getParameter("content"));
		board.setContentsTag(request.getParameter("content_tag").replaceAll("resources/waitimage", "resources/files/userboard"));//임시폴더경로를 새폴더경로로 바꿔서 저장
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
				
			while(count <= content.lastIndexOf("<img src=\"")+36){ //html포함 컨텐츠에서 img 경로만 빼는 작업
				int firstIndex = content.indexOf("<img src=\"", count)+36; //폴더경로에 따라 달라질수있음
				int lastIndex = content.indexOf("\"", content.indexOf("<img src=\"", count)+36);
				imgList.add(content.substring(firstIndex, lastIndex));
	
				if(count == 0){
					board.setThumbnailName(content.substring(firstIndex, lastIndex));
				}
				
				count = content.indexOf("\"", content.indexOf("<img src=\"", count)+10) + 1;	
			}
		}
		
		ArrayList<String> uploadImgList = (ArrayList<String>)request.getSession().getAttribute("imgList");
		System.out.println("섹션 리스트 : " + uploadImgList);
		//세션에 저장된 upload된 이미지와 실질적으로 게시글에 올라간 이미지와 비교해서
		//일치하는 파일은 임시폴더에서 저장 폴더로 옮긴다
		if(uploadImgList != null){
			for (String uploadImg : uploadImgList) {
				for (String img : imgList) {
					if (uploadImg.contains(img)) {
						String newSavePath = request.getSession().getServletContext().getRealPath("resources/files/userboard");   //옮기는 저장폴더 경로
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
		
		
		
		// 저장폴더에 기록된 원래 파일명 조회
		//String originalFileName = mrequest.getFilesystemName("upfile");
		
		//board.setBoardOriginalFileName(originalFileName);
		
		/*
		// 업로드된 파일명을 "년월일시분초.확장자" 로 변경함
		if (originalFileName != null) {
			// 변경할 파일명 만들기
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			String renameFileName = sdf.format(new java.sql.Date(System.currentTimeMillis())) + "."
					+ originalFileName.substring(originalFileName.lastIndexOf(".") + 1);

			// 파일명 바꾸려면 File 객체의 renameTo() 사용함
			File originFile = new File(savePath + "\\" + originalFileName);
			File renameFile = new File(savePath + "\\" + renameFileName);

			// 파일 이름바꾸기 실행 >> 실패할 경우 직접 바꾸기함
			// 새 파일만들고 원래 파일 내용 읽어서 복사하고
			// 복사가 끝나면 원래 파일 삭제함
			if (!originFile.renameTo(renameFile)) {
				int read = -1;
				byte[] buf = new byte[1024];

				FileInputStream fin = new FileInputStream(originFile);
				FileOutputStream fout = new FileOutputStream(renameFile);

				while ((read = fin.read(buf, 0, buf.length)) != -1) {
					fout.write(buf, 0, read);
				}

				fin.close();
				fout.close();
				// 원본 파일 삭제함
				originFile.delete();
			}
			//board.setBoardRenameFileName(renameFileName);
		}
		*/
		try {
			if (new UserBoardService().insertUserBoard(board) > 0) {
				//response.sendRedirect("/mimi/userboarddetailview?bnum="+bnum+"&page="+1);
				response.sendRedirect("/mimi/userboardlist?page=1");
			} else {
				view = request.getRequestDispatcher("views/userReview/userReviewError.jsp");
				request.setAttribute("message", "게시 원글 등록 실패");
				view.forward(request, response);
			}
		} catch (UserBoardException e) {
			view = request.getRequestDispatcher("views/userReview/userReviewError.jsp");
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



