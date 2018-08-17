package adminboard.model.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import static common.jdbc.JDBCTemplate.*;
import adminboard.exception.AdminBoardException;
import common.model.vo.Board;

public class AdminBoardDao {

	//전체 목록 개수
	public int getListCount(Connection conn) throws AdminBoardException{
		int listCount = 0;
		Statement stmt = null;
		ResultSet rset = null;
		
		String query = "SELECT COUNT(*) FROM V_ADMIN_REVIEW_LIST";
		
		try {
			stmt = conn.createStatement();
			rset = stmt.executeQuery(query);
			
			if(rset.next()){
				listCount = rset.getInt(1);
			}else{
				throw new AdminBoardException("게시글이 존재하지 않습니다.");
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new AdminBoardException(e.getMessage());
		} finally {
			close(rset);
			close(stmt);
		}
		return listCount;
	}

	//전체 목록 조회
	public ArrayList<Board> selectAdminList(Connection conn) throws AdminBoardException{
		ArrayList<Board> list = new ArrayList<Board>();
		Statement stmt = null;
		ResultSet rset = null;
		
		String query = "SELECT * FROM V_ADMIN_REVIEW_LIST ORDER BY BOARD_NO DESC";
		
		try {
			stmt = conn.createStatement();
			rset = stmt.executeQuery(query);
			
			while(rset.next()){
				Board b = new Board();
				/*BOARD_NO	VARCHAR2(20)
				TITLE	VARCHAR2(50)
				CONTENTS	CLOB
				BOARD_DATE	DATE
				CATEGORY_FOOD	VARCHAR2(20)
				COMMENT_NUM	NUMBER
				RECOMMEND	NUMBER
				THUMBNAIL_NAME	VARCHAR2(30)*/
				b.setBoardNo(rset.getString("board_no"));
				b.setTitle(rset.getString("title"));
				b.setContents(rset.getString("contents"));
				b.setBoardDate(rset.getDate("board_date"));
				b.setCategoryName(rset.getString("category_food"));
				b.setCommentNum(rset.getInt("comment_num"));
				b.setRecommed(rset.getInt("recommend"));
				b.setThumbnailName(rset.getString("thumbnail_name"));
				
				list.add(b);
			}
			
			if(list.size() == 0)
				throw new AdminBoardException("게시글이 없습니다.");
		} catch (Exception e) {
			e.printStackTrace();
			throw new AdminBoardException(e.getMessage());
		} finally {
			close(rset);
			close(stmt);
		}
		return list;
	}

}
