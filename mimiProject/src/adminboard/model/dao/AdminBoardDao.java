package adminboard.model.dao;

import static common.jdbc.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

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
	public ArrayList<Board> selectAdminList(Connection conn, int currentPage, int countList) throws AdminBoardException{
		ArrayList<Board> list = new ArrayList<Board>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "SELECT * FROM (SELECT ROWNUM RNUM, BOARD_NO, TITLE, CONTENTS, BOARD_DATE, CATEGORY_NO, "
				+ "CATEGORY_FOOD, COMMENT_NUM, RECOMMEND, THUMBNAIL_NAME "
				+ "FROM (SELECT * FROM V_ADMIN_REVIEW_LIST ORDER BY BOARD_NO DESC)) "
				+ "WHERE RNUM >= ? AND RNUM <= ?";
		
		int startRow = (currentPage - 1) * countList + 1;
		int endRow = startRow + countList - 1;
	
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rset = pstmt.executeQuery();
			
			while(rset.next()){
				Board b = new Board();

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
			
//			if(list.size() == 0)
//				throw new AdminBoardException("게시글이 없습니다.");
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new AdminBoardException(e.getMessage());
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

	//카테고리 조회
	public ArrayList<Board> searchAdminBoard(Connection conn, String category, int currentPage, int countList) throws AdminBoardException{
		ArrayList<Board> list = new ArrayList<Board>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "SELECT * FROM (SELECT ROWNUM RNUM, BOARD_NO, TITLE, CONTENTS, BOARD_DATE, CATEGORY_NO, "
				+ "CATEGORY_FOOD, COMMENT_NUM, RECOMMEND, THUMBNAIL_NAME "
				+ "FROM (SELECT * FROM V_ADMIN_REVIEW_LIST WHERE CATEGORY_NO = ? ORDER BY BOARD_NO DESC)) "
				+ "WHERE RNUM >= ? AND RNUM <= ?";
		
		int startRow = (currentPage - 1) * countList + 1;
		int endRow = startRow + countList - 1;
	
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, category);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			rset = pstmt.executeQuery();
			
			while(rset.next()){
				Board b = new Board();
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
			
//			if(list.size() == 0)
//				throw new AdminBoardException("게시글이 없습니다.");
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new AdminBoardException(e.getMessage());
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

}
