package mycomment.model.service;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;

import allcomment.model.dao.AllCommentDao;
import common.jdbc.JDBCTemplate;
import common.model.vo.Board;
import mycomment.exception.MyCommentException;
import mycomment.model.dao.MyCommentDao;

public class MyCommentService {	//회원 기능 중 본인이 작성 한 댓글 조회
	public MyCommentService(){}
	
	public int getListCount() throws MyCommentException{ //전체 게시물 조회 시 페이지네이션 표현을 위한 총 갯수 필요
		return 0;
	}
	public int getSearchListCount(HashMap<String, String> keword) throws MyCommentException{//검색한 게시물 총 갯수(페이지네이션 관리 시 필요)
		JDBCTemplate jdbcTemplate = new JDBCTemplate();
		Connection con = jdbcTemplate.getConnection();
		int searchListCount = new MyCommentDao().getSearchListCount(con, keword);
		jdbcTemplate.close(con);
		return searchListCount;
	}
	public int deleteMyComment(ArrayList<String> commentNoList) throws MyCommentException{//체크박스에 체크한 게시물 삭제
		JDBCTemplate jdbcTemplate = new JDBCTemplate();
		Connection con = jdbcTemplate.getConnection();
		int result = new MyCommentDao().deleteMyComment(con, commentNoList);
		if(result > 0)
			jdbcTemplate.commit(con);
		else
			jdbcTemplate.rollback(con);
		jdbcTemplate.close(con);
		return result;
	}
	public ArrayList<Board> selectMyCommentList() throws MyCommentException{//전체 게시물 조회
		return null;
	}
	public ArrayList<Board> searchMyComment(HashMap<String, String> keword) throws MyCommentException{//키워드 검색에 필요한 데이터를 map에 다 넣음(key는 쿼리문,value는 ?값)
		JDBCTemplate jdbcTemplate = new JDBCTemplate();
		Connection con = jdbcTemplate.getConnection();
		ArrayList<Board> list = new MyCommentDao().searchMyComment(con, keword);
		jdbcTemplate.close(con);
		return list;
	}
	
}
