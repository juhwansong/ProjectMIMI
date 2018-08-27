package adminboard.model.service;


import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;

import static common.jdbc.JDBCTemplate.*;
import adminboard.exception.AdminBoardException;
import adminboard.model.dao.AdminBoardDao;
import common.model.vo.Board;

public class AdminBoardService {//미미 리뷰 게시판 기능
	public AdminBoardService(){}
	
	public void addReadCount(String boardNo) throws AdminBoardException{//조회수 증가
		
	}
	
	//게시물 총 갯수(페이지네이션 관리 시 필요)
	public int getListCount() throws AdminBoardException{
		Connection conn = getConnection();
		int listCount = new AdminBoardDao().getListCount(conn);
		close(conn);
		return listCount;
	}
	
	//검색한 게시물 총 갯수(페이지네이션 관리 시 필요)
	public int getSearchListCount(String query) throws AdminBoardException{
		Connection conn = getConnection();
		int listCount = new AdminBoardDao().getListCount(conn, query);
		close(conn);
		return listCount;
	}
	
	public int deleteAdminBoard(String boardNo) throws AdminBoardException{//게시물 삭제
		return 0;
	}
	
	public Board selectAdminBoard(String boardNo) throws AdminBoardException{//해당 게시물 클릭
		return null;
	}
	
	public int insertAdminBoard(Board board) throws AdminBoardException{ //게시물 추가
		return 0;
	}
	
	//전체 게시물 리스트
	public ArrayList<Board> selectAdminBoardList(int currentPage, int countList) throws AdminBoardException{
		Connection conn = getConnection();
		ArrayList<Board> list = new AdminBoardDao().selectAdminList(conn, currentPage, countList);
		close(conn);
		return list;
	}
	public int updateAdminBoard(Board board) throws AdminBoardException{ //게시물 수정
		return 0;
	}
	
	
	//게시물 정렬,키워드 검색 등 필요 데이터를 map에 다 넣음(key는 쿼리문,value는 ?값)
	public ArrayList<Board> searchAdminBoard(HashMap<String, String> keyword, int currentPage, int countList) throws AdminBoardException{
		return null;
	}
	
	public int deleteAdminBoardReply(String commentNo) throws AdminBoardException{//게시물 댓글 삭제
		return 0;
	}
	public int insertAdminBoardReply(Board board) throws AdminBoardException{//게시물 댓글 추가
		return 0;
	}
	public int updateAdminBoardReply(Board board) throws AdminBoardException{//게시물 댓글 수정
		return 0;
	}
	
	public ArrayList<Board> selectAdminBoardReplyList(String boardNo) throws AdminBoardException{//해당 게시물의 전체 댓글 조회
		return null;
	}

	
	//게시물 검색 목록
	public ArrayList<Board> searchAdminBoard(String query, int currentPage, int countList) throws AdminBoardException{
		Connection conn = getConnection();
		ArrayList<Board> list = new AdminBoardDao().searchAdminBoard(conn, query, currentPage, countList);
		close(conn);
		return list;

	}

}
