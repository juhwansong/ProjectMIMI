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
 * Servlet implementation class CustomerListServlet
 */
@WebServlet("/customerlist")
public class CustomerListServlet extends HttpServlet {
	private static final long serialVersionUID = 456151L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CustomerListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8");
		int currentPage = 1; //맨 첫화면은 1페이지
		int countList = 15;	//한 화면에 출력될 리스트 개수
		int countPage = 10; //한 화면에 출력될 페이지 개수
		
		if(request.getParameter("page") != null) {
			currentPage = Integer.parseInt(request.getParameter("page"));
		}
		
		RequestDispatcher view = null;
		try {
			ArrayList<Member> memberList = new CustomerService().selectAllCustomerList(currentPage, countList); //전체회원조회
			
			int totalCount = new CustomerService().getListCount();
			int maxPage = totalCount / countList;
			if(totalCount % countList > 0)
				maxPage++;
			
			if(maxPage < currentPage)
				currentPage = maxPage;
			
			
			int startPage = ((currentPage - 1) / 10) * 10 + 1;
			int endPage = startPage + countPage - 1;
			
			if(endPage > maxPage)
				endPage = maxPage;
		
			
			if(memberList.size() > 0){
				view = request.getRequestDispatcher("views/admin/userInfoManage.jsp");
				request.setAttribute("customerList", memberList);
				request.setAttribute("currentPage", currentPage);
				request.setAttribute("maxPage", maxPage);
				request.setAttribute("startPage", startPage);
				request.setAttribute("endPage", endPage);
				request.setAttribute("totalCount", totalCount);
				view.forward(request, response);
			}else{
				view = request.getRequestDispatcher("view/admin/adminError.jsp");
				request.setAttribute("message", "회원 정보가 없습니다.");
				view.forward(request, response);
			}
			
		} catch (CustomerException e) {
			view = request.getRequestDispatcher("view/admin/adminError.jsp");
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
