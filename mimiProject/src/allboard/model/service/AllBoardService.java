package allboard.model.service;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;

import allboard.exception.AllBoardException;
import allboard.model.dao.AllBoardDao;
import common.jdbc.JDBCTemplate;
import common.model.vo.Board;

public class AllBoardService {	//관리자 기능 중 전체 게시물 조회 기능
	public AllBoardService(){}
	
	public int getListCount() throws AllBoardException{ //전체 게시물 조회 시 페이지네이션 표현을 위한 총 갯수 필요
		JDBCTemplate jdbcTemplate = new JDBCTemplate();
		Connection con = jdbcTemplate.getConnection();
		int listCount = new AllBoardDao().getListCount(con);
		jdbcTemplate.close(con);
		return listCount;
	}
	public int getSearchListCount(HashMap<String, String> keword) throws AllBoardException{ //검색한 게시물 총 갯수(페이지네이션 관리 시 필요)
		JDBCTemplate jdbcTemplate = new JDBCTemplate();
		Connection con = jdbcTemplate.getConnection();
		int searchListCount = new AllBoardDao().getSearchListCount(con, keword);
		jdbcTemplate.close(con);
		return searchListCount;
	}
	public int deleteAllBoard(ArrayList<String> boardNoList) throws AllBoardException{ //체크박스에 체크한 게시물 삭제
		JDBCTemplate jdbcTemplate = new JDBCTemplate();
		Connection con = jdbcTemplate.getConnection();
		int result = new AllBoardDao().deleteAllBoard(con, boardNoList);
		if(result > 0)
			jdbcTemplate.commit(con);
		else
			jdbcTemplate.rollback(con);
		jdbcTemplate.close(con);
		return result;
	}
	public ArrayList<Board> selectAllBoardList() throws AllBoardException{ //전체 게시물 조회
		JDBCTemplate jdbcTemplate = new JDBCTemplate();
		Connection con = jdbcTemplate.getConnection();
		ArrayList<Board> list = new AllBoardDao().selectAllBoardList(con);
		jdbcTemplate.close(con);
		return list;
	}
	public ArrayList<Board> searchAllBoard(HashMap<String, String> keword) throws AllBoardException{//키워드 검색에 필요한 데이터를 map에 다 넣음(key는 쿼리문,value는 ?값)
		JDBCTemplate jdbcTemplate = new JDBCTemplate();
		Connection con = jdbcTemplate.getConnection();
		ArrayList<Board> list = new AllBoardDao().searchAllBoard(con, keword);
		jdbcTemplate.close(con);
		return list;
	}

}
