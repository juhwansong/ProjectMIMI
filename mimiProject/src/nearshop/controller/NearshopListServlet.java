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
		int currentPage = 1;
		int countList = 10;
		int countPage = 5;
		
		if(request.getParameter("page") != null){
			currentPage = Integer.parseInt(request.getParameter("page"));
		}
			
		ArrayList<Board> boardList = new NearshopService().selectNearshopList(currentPage, countList, latitude, longitude);
		
		int totalCount = new NearshopService().getListCount(latitude, longitude);
		
		int maxPage = totalCount / countList;
		if(totalCount % countList > 0)
			maxPage++;
		
		if(maxPage < currentPage)
			currentPage = maxPage;
		
		
		int startPage = ((currentPage - 1) / 5) * 5 + 1;
		int endPage = startPage + countPage - 1;
		
		if(endPage > maxPage)
			endPage = maxPage;
	
		JSONObject json = new JSONObject();	
		JSONArray jarr = new JSONArray();
		
		if(boardList.size() > 0){
			for(int i=0; i< boardList.size(); i++){
				JSONObject job = new JSONObject();
				if(i == 0){
					job.put("currentPage", currentPage);
					job.put("maxPage", maxPage);
					job.put("startPage", startPage);
					job.put("endPage", endPage);
					job.put("totalCount", totalCount);
				}
		
				job.put("board_no", boardList.get(i).getBoardNo());
				
				job.put("title", URLEncoder.encode(boardList.get(i).getTitle(), "utf-8").replaceAll("\\+", "%20")); //인코딩되면서 공백문자가 +로 바뀜

			
				job.put("contents", URLEncoder.encode(boardList.get(i).getContents(), "utf-8").replaceAll("\\+", "%20"));
			
				
				if(boardList.get(i).getThumbnailName() != null){
				
					job.put("thumbnail_name", URLEncoder.encode(boardList.get(i).getThumbnailName(), "utf-8").replaceAll("\\+", "%20"));
								
				}
				
				job.put("y", boardList.get(i).getLatitude());
				job.put("x", boardList.get(i).getLongitude());
				job.put("place_name", URLEncoder.encode(boardList.get(i).getShopName(), "utf-8").replaceAll("\\+", "%20"));

				job.put("address_name", URLEncoder.encode(boardList.get(i).getShopAddress(), "utf-8").replaceAll("\\+", "%20"));

				
				job.put("phone", boardList.get(i).getShopCall());
				job.put("boardNo", boardList.get(i).getBoardNo());
				
					
				jarr.add(job);
				
			}
			
			json.put("list", jarr);
		}
		
		System.out.println("한번");
		System.out.println("-----------");
		
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
