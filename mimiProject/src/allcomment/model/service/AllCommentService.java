package allcomment.model.service;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;

import allcomment.exception.AllCommentException;
import allcomment.model.dao.AllCommentDao;
import common.jdbc.JDBCTemplate;
import common.model.vo.Board;

public class AllCommentService { // 관리자 기능 중 전체 댓글 조회 기능
	public AllCommentService(){}
	
	public int getListCount() throws AllCommentException{ //전체 게시물 조회 시 페이지네이션 표현을 위한 총 갯수 필요
		JDBCTemplate jdbcTemplate = new JDBCTemplate();
		Connection con = jdbcTemplate.getConnection();
		int listCount = new AllCommentDao().getListCount(con);
		jdbcTemplate.close(con);
		return listCount;
	}
	public int getSearchListCount(HashMap<String, String> keword) throws AllCommentException{//검색한 게시물 총 갯수(페이지네이션 관리 시 필요)
		JDBCTemplate jdbcTemplate = new JDBCTemplate();
		Connection con = jdbcTemplate.getConnection();
		int searchListCount = new AllCommentDao().getSearchListCount(con, keword);
		jdbcTemplate.close(con);
		return searchListCount;
	}
	public int deleteAllComment(ArrayList<String> commentNoList) throws AllCommentException{//체크박스에 체크한 게시물 삭제
		JDBCTemplate jdbcTemplate = new JDBCTemplate();
		Connection con = jdbcTemplate.getConnection();
		int result = new AllCommentDao().deleteAllComment(con, commentNoList);
		if(result > 0)
			jdbcTemplate.commit(con);
		else
			jdbcTemplate.rollback(con);
		jdbcTemplate.close(con);
		return result;
	}
	public ArrayList<Board> selectAllCommentList() throws AllCommentException{//전체 게시물 조회
		JDBCTemplate jdbcTemplate = new JDBCTemplate();
		Connection con = jdbcTemplate.getConnection();
		ArrayList<Board> list = new AllCommentDao().selectAllCommentList(con);
		jdbcTemplate.close(con);
		return list;
	}
	public ArrayList<Board> searchAllComment(HashMap<String, String> keword) throws AllCommentException{//키워드 검색에 필요한 데이터를 map에 다 넣음(key는 쿼리문,value는 ?값)
		JDBCTemplate jdbcTemplate = new JDBCTemplate();
		Connection con = jdbcTemplate.getConnection();
		ArrayList<Board> list = new AllCommentDao().searchAllBoard(con, keword);
		jdbcTemplate.close(con);
		return list;

	}
}
