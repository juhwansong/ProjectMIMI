package customer.model.service;

import static common.jdbc.JDBCTemplate.close;
import static common.jdbc.JDBCTemplate.commit;
import static common.jdbc.JDBCTemplate.getConnection;
import static common.jdbc.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;

import common.model.vo.Member;
import customer.exception.CustomerException;
import customer.model.dao.CustomerDao;

public class CustomerService {	//관리자 기능 중 전체 회원 관리 기능
	public CustomerService(){}
	
	public int getListCount() throws CustomerException{ //전체 회원 조회 시 페이지네이션 표현을 위한 총 갯수 필요
		Connection conn = getConnection();
		int listCount = new CustomerDao().getListCount(conn);
		close(conn);
		return listCount;
	}
	public int getSearchListCount(HashMap<String, String> keword) throws CustomerException{ //검색한 회원 총 수(페이지네이션 관리 시 필요)
		return 0;
	}
	public int deleteCustomerList(ArrayList<String> userId) throws CustomerException{ //체크박스에 체크한 회원 삭제
		Connection conn = getConnection();
		int result = new CustomerDao().deleteCustomerList(conn,userId);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		return result;
	}

	public int updateCustomerList(HashMap<String, String> map) throws CustomerException{ //체크박스에 체크한 회원 수정
		Connection conn = getConnection();
		int result = new CustomerDao().updateCustomer(conn, map);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;		
	}
	public ArrayList<Member> selectAllCustomerList(int currentPage, int countList) throws CustomerException{ //전체 회원 조회
		//목록 페이지네이션용 매개변수 추가
		Connection conn = getConnection();
		ArrayList<Member> list = new CustomerDao().selectAllCustomerList(conn, currentPage, countList);
		close(conn);
		return list;
	}
	public ArrayList<Member> searchCustomer(String column, String value, int currentPage, int countList) throws CustomerException{//키워드 검색에 필요한 데이터를 map에 다 넣음(key는 쿼리문,value는 ?값)
		Connection conn = getConnection();
		ArrayList<Member> list = new CustomerDao().searchCustomer(conn, column, value, currentPage, countList);
		close(conn);
		return list;
	}

	//검색한 회원수
	public int getSearchListCount(String column, String value) throws CustomerException{
		Connection conn = getConnection();
		int result = new CustomerDao().getSearchListCount(conn, column, value);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;	

	}

	public void deleteCustomerRecommend(ArrayList<String> userId) {
		Connection conn = getConnection();
		int result = new CustomerDao().deleteCustomerRecommend(conn,userId);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);		
	}

}
