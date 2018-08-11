package member.model.service;

import common.model.vo.Member;
import member.exception.MemberException;

public class MemberService {	//회원 가입 및 정보 수정 관련 기능
	public MemberService(){}
	
	public String loginCheck(String userId, String userPwd) throws MemberException{//로그인 할때 기능 아이디를 반환받음
		return null;										//회원정보수정 페이지 들어가기 전 비밀번호 재확인 인증 시에도 같은 메소드 이용
	}

	public int insertMember(Member member) throws MemberException{ //회원가입
		return 0;
	}

	public Member selectMember(String userId) throws MemberException{//본인 정보 가져오기
		return null;
	}

	public int updateMember(Member member) throws MemberException{//본인 정보 수정
		return 0;
	}

	public int leaveMember(String userId) throws MemberException{//회원 탈퇴
		
		return 0;
	}

	public String selectCheckInfo(String whereQuery, String value) throws MemberException{//회원가입 및 수정 시 아이디,닉네임,이메일 입력시 중복되지 않았는지 확인 
																//if문에 따라 다른 String message값을 반환하여 뷰에 출력 		
		return null;
	}

}
