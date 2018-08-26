package nearshop.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.ArrayList;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import common.model.vo.Board;
import nearshop.model.service.NearshopService;

/**
 * Servlet implementation class NearshopListServlet
 */
@WebServlet("/nearshoplist")
public class NearshopListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NearshopListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Double latitude = Double.parseDouble(request.getParameter("latitude"));
		Double longitude = Double.parseDouble(request.getParameter("longitude"));
		ArrayList<Board> boardList = new NearshopService().selectNearshopList(latitude, longitude);
		
		JSONObject json = new JSONObject();	
		JSONArray jarr = new JSONArray();
		
		if(boardList.size() > 0){
			for(Board board : boardList){
				JSONObject job = new JSONObject();
				job.put("board_no", board.getBoardNo());
				
				job.put("title", URLEncoder.encode(board.getTitle(), "utf-8").replaceAll("\\+", "%20")); //인코딩되면서 공백문자가 +로 바뀜

			
				job.put("contents", URLEncoder.encode(board.getContents(), "utf-8").replaceAll("\\+", "%20"));
			
				
				if(board.getThumbnailName() != null){
				
					job.put("thumbnail_name", URLEncoder.encode(board.getThumbnailName(), "utf-8").replaceAll("\\+", "%20"));
								
				}
				
				job.put("y", board.getLatitude());
				job.put("x", board.getLongitude());
				job.put("place_name", URLEncoder.encode(board.getShopName(), "utf-8").replaceAll("\\+", "%20"));

				job.put("address_name", URLEncoder.encode(board.getShopAddress(), "utf-8").replaceAll("\\+", "%20"));

				
				job.put("phone", board.getShopCall());
				job.put("boardNo", board.getBoardNo());
				
					
				jarr.add(job);
				
			}
			
			json.put("list", jarr);
		}
		
		
		
		response.setContentType("application/json; charset=utf-8");
		
		PrintWriter out = response.getWriter();
		out.print(json.toJSONString());
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
