package allboard.model.dao;


import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map.Entry;

import allboard.exception.AllBoardException;
import common.jdbc.JDBCTemplate;
import common.model.vo.Board;

public class AllBoardDao {

	public int getListCount(Connection con) throws AllBoardException {
		JDBCTemplate jdbcTemplate = new JDBCTemplate();
		int listCount = 0;
		Statement stmt = null;
		ResultSet rset = null;
		
		String query = "select count(*) from V_ALL_BOARD";
		
		try {
			stmt = con.createStatement();
			rset = stmt.executeQuery(query);
			
			if(rset.next()) {
				listCount = rset.getInt(1);
			} else {
				throw new AllBoardException("목록이 존재하지 않습니다.");
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new AllBoardException(e.getMessage());
		} finally {
			jdbcTemplate.close(rset);
			jdbcTemplate.close(stmt);
		}
		
		return listCount;
	}

	public int getSearchListCount(Connection con, HashMap<String, String> keword) throws AllBoardException {
		JDBCTemplate jdbcTemplate = new JDBCTemplate();
		int searchListCount = 0;
		Statement stmt = null;
		ResultSet rset = null;
		
		String query = "";
		for(Entry<String, String> entry : keword.entrySet())
			query = "select count(*) from V_ALL_BOARD where " + entry.getKey() + " LIKE '%" + entry.getValue() + "%'";
		
		try {
			stmt = con.createStatement();
			rset = stmt.executeQuery(query);
			
			if(rset.next()) {
				searchListCount = rset.getInt(1);
			} else {
				throw new AllBoardException("목록 검색 실패");
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new AllBoardException(e.getMessage());
		} finally {
			jdbcTemplate.close(rset);
			jdbcTemplate.close(stmt);
		}
		return searchListCount;
	}
	
	public int deleteAllBoard(Connection con, ArrayList<String> boardNoList) throws AllBoardException {
		JDBCTemplate jdbcTemplate = new JDBCTemplate();
		int result = 0;
		Statement stmt = null;
		
		StringBuffer noStrList = new StringBuffer("(");
		for(String bNo : boardNoList)
			noStrList.append("'" + bNo + "'"+ ", ");
		noStrList.append(")").delete(noStrList.length() - 3, noStrList.length() - 2);
		
		String query = "delete from V_ALL_BOARD where board_no in " + noStrList;
		
		try {
			stmt = con.createStatement();
			result = stmt.executeUpdate(query);
			
			if(result <= 0)
				throw new AllBoardException("게시물 삭제 실패");
		} catch (Exception e) {
			e.printStackTrace();
			throw new AllBoardException(e.getMessage());
		} finally {
			jdbcTemplate.close(stmt);
		}
		
		return result;
	}

	public ArrayList<Board> selectAllBoardList(Connection con) throws AllBoardException {
		JDBCTemplate jdbcTemplate = new JDBCTemplate();
		ArrayList<Board> list = new ArrayList<Board>();
		Statement stmt = null;
		ResultSet rset = null;
		
		String query = "select * from V_ALL_BOARD";
		
		try {
			stmt = con.createStatement();
			rset = stmt.executeQuery(query);
			
			while(rset.next()) {
				Board b = new Board();
				
				b.setBoardNo(rset.getString("board_no"));
				b.setBoardGb(rset.getString("board_gb"));
				b.setTitle(rset.getString("title"));
				b.setNickName(rset.getString("nickname"));
				b.setBoardDate(rset.getDate("board_date"));
				b.setHits(rset.getInt("hits"));
				b.setRecommed(rset.getInt("recommend"));
				b.setBoardLink(rset.getString("board_link"));
				b.setUserId(rset.getString("user_id"));
				b.setState(rset.getString("state"));
				
				list.add(b);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new AllBoardException(e.getMessage());
		} finally {
			jdbcTemplate.close(rset);
			jdbcTemplate.close(stmt);
		}
		
		return list;
	}

	public ArrayList<Board> searchAllBoard(Connection con, HashMap<String, String> keword) throws AllBoardException {
		JDBCTemplate jdbcTemplate = new JDBCTemplate();
		ArrayList<Board> list = new ArrayList<Board>();
		Statement stmt = null;
		ResultSet rset = null;
		
		String query = "";
		for(Entry<String, String> entry : keword.entrySet()) {
			query = "select * from V_ALL_BOARD where " + entry.getKey() + " LIKE '%" + entry.getValue() + "%'";
		}
				
		try {
			stmt = con.createStatement();
			rset = stmt.executeQuery(query);
			
			while(rset.next()) {
				Board b = new Board();
				
				b.setBoardNo(rset.getString("board_no"));
				b.setBoardGb(rset.getString("board_gb"));
				b.setTitle(rset.getString("title"));
				b.setNickName(rset.getString("nickname"));
				b.setBoardDate(rset.getDate("board_date"));
				b.setHits(rset.getInt("hits"));
				b.setRecommed(rset.getInt("recommend"));
				b.setBoardLink(rset.getString("board_link"));
				b.setUserId(rset.getString("user_id"));
				b.setState(rset.getString("state"));
				
				list.add(b);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new AllBoardException(e.getMessage());
		} finally {
			jdbcTemplate.close(rset);
			jdbcTemplate.close(stmt);
		}
		
		return list;
	}

}
