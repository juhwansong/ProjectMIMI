package userboard.model.service;

import static common.jdbc.JDBCTemplate.*;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;

import common.model.vo.Board;
import userboard.exception.UserBoardException;
import userboard.model.dao.UserBoardDao;

public class UserBoardService {	//유저 리뷰 게시판 기능
	public UserBoardService(){}
	
	public void addReadCount(String boardNo) throws UserBoardException{//조회수 증가
		Connection con = getConnection();
		int result  = new UserBoardDao().addReadCount(con, boardNo);
		if (result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
	}
	public int getListCount() throws UserBoardException{//게시물 총 갯수(페이지네이션 관리 시 필요)
		Connection con = getConnection();
		int listCount = new UserBoardDao().getListCount(con);
		close(con);
		return listCount;
	}
	public int getSearchListCount(HashMap<String, String> keword) throws UserBoardException{ //검색한 게시물 총 갯수(페이지네이션 관리 시 필요)
		return 0;
	}
	public int deleteUserBoard(String boardNo) throws UserBoardException{//게시물 삭제
		Connection con = getConnection();
		int result = new UserBoardDao().deleteUserBoard(con, boardNo);
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		return result;
	}
	public Board selectUserBoard(String boardNo) throws UserBoardException{//해당 게시물 클릭
		Connection con = getConnection();
		Board urboard = new UserBoardDao().selectUserBoard(con, boardNo);
		close(con);
		return urboard;
	}
	
	public int insertUserBoard(Board board) throws UserBoardException{ //게시물 추가
		Connection con = getConnection();
		int result = new UserBoardDao().insertUserBoard(con, board);
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		return result;
	}
	
	public ArrayList<Board> selectUserBoardList(int currentPage, int limit) throws UserBoardException{//전체 게시물 조회
		Connection con = getConnection();
		ArrayList<Board> list = new UserBoardDao().selectList(con, currentPage, limit);
		close(con);
		return list;
	}
	
	public ArrayList<Board> selectUserBoardList2() throws UserBoardException{//전체 게시물 조회
		Connection con = getConnection();
		ArrayList<Board> list = new UserBoardDao().selectList2(con);
		close(con);
		return list;
	}
	
	public int updateUserBoard(Board board) throws UserBoardException{ //게시물 수정
		Connection con = getConnection();
		int result = new UserBoardDao().updateBoard(con, board);
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		return result;
	}
	
	public ArrayList<Board> searchUserBoard(HashMap<String, String> keword) throws UserBoardException{//게시물 정렬,키워드 검색 등 필요 데이터를 map에 다 넣음(key는 쿼리문,value는 ?값)
		return null;
	}
	
	public int getListReplyCount() throws UserBoardException{//게시물 총 갯수(페이지네이션 관리 시 필요)
		Connection con = getConnection();
		int listCount = new UserBoardDao().getListCount(con);
		close(con);
		return listCount;
	}
	
	public ArrayList<Board> selectUserBoardReplyList(String boardNum, int currentPage, int limit) throws UserBoardException{//해당 게시물의 전체 댓글 조회
		Connection con = getConnection();
		ArrayList<Board> list = new UserBoardDao().selectReplyList(con, boardNum, currentPage, limit);
		close(con);
		return list;
	}
	
	public int insertUserBoardReply(String boardNum, Board board) throws UserBoardException{//게시물 댓글 추가
		Connection con = getConnection();
		int result = new UserBoardDao().insertReply(con, boardNum, board);
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		return result;
	}
	
	public int updateUserBoardReply(Board board) throws UserBoardException{//게시물 댓글 수정
		return 0;
	}
	
	public int deleteUserBoardReply(String commentNo) throws UserBoardException{//게시물 댓글 삭제
		return 0;
	}
}
