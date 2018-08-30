package adminboard.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

/**
 * Servlet implementation class AdminFileUploadServlet
 */
@WebServlet("/adminfileupload")
public class AdminFileUploadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminFileUploadServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//서머노트 에디터 시스템상 즉시 파일 업로드를 위한 서블릿 필요
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=utf-8");
		
		String 			savePath 		= "";
		String 			originFileName = ""; //바꿀이름들을 저장
		String 			convertFileName = "";
		int 			maxSize 		= 1024 * 1024 * 10; // 10MB
		String 			encType 		= "UTF-8";
		String 			saveFolder 		= "/resources/waitimage";
		ServletContext 	scontext 		= request.getSession().getServletContext(); //서블릿 컨텍스트
		
		savePath = scontext.getRealPath( saveFolder ); //절대 경로 + 저장할 폴더 이름

		try {
			// File Upload
			// 파일명 변경은 multi 생성시 바로 업로드 되기 때문에 업로드 후 변경
			//DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();

			MultipartRequest multi 	= new MultipartRequest(
										  request
										, savePath
										, maxSize
										, encType
										, new DefaultFileRenamePolicy()//파일 등록할때 중복방지(뒤에 1,2,3..으로 중복방지해주는 클래스)
									);
			//String file = (String)multi.getFileNames().nextElement(); //업로드된 파일의 이름을 가져온다
			
			String file = (String)multi.getFileNames().nextElement();
			originFileName = multi.getFilesystemName(file);
			//originFileName = multi.getOriginalFileName(file); //가져온 파일이름의 원래 이름(중복됐을경우 뒤에 1,2,3..으로 추가 표기됐기때문)
		}
		catch ( Exception e ) { 
			e.printStackTrace(); 
		}

		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMDDHHMMss");
		//convertFileName = sdf.format(new Date(System.currentTimeMillis()))+ "." + originFileName.substring(originFileName.indexOf(".")+1);
		convertFileName = sdf.format(new Date(System.currentTimeMillis())) + "_" + originFileName;
		
		File oldFile = new File( savePath + "/" + originFileName );		
		File newFile = new File( savePath + "/" + convertFileName );

		// 파일명 변경
		if(!oldFile.renameTo(newFile)){
			int read = -1;
			byte[] buf = new byte[1024];
			
			FileInputStream fin = new FileInputStream(oldFile);
			FileOutputStream fout = new FileOutputStream(newFile);
			
			while((read = fin.read(buf, 0, buf.length)) != -1){
				fout.write(buf, 0, read);
			}
			fin.close();
			fout.close();
		}
		
		//세션 선언
		HttpSession session = request.getSession();
		
		//세션에 업로드한 이미지 경로 저장
		if(session.getAttribute("imgList") == null){
			ArrayList<String> imgList = new ArrayList<>();			
			imgList.add(savePath + "/" + convertFileName);		
			session.setAttribute("imgList", imgList);
			
			
		}else{
			ArrayList<String> imgList = (ArrayList<String>)session.getAttribute("imgList");			
			session.removeAttribute("imgList");			
			imgList.add(savePath + "/" + convertFileName);			
			session.setAttribute("imgList", imgList);
		}
		
		
		String imgUrl = request.getContextPath() + "/resources/waitimage/" + convertFileName;		 
			
		PrintWriter out = response.getWriter();
		out.print(imgUrl);
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
