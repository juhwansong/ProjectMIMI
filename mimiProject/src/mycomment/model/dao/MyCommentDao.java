package mycomment.model.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map.Entry;

import allcomment.exception.AllCommentException;
import common.jdbc.JDBCTemplate;
import common.model.vo.Board;
import mycomment.exception.MyCommentException;

public class MyCommentDao {

	public int getSearchListCount(Connection con, HashMap<String, String> keword) throws MyCommentException {
		JDBCTemplate jdbcTemplate = new JDBCTemplate();
		int searchListCount = 0;
		Statement stmt = null;
		ResultSet rset = null;
		
		StringBuffer query = new StringBuffer("select count(*) from V_ALL_COMMENT where ");
		for(Entry<String, String> entry : keword.entrySet())
			query.append(entry.getKey() + " LIKE '%" + entry.getValue() + "%' AND ");
		query.delete(query.length() - 4, query.length());
		
		try {
			stmt = con.createStatement();
			rset = stmt.executeQuery(query.toString());
			
			if(rset.next()) {
				searchListCount = rset.getInt(1);
			} else {
				throw new MyCommentException("목록 검색 실패");
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new MyCommentException(e.getMessage());
		} finally {
			jdbcTemplate.close(rset);
			jdbcTemplate.close(stmt);
		}
		return searchListCount;
	}

	public int deleteMyComment(Connection con, ArrayList<String> commentNoList) throws MyCommentException {
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
				throw new MyCommentException("게시물 삭제 실패");
		} catch (Exception e) {
			e.printStackTrace();
			throw new MyCommentException(e.getMessage());
		} finally {
			jdbcTemplate.close(stmt);
		}
		
		return result;
	}

	public ArrayList<Board> searchMyComment(Connection con, HashMap<String, String> keword) throws MyCommentException {
		JDBCTemplate jdbcTemplate = new JDBCTemplate();
		ArrayList<Board> list = new ArrayList<Board>();
		Statement stmt = null;
		ResultSet rset = null;
		
		StringBuffer query = new StringBuffer("select board_no, nickname, comment_contents, comment_date, title, ");
		query.append("board_link, comment_state, user_id, rowid from V_ALL_COMMENT where ");
		for(Entry<String, String> entry : keword.entrySet())
			query.append(entry.getKey() + " LIKE '%" + entry.getValue() + "%' AND ");
		query.delete(query.length() - 4, query.length());
				
		try {
			stmt = con.createStatement();
			rset = stmt.executeQuery(query.toString());
			
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
			
			if(list.size() == 0)
				throw new MyCommentException("전체 목록을 불러올 수 없습니다.");
		} catch (Exception e) {
			e.printStackTrace();
			throw new MyCommentException(e.getMessage());
		} finally {
			jdbcTemplate.close(rset);
			jdbcTemplate.close(stmt);
		}
		
		return list;
	}
	
}
