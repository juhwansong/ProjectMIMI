package bestboard.model.service;

import static common.jdbc.JDBCTemplate.close;
import static common.jdbc.JDBCTemplate.commit;
import static common.jdbc.JDBCTemplate.getConnection;
import static common.jdbc.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.ArrayList;

import bestboard.exception.BestBoardException;
import bestboard.model.dao.BestBoardDao;
import common.model.vo.Board;

public class BestBoardService {	//베스트리뷰 게시판 기능
	public BestBoardService(){}
	
	//전체 게시물 조회 시 페이지네이션 표현을 위한 총 갯수 필요// 무조건 10개라서 필요없음
	public int getListCount() throws BestBoardException{
		return 0;
	}
	
	//검색한 게시물 총 갯수(페이지네이션 관리 시 필요)
	public int getSearchListCount(String keyword) throws BestBoardException{
		Connection conn = getConnection();
		int listCount = new BestBoardDao().getSearchListCount(conn, keyword);
		close(conn);
		return listCount;
	}
		
	//전체 게시물 조회?? 첫화면 게시물...
	public ArrayList<Board> selectBestBoardList() throws BestBoardException{
		Connection conn = getConnection();
		ArrayList<Board> list = new BestBoardDao().selectBestBoardList(conn);
		close(conn);
		return list;
	}
	
	
	//키워드 검색 (페이지네이션 필요)
	public ArrayList<Board> searchBestBoard(String keyword, int currentPage, int countList) throws BestBoardException{
		Connection conn = getConnection();
		ArrayList<Board> list = new BestBoardDao().searchBestBoard(conn, keyword, currentPage, countList);
		close(conn);
		return list;
	}
	
	//연월일 검색
	public ArrayList<Board> searchMothBestBoard(String selectedMonth) throws BestBoardException{
		Connection conn = getConnection();
		ArrayList<Board> list = new BestBoardDao().searchMonthBestBoard(conn, selectedMonth);
		close(conn);
		return list;
	}	
	
	//베스트 게시판 목록에서 선택한 게시물들 삭제(관리자 기능) //삭제말고 state 변경함
	public int deleteBestBoard(String[] boardNoList) throws BestBoardException{
		Connection conn = getConnection();
		int listCount = new BestBoardDao().deleteBestBoard(conn, boardNoList);
		if(listCount > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return listCount;
	}
	

}
