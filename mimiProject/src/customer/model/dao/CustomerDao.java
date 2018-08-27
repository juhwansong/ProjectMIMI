package customer.model.dao;

import static common.jdbc.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map.Entry;

import common.model.vo.Member;
import customer.exception.CustomerException;

public class CustomerDao {

	//전체 회원 조회
	public ArrayList<Member> selectAllCustomerList(Connection conn, int currentPage, int countList) throws CustomerException{
		ArrayList<Member> list = new ArrayList<Member>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "SELECT * FROM (SELECT ROWNUM RNUM, USER_ID, USER_NAME, NICKNAME, EMAIL, PHONE, "
				+ "GRADE_POINT, GRADE_NAME, AUTHORITY, STATE, DEL_DATE"
				+ " FROM (SELECT * FROM TB_USER ORDER BY GRADE_POINT DESC, STATE, AUTHORITY, USER_ID))"
				+ " WHERE RNUM >= ? AND RNUM <= ?";
		
		int startRow = (currentPage - 1) * countList + 1;
		int endRow = startRow + countList - 1;
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rset = pstmt.executeQuery();
			
			while(rset.next()){
				Member m = new Member();
				m.setUserId(rset.getString("user_id"));
				m.setUserName(rset.getString("user_name"));
				m.setNickName(rset.getString("nickname"));
				m.setEmail(rset.getString("email"));
				m.setPhone(rset.getString("phone"));
				m.setGradeName(rset.getString("grade_name"));
				m.setGradePoint(rset.getInt("grade_point"));
				m.setAuthority(rset.getString("authority"));
				m.setState(rset.getString("state"));
				m.setDelDate(rset.getDate("del_date"));
				
				list.add(m);
			}//while close
//			
//			if(list.size() == 0)
//				throw new CustomerException("회원이 존재하지 않습니다.");
//			
		} catch (Exception e) {
			e.printStackTrace();
			throw new CustomerException(e.getMessage());
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return list;
	}

	//전체 회원 수 조회용
	public int getListCount(Connection conn) throws CustomerException{
		int listCount = 0;
		Statement stmt = null;
		ResultSet rset = null;
		String query = "SELECT COUNT(*) FROM TB_USER";
		
		try {
			stmt = conn.createStatement();
			rset = stmt.executeQuery(query);
			
			if(rset.next()){
				listCount = rset.getInt(1);
			}else{
//				throw new CustomerException("회원이 존재하지 않습니다.");
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new CustomerException(e.getMessage());
		} finally {
			close(rset);
			close(stmt);
		}
		return listCount;
	}

	//선택한 회원들 정보 수정
	public int updateCustomer(Connection conn, HashMap<String, String> map) throws CustomerException{
		int result = 0;
		PreparedStatement pstmt = null;
		
		try {
			for(Entry<String, String> entry : map.entrySet()){
				String query = "UPDATE TB_USER SET";
				query += entry.getValue() + "WHERE USER_ID = '" + entry.getKey() + "'";
				pstmt = conn.prepareStatement(query);

				//System.out.println("쿼리 확인용 : " + query);
				result = pstmt.executeUpdate();
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new CustomerException(e.getMessage());
		} finally {
			close(pstmt);
		}
		return result;
	}

	//선택한 회원 정보들 삭제
	public int deleteCustomerList(Connection conn, ArrayList<String> userId) throws CustomerException{
		int result = 0;
		PreparedStatement pstmt = null;
		//System.out.println("삭제될 회원 수 : " + userId.size()); //확인용
		String query = "DELETE FROM TB_USER WHERE USER_ID = ?";
		try {
			pstmt = conn.prepareStatement(query);
			for(String id : userId){
				pstmt.setString(1, id);
				result = pstmt.executeUpdate();
			}			
			if(result <= 0)
				throw new CustomerException("회원정보 삭제 실패...");
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new CustomerException(e.getMessage());
		} finally {
			close(pstmt);
		}
		return result;
	}

	//검색한 회원 목록
	public ArrayList<Member> searchCustomer(Connection conn, String column, String value, int currentPage,
			int countList) throws CustomerException{
		ArrayList<Member> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "SELECT * FROM (SELECT ROWNUM RNUM, USER_ID, USER_NAME, NICKNAME, EMAIL, PHONE, "
				+ "GRADE_POINT, GRADE_NAME, AUTHORITY, STATE, DEL_DATE"
				+ " FROM (SELECT * FROM TB_USER WHERE " + column
				+ " LIKE ? ORDER BY GRADE_POINT DESC, STATE, AUTHORITY, USER_ID))"
				+ " WHERE RNUM >= ? AND RNUM <= ?";
		
		int startRow = (currentPage - 1) * countList + 1;
		int endRow = startRow + countList - 1;
		
		try {
			pstmt = conn.prepareStatement(query);
			//pstmt.setString(1, column); // 인식 못 함
			pstmt.setString(1, "%" + value + "%");
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			rset = pstmt.executeQuery();
			
			while(rset.next()){
				Member m = new Member();
				m.setUserId(rset.getString("user_id"));
				m.setUserName(rset.getString("user_name"));
				m.setNickName(rset.getString("nickname"));
				m.setEmail(rset.getString("email"));
				m.setPhone(rset.getString("phone"));
				m.setGradeName(rset.getString("grade_name"));
				m.setGradePoint(rset.getInt("grade_point"));
				m.setAuthority(rset.getString("authority"));
				m.setState(rset.getString("state"));
				m.setDelDate(rset.getDate("del_date"));
				
				list.add(m);
			}//while close
			
			System.out.println("dao size : " + list.size());
//			if(list.size() == 0)
//				throw new CustomerException("회원이 존재하지 않습니다.");
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new CustomerException(e.getMessage());
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return list;
	}

	//검색한 회원수
	public int getSearchListCount(Connection conn, String column, String value) throws CustomerException{
		int listCount = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "SELECT COUNT(*) FROM (SELECT ROWNUM RNUM, USER_ID, USER_NAME, NICKNAME, EMAIL, PHONE, "
				+ "GRADE_POINT, GRADE_NAME, AUTHORITY, STATE, DEL_DATE"
				+ " FROM (SELECT * FROM TB_USER WHERE " + column
				+ " LIKE ? ORDER BY GRADE_POINT DESC, STATE, AUTHORITY, USER_ID))";
		System.out.println(query);
		try {
			pstmt = conn.prepareStatement(query);
			//pstmt.setString(1, column); // 인식 못 함
			pstmt.setString(1, "%" + value + "%");
			rset = pstmt.executeQuery();
			
			if(rset.next()){
				listCount = rset.getInt(1);
			}else{
//				throw new CustomerException("회원이 존재하지 않습니다.");
			}
			System.out.println("작동확인... : " + listCount);
		} catch (Exception e) {
			e.printStackTrace();
			throw new CustomerException(e.getMessage());
		} finally {
			close(rset);
			close(pstmt);
		}
		return listCount;
	}


}
