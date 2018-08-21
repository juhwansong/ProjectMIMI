package allcomment.model.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map.Entry;

import allboard.exception.AllBoardException;
import allcomment.exception.AllCommentException;
import common.jdbc.JDBCTemplate;
import common.model.vo.Board;

public class AllCommentDao {

	public int getListCount(Connection con) throws AllCommentException {
		JDBCTemplate jdbcTemplate = new JDBCTemplate();
		int listCount = 0;
		Statement stmt = null;
		ResultSet rset = null;
		
		String query = "select count(*) from V_ALL_COMMENT";
		
		try {
			stmt = con.createStatement();
			rset = stmt.executeQuery(query);
			
			if(rset.next()) {
				listCount = rset.getInt(1);
			} else {
				throw new AllCommentException("목록이 존재하지 않습니다.");
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new AllCommentException(e.getMessage());
		} finally {
			jdbcTemplate.close(rset);
			jdbcTemplate.close(stmt);
		}
		
		return listCount;
	}

	public int getSearchListCount(Connection con, HashMap<String, String> keword) throws AllCommentException {
		JDBCTemplate jdbcTemplate = new JDBCTemplate();
		int searchListCount = 0;
		Statement stmt = null;
		ResultSet rset = null;
		
		String query = "";
		for(Entry<String, String> entry : keword.entrySet())
			query = "select count(*) from V_ALL_COMMENT where " + entry.getKey() + " LIKE '%" + entry.getValue() + "%'";
		
		try {
			stmt = con.createStatement();
			rset = stmt.executeQuery(query);
			
			if(rset.next()) {
				searchListCount = rset.getInt(1);
			} else {
				throw new AllCommentException("목록 검색 실패");
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new AllCommentException(e.getMessage());
		} finally {
			jdbcTemplate.close(rset);
			jdbcTemplate.close(stmt);
		}
		return searchListCount;
	}

	public int deleteAllComment(Connection con, ArrayList<String> commentNoList) throws AllCommentException {
		JDBCTemplate jdbcTemplate = new JDBCTemplate();
		int result = 0;
		Statement stmt = null;
		
		StringBuffer noStrList = new StringBuffer("(");
		for(String cNo : commentNoList)
			noStrList.append("'" + cNo + "'"+ ", ");
		noStrList.append(")").delete(noStrList.length() - 3, noStrList.length() - 2);
		
		String query = "delete from V_ALL_COMMENT where rowid in " + noStrList;
		
		try {
			stmt = con.createStatement();
			result = stmt.executeUpdate(query);
			
			if(result <= 0)
				throw new AllCommentException("게시물 삭제 실패");
		} catch (Exception e) {
			e.printStackTrace();
			throw new AllCommentException(e.getMessage());
		} finally {
			jdbcTemplate.close(stmt);
		}
		
		return result;
	}

	public ArrayList<Board> selectAllCommentList(Connection con) throws AllCommentException {
		JDBCTemplate jdbcTemplate = new JDBCTemplate();
		ArrayList<Board> list = new ArrayList<Board>();
		Statement stmt = null;
		ResultSet rset = null;
		
		String query = "select board_no, nickname, comment_contents, comment_date, title, "
				+ "board_link, comment_state, user_id, rowid from V_ALL_COMMENT";
		
		try {
			stmt = con.createStatement();
			rset = stmt.executeQuery(query);
			
			while(rset.next()) {
				Board b = new Board();
				
				b.setBoardNo(rset.getString("board_no"));
				b.setNickName(rset.getString("nickname"));
				b.setCommentContents(rset.getString("comment_contents"));
				b.setCommentDate(rset.getDate("comment_date"));
				b.setTitle(rset.getString("title"));
				b.setBoardLink(rset.getString("board_link"));
				b.setCommentState(rset.getString("comment_state"));
				b.setUserId(rset.getString("user_id"));
				// 뷰에 표현되는 정보만으로는 선택된 항목을 구분할 방법이 없어서
				// 사용하지 않는 객체에 rowid 를 실어서 보냄
				b.setBoardLink(rset.getString("rowid"));
				
				list.add(b);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new AllCommentException(e.getMessage());
		} finally {
			jdbcTemplate.close(rset);
			jdbcTemplate.close(stmt);
		}
		
		return list;
	}

	public ArrayList<Board> searchAllBoard(Connection con, HashMap<String, String> keword) throws AllCommentException {
		JDBCTemplate jdbcTemplate = new JDBCTemplate();
		ArrayList<Board> list = new ArrayList<Board>();
		Statement stmt = null;
		ResultSet rset = null;
		
		String query = "";
		for(Entry<String, String> entry : keword.entrySet()) {
			query = "select board_no, nickname, comment_contents, comment_date, title, "
				+ "board_link, comment_state, user_id, rowid from V_ALL_COMMENT where "
				+ entry.getKey() + " LIKE '%" + entry.getValue() + "%'";
		}
				
		try {
			stmt = con.createStatement();
			rset = stmt.executeQuery(query);
			
			while(rset.next()) {
				Board b = new Board();
				
				b.setBoardNo(rset.getString("board_no"));
				b.setNickName(rset.getString("nickname"));
				b.setCommentContents(rset.getString("comment_contents"));
				b.setCommentDate(rset.getDate("comment_date"));
				b.setTitle(rset.getString("title"));
				b.setBoardLink(rset.getString("board_link"));
				b.setCommentState(rset.getString("comment_state"));
				b.setUserId(rset.getString("user_id"));
				// 뷰에 표현되는 정보만으로는 선택된 항목을 구분할 방법이 없어서
				// 사용하지 않는 객체에 rowid 를 실어서 보냄
				b.setBoardLink(rset.getString("rowid"));
				
				list.add(b);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new AllCommentException(e.getMessage());
		} finally {
			jdbcTemplate.close(rset);
			jdbcTemplate.close(stmt);
		}
		
		return list;
	}

}
