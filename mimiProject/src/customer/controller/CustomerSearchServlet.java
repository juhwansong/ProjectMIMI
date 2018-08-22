package customer.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.model.vo.Member;
import customer.exception.CustomerException;
import customer.model.service.CustomerService;

/**
 * Servlet implementation class CustomerSearchServlet
 */
@WebServlet("/customersearch")
public class CustomerSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CustomerSearchServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");		
		int currentPage = 1; //맨 첫화면은 1페이지
		int countList = 10;	//한 화면에 출력될 리스트 개수
		int countPage = 10; //한 화면에 출력될 페이지 개수
		
		String column = request.getParameter("select-category");
		String value = request.getParameter("search-text");
		System.out.println("변환전 value : " + value);
		if(column.equals("all")){
			response.sendRedirect("/mimi/customerlist"); //성공시 새로고침해서 다시 들어감....
		}else if(column.equals("authority")){
			if(value.equals("관리자"))
				value = "A";
			else if(value.equals("회원"))
				value = "U";
		}else if(column.equals("state")){
			if(value.equals("삭제대기"))
				value = "SD";
			else if(value.equals("일반"))
				value = "SN";	
		}
		
		//값 확인
		//System.out.println("column :: " + column);
		//System.out.println("value :: " + value);
		
		
		if(request.getParameter("page") != null) {
			currentPage = Integer.parseInt(request.getParameter("page"));
		}
		
		RequestDispatcher view = null;
		try {
			ArrayList<Member> list = new CustomerService().searchCustomer(column, value, currentPage, countList);
			
			int totalCount = list.size();
			int maxPage = totalCount / countList;
			if(totalCount % countList > 0)
				maxPage++;
			
			if(maxPage < currentPage)
				currentPage = maxPage;
			
			
			int startPage = ((currentPage - 1) / 10) * 10 + 1;
			int endPage = startPage + countPage - 1;
			
			if(endPage > maxPage)
				endPage = maxPage;

//			if(list.size() > 0){
				view = request.getRequestDispatcher("views/admin/userInfoManage.jsp");
				request.setAttribute("customerList", list);
				request.setAttribute("currentPage", currentPage);
				request.setAttribute("maxPage", maxPage);
				request.setAttribute("startPage", startPage);
				request.setAttribute("endPage", endPage);
				request.setAttribute("totalCount", totalCount);
				view.forward(request, response);

//			}else{
//				//목록이 없을때...
//				view = request.getRequestDispatcher("view/admin/adminPageError.jsp");
//				request.setAttribute("message", "회원이 존재하지 않습니다.");
//				view.forward(request, response);
//			}
		} catch (CustomerException e) {
			view = request.getRequestDispatcher("view/admin/adminPageError.jsp");
			request.setAttribute("message", e.getMessage());
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
