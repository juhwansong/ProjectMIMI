package customer.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import common.model.vo.Member;
import customer.exception.CustomerException;

public class CustomerService {	//관리자 기능 중 전체 회원 관리 기능
	public CustomerService(){}
	
	public int getListCount() throws CustomerException{ //전체 회원 조회 시 페이지네이션 표현을 위한 총 갯수 필요
		return 0;
	}
	public int getSearchListCount(HashMap<String, String> keword) throws CustomerException{ //검색한 회원 총 수(페이지네이션 관리 시 필요)
		return 0;
	}
	public int deleteCustomer(String userId) throws CustomerException{ //체크박스에 체크한 회원 삭제
		return 0;
	}
	public int updateCustomer(ArrayList<Member> memberList) throws CustomerException{ //체크박스에 체크한 회원 수정
		return 0;
	}
	public ArrayList<Member> selectAllCustomerList() throws CustomerException{ //전체 회원 조회
		return null;
	}
	public ArrayList<Member> searchCustomer(HashMap<String, String> keword) throws CustomerException{//키워드 검색에 필요한 데이터를 map에 다 넣음(key는 쿼리문,value는 ?값)
		return null;
	}

}
