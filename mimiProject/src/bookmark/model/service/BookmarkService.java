package bookmark.model.service;

import java.sql.Connection;

import java.util.ArrayList;
import java.util.HashMap;
import static common.jdbc.JDBCTemplate.*;
import bookmark.exception.BookmarkException;
import bookmark.model.dao.BookmarkDao;
import common.model.vo.Board;

public class BookmarkService {	//즐겨찾기 기능
	public BookmarkService(){}
	
	//userId가 즐겨찾기한 게시글 개수
	public int getListCount(String userId) throws BookmarkException{//전체 게시물 조회 시 페이지네이션 표현을 위한 총 갯수 필요
		Connection conn = getConnection();
		int listCount = new BookmarkDao().getListCount(conn, userId);
		close(conn);
		return listCount;
	}
	
	
	//검색한 게시물 총 갯수(페이지네이션 관리 시 필요)
	public int getSearchListCount(String userId, String board_gb, String keyword) throws BookmarkException{
		Connection conn = getConnection();
		int listCount = new BookmarkDao().getSearchListCount(conn, userId, board_gb, keyword);
		close(conn);
		return listCount;
	}
	
	
	//전체 게시물 조회
	public ArrayList<Board> selectBookmarkList(String userId, int currentPage, int countList) throws BookmarkException{//전체 게시물 조회
		Connection conn = getConnection();
		ArrayList<Board> list = new BookmarkDao().selectBookmarkList(conn, userId, currentPage, countList);
		close(conn);
		return list;
	}
	
	//즐겨찾기 검색
	public ArrayList<Board> searchBookmark(String userId, String board_gb, String keyword, int currentPage, int countList) throws BookmarkException{
		Connection conn = getConnection();
		ArrayList<Board> list = new BookmarkDao().searchBookmark(conn, userId, board_gb, keyword, currentPage, countList);
		close(conn);
		return list;
	}

	//즐겨찾기 삭제
	public int deleteBookmark(String userId, String[] boardNo) throws BookmarkException {
		Connection conn = getConnection();
		int result = new BookmarkDao().deleteBookmark(conn, userId, boardNo);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;
	}
	
	//즐겨찾기 추가
	public int insertBookmark(String userId, String boardNo) throws BookmarkException {
		Connection conn = getConnection();
		int result = new BookmarkDao().insertBookmark(conn, userId, boardNo);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;
	}

}
