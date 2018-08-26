package mycomment.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import common.model.vo.Board;
import mycomment.exception.MyCommentException;

public class MyCommentService {	//회원 기능 중 본인이 작성 한 댓글 조회
	public MyCommentService(){}
	
	public int getListCount() throws MyCommentException{ //전체 게시물 조회 시 페이지네이션 표현을 위한 총 갯수 필요
		return 0;
	}
	public int getSearchListCount(HashMap<String, String> keword) throws MyCommentException{//검색한 게시물 총 갯수(페이지네이션 관리 시 필요)
		return 0;
	}
	public int deleteMyComment(ArrayList<String> commentNoList) throws MyCommentException{//체크박스에 체크한 게시물 삭제
		return 0;
	}
	public ArrayList<Board> selectMyCommentList() throws MyCommentException{//전체 게시물 조회
		return null;
	}
	public ArrayList<Board> searchMyComment(HashMap<String, String> keword) throws MyCommentException{//키워드 검색에 필요한 데이터를 map에 다 넣음(key는 쿼리문,value는 ?값)
		return null;
	}
	
}
