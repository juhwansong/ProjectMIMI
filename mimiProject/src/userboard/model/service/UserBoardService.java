package userboard.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import common.model.vo.Board;
import userboard.exception.UserBoardException;

public class UserBoardService {	//유저 리뷰 게시판 기능
	public UserBoardService(){}
	
	public void addReadCount(String boardNo) throws UserBoardException{//조회수 증가
		
	}
	public int getListCount() throws UserBoardException{//게시물 총 갯수(페이지네이션 관리 시 필요)
		return 0;
	}
	public int getSearchListCount(HashMap<String, String> keword) throws UserBoardException{ //검색한 게시물 총 갯수(페이지네이션 관리 시 필요)
		return 0;
	}
	public int deleteUserBoard(String boardNo) throws UserBoardException{//게시물 삭제
		return 0;
	}
	public Board selectUserBoard(String boardNo) throws UserBoardException{//해당 게시물 클릭
		return null;
	}
	
	public int insertUserBoard(Board board) throws UserBoardException{ //게시물 추가
		return 0;
	}
	public ArrayList<Board> selectUserBoardList() throws UserBoardException{//전체 게시물 조회
		return null;
	}
	public int updateUserBoard(Board board) throws UserBoardException{ //게시물 수정
		return 0;
	}
	
	public ArrayList<Board> searchUserBoard(HashMap<String, String> keword) throws UserBoardException{//게시물 정렬,키워드 검색 등 필요 데이터를 map에 다 넣음(key는 쿼리문,value는 ?값)
		return null;
	}
	public int deleteUserBoardReply(String commentNo) throws UserBoardException{//게시물 댓글 삭제
		return 0;
	}
	public int insertUserBoardReply(Board board) throws UserBoardException{//게시물 댓글 추가
		return 0;
	}
	public int updateUserBoardReply(Board board) throws UserBoardException{//게시물 댓글 수정
		return 0;
	}
	public ArrayList<Board> selectUserBoardReplyList(String boardNo) throws UserBoardException{//해당 게시물의 전체 댓글 조회
		return null;
	}
}
