package allcomment.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import allcomment.exception.AllCommentException;
import common.model.vo.Board;

public class AllCommentService { // 관리자 기능 중 전체 댓글 조회 기능
	public AllCommentService(){}
	
	public int getListCount() throws AllCommentException{ //전체 게시물 조회 시 페이지네이션 표현을 위한 총 갯수 필요
		return 0;
	}
	public int getSearchListCount(HashMap<String, String> keword) throws AllCommentException{//검색한 게시물 총 갯수(페이지네이션 관리 시 필요)
		return 0;
	}
	public int deleteAllComment(ArrayList<String> commentNoList) throws AllCommentException{//체크박스에 체크한 게시물 삭제
		return 0;
	}
	public ArrayList<Board> selectAllCommentList() throws AllCommentException{//전체 게시물 조회
		return null;
	}
	public ArrayList<Board> searchAllComment(HashMap<String, String> keword) throws AllCommentException{//키워드 검색에 필요한 데이터를 map에 다 넣음(key는 쿼리문,value는 ?값)
		return null;
	}
}
