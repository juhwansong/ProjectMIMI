package customer.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import customer.exception.CustomerException;
import customer.model.service.CustomerService;

/**
 * Servlet implementation class CustomerDeleteServlet
 */
@WebServlet("/customerdelete")
public class CustomerDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CustomerDeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		
		String dataArr = request.getParameter("dataArr");
		//System.out.println("delete servlet이 받은 값 :: " + dataArr); //넘어오는 값 확인용
		
		if(dataArr.length() < 1){ //null값이 넘어오면 새로고침
			response.sendRedirect("/mimi/customerlist");
			
		}else{
			String[] strArr = dataArr.split(",");	
			ArrayList<String> userId = new ArrayList<>();
			
			//json 쓰면,,,
			for(int i = 2; i < strArr.length; i += 3){
				userId.add(strArr[i - 2]);
				//확인용
				//System.out.println("id값 : " + strArr[i - 2]);
			}
			
			//확인용
			System.out.println("userId.size() : " + userId.size());
			
			RequestDispatcher view = null;
			try {			
				
				if(new CustomerService().deleteCustomerList(userId) > 0){
					response.sendRedirect("/mimi/customerlist"); //성공시 새로고침해서 다시 들어감....
	
				}else{
					view = request.getRequestDispatcher("view/admin/adminError.jsp");
					request.setAttribute("message", "회원 정보 삭제 실패");
					view.forward(request, response);
				}
				
			} catch (CustomerException e) {
				view = request.getRequestDispatcher("view/admin/adminError.jsp");
				request.setAttribute("message", e.getMessage());
			}
		}//if else 종료

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
