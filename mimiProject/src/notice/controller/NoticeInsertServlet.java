package notice.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import notice.exception.NoticeException;
import notice.model.service.NoticeService;
import notice.model.vo.Notice;

/**
 * Servlet implementation class NoticeInsertServlet
 */
@WebServlet("/noticeinsert")
public class NoticeInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NoticeInsertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		RequestDispatcher view = null;
		
		if(!ServletFileUpload.isMultipartContent(request)){
			view = request.getRequestDispatcher("views/notice/noticeError.jsp");
			request.setAttribute("message", "enctype 속성에 multipart 사용하지 않음");
			view.forward(request, response);
		}
		
		int maxSize = 1024 * 1024 * 10; //최대용량 10Mb
		
		String savePath = request.getSession().getServletContext().getRealPath("/resources/files/notice");  //경로 수정했습니다.
		MultipartRequest mrequest = new MultipartRequest(request, savePath, maxSize, "utf-8", new DefaultFileRenamePolicy());
		
		Notice n = new Notice();
		n.setNoticeTitle(mrequest.getParameter("title"));
		n.setUserId(mrequest.getParameter("userid"));
		n.setNoticeContents(mrequest.getParameter("contents"));
		
		String noticeRealFile = mrequest.getFilesystemName("upfile");
		n.setNoticeRealFile(noticeRealFile);
		
		if(noticeRealFile != null) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			String noticeRenameFile = sdf.format(new java.sql.Date(System.currentTimeMillis())) + "."
					+ noticeRealFile.substring(noticeRealFile.lastIndexOf(".") + 1);
			File originFile = new File(savePath + "\\" + noticeRealFile);
			File renameFile = new File(savePath + "\\" + noticeRenameFile);
			
			if(!originFile.renameTo(renameFile)){
				int read = -1;
				byte[] buf = new byte[1024];
				
				FileInputStream fin = new FileInputStream(originFile);
				FileOutputStream fout = new FileOutputStream(renameFile);
				
				while ((read = fin.read(buf, 0, buf.length)) != -1){
					fout.write(buf, 0, read);
				}
				
				fin.close();
				fout.close();
				originFile.delete();
			}
			
			n.setNoticeRenameFile(noticeRenameFile);
		}
		
		try {
			if(new NoticeService().insertNotice(n) > 0){
				response.sendRedirect("/mimi/noticelist");
			}else{
				view = request.getRequestDispatcher("views/notice/noticeError.jsp");
				request.setAttribute("message", "공지사항 등록에 실패하였습니다.");
				view.forward(request, response);
			}
		} catch (NoticeException e) {
			view = request.getRequestDispatcher("views/notice/noticeError.jsp");
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
