package member.model.service;

import static common.jdbc.JDBCTemplate.*;

import java.sql.Connection;

import common.model.vo.Member;
import member.exception.MemberException;
import member.model.dao.MemberDao;

public class MemberService {	//회원 가입 및 정보 수정 관련 기능
	public MemberService(){}
	
	public Member loginCheck(String userId, String userPwd) throws MemberException{//로그인 할때 기능 아이디를 반환받음
		Connection con = getConnection();			//회원정보수정 페이지 들어가기 전 비밀번호 재확인 인증 시에도 같은 메소드 이용
		Member member = new MemberDao().loginCheck(con, userId, userPwd);
		close(con);
		
		return member;
	}

	public int insertMember(Member member) throws MemberException{ //회원가입
		Connection con = getConnection();
		int result = 0;
		result = new MemberDao().insertMember(con, member);
		
		if(result > 0){
			commit(con);
		}
		else{
			rollback(con);
		}
		
		close(con);
		
		return result;
	}

	public Member selectMember(String userId) throws MemberException{//본인 정보 가져오기
		Member member = null;
		Connection con = getConnection();
		member = new MemberDao().selectMember(con, userId);
		close(con);
		
		return member;
	}

	public int updateMember(Member member) throws MemberException{//본인 정보 수정
		int result = 0;
		Connection con = getConnection();
		result = new MemberDao().updateMember(con, member);
		
		if(result > 0){
			commit(con);
		}
		else{
			rollback(con);
		}
		
		close(con);
		
		return result;
	}

	public int leaveMember(String userId) throws MemberException{//회원 탈퇴
		int result = 0;
		Connection con = getConnection();
		result = new MemberDao().leaveMember(con, userId);
		
		if(result > 0){
			commit(con);
		}
		else{
			rollback(con);
		}
		close(con);
		
		return result;
	}

	public String selectCheckInfo(String whereQuery, String value){//회원가입 및 수정 시 아이디,닉네임,이메일 입력시 중복되지 않았는지 확인 
		Connection con = getConnection();
		String result = new MemberDao().selectCheckInfo(con, whereQuery, value);
		close(con);
		return result;
	}

	public String findId(String userName, String email) {
		Connection con = getConnection();			
		String resultId = null;	
		resultId = new MemberDao().findId(con, userName, email);
		close(con);
		
		return resultId;
	}

	public String findPassword(String userId, String email) {
		Connection con = getConnection();			
		String resultId = null;	
		resultId = new MemberDao().findPassword(con, userId, email);
		close(con);
		
		return resultId;
	}

	public int updatePassword(String userId, String userPwd) throws MemberException{ //새 비밀번호 등록
		int result = 0;
		Connection con = getConnection();
		result = new MemberDao().updatePassword(con, userId, userPwd);
		
		if(result > 0){
			commit(con);
		}
		else{
			rollback(con);
		}
		
		close(con);
		
		return result;
	}

}
