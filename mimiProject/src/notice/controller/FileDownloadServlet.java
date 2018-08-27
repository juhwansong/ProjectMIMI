package notice.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class FileDownloadServlet
 */
@WebServlet("/filedownload")
public class FileDownloadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FileDownloadServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String readFolder = request.getSession().getServletContext().getRealPath("/files/notice");
		String noticeRealFile = request.getParameter("ofile");
		String noticeRenameFile = request.getParameter("rfile");
		
		ServletOutputStream downOut = response.getOutputStream();
		
		File downFile = new File(readFolder + "/" + noticeRenameFile);
		
		response.setContentType("text/plain; charset=utf-8");
		response.addHeader("Content-Disposition", "attachment; filename=\"" + new String(noticeRealFile.getBytes("utf-8"), "ISO-8859-1") + "\"");
		response.setContentLength((int) downFile.length());
		
		BufferedInputStream bin = new BufferedInputStream(new FileInputStream(downFile));
		
		int read = -1;
		while((read = bin.read()) != -1){
			downOut.write(read);
			downOut.flush();
		}
		downOut.close();
		bin.close();

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
