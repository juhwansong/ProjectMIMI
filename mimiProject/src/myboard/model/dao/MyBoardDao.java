package myboard.model.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map.Entry;

import common.jdbc.JDBCTemplate;
import common.model.vo.Board;
import myboard.exception.MyBoardException;

public class MyBoardDao {

	public int getSearchListCount(Connection con, HashMap<String, String> keword) throws MyBoardException {
		JDBCTemplate jdbcTemplate = new JDBCTemplate();
		int searchListCount = 0;
		Statement stmt = null;
		ResultSet rset = null;
		
		StringBuffer query = new StringBuffer("select count(*) from V_ALL_BOARD where ");
		for(Entry<String, String> entry : keword.entrySet())
			query.append(entry.getKey() + " LIKE '%" + entry.getValue() + "%' AND ");
		query.delete(query.length() - 4, query.length());
			
		try {
			stmt = con.createStatement();
			rset = stmt.executeQuery(query.toString());
			
			if(rset.next()) {
				searchListCount = rset.getInt(1);
			} else {
				throw new MyBoardException("목록 검색 실패");
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new MyBoardException(e.getMessage());
		} finally {
			jdbcTemplate.close(rset);
			jdbcTemplate.close(stmt);
		}
		return searchListCount;
	}

	public int deleteMyBoard(Connection con, ArrayList<String> boardNoList) throws MyBoardException {
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
				throw new MyBoardException("게시물 삭제 실패");
		} catch (Exception e) {
			e.printStackTrace();
			throw new MyBoardException(e.getMessage());
		} finally {
			jdbcTemplate.close(stmt);
		}
		
		return result;
	}

	public ArrayList<Board> searchMyBoard(Connection con, HashMap<String, String> keword) throws MyBoardException {
		JDBCTemplate jdbcTemplate = new JDBCTemplate();
		ArrayList<Board> list = new ArrayList<Board>();
		Statement stmt = null;
		ResultSet rset = null;
		
		StringBuffer query = new StringBuffer("select * from V_ALL_BOARD where ");
		for(Entry<String, String> entry : keword.entrySet())
			query.append(entry.getKey() + " LIKE '%" + entry.getValue() + "%' AND ");
		query.delete(query.length() - 4, query.length());
			
		try {
			stmt = con.createStatement();
			rset = stmt.executeQuery(query.toString());
			
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
			
			if(list.size() == 0)
				throw new MyBoardException("전체 목록을 불러올 수 없습니다.");
		} catch (Exception e) {
			e.printStackTrace();
			throw new MyBoardException(e.getMessage());
		} finally {
			jdbcTemplate.close(rset);
			jdbcTemplate.close(stmt);
		}
		
		return list;
	}

}
