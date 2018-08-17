package bookmark.model.dao;

import static common.jdbc.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import bookmark.exception.BookmarkException;
import common.model.vo.Board;

public class BookmarkDao {

	//즐겨찾기 리스트 개수
	public int getListCount(Connection conn, String userId) throws BookmarkException{
		int listCount = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "SELECT COUNT(*) FROM V_BOOKMARK WHERE BOOKMARK_USER_ID = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userId);
			rset = pstmt.executeQuery();
			
			if(rset.next()){
				listCount = rset.getInt(1);
			}else{
				//즐겨찾기 추가한 게시물이 없을때
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new BookmarkException(e.getMessage());
		} finally {
			close(rset);
			close(pstmt);
		}
	
		return listCount;
	}

	//즐겨찾기 목록
	public ArrayList<Board> selectBookmarkList(Connection conn, String userId, int currentPage, int countList) throws BookmarkException {
		ArrayList<Board> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "SELECT * FROM (SELECT ROWNUM RNUM, BOARD_NO, NICKNAME, BOOKMARK_DATE, COMMENT_NUM, "
				+ "TITLE, BOARD_DATE, BOARD_GB, BOARD_LINK, THUMBNAIL_NAME "
				+ "FROM (SELECT * FROM V_BOOKMARK "
				+ "WHERE BOOKMARK_USER_ID = ? ORDER BY BOOKMARK_DATE DESC)) "
				+ "WHERE RNUM >= ? AND RNUM <= ?";
		
		int startRow = (currentPage - 1) * countList + 1;
		int endRow = startRow + countList - 1;	
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userId);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			rset = pstmt.executeQuery();
			
			while(rset.next()){
				Board b = new Board();
				
				b.setBoardNo(rset.getString("board_no"));
				b.setNickName(rset.getString("nickname"));
				b.setTitle(rset.getString("title"));
				b.setBoardDate(rset.getDate("board_date"));
				b.setCommentNum(rset.getInt("comment_num"));
				b.setBoardGb(rset.getString("board_gb"));
				b.setBoardLink(rset.getString("board_link"));
				b.setThumbnailName(rset.getString("thumbnail_name"));
				
				list.add(b);
			}
			
			//if(list.size() == 0)
				//즐겨찾기 없을때
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new BookmarkException(e.getMessage());
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return list;
	}

	//즐겨찾기 검색
	public ArrayList<Board> searchBookmark(Connection conn, String userId, String board_gb, String keyword, int currentPage, int countList) throws BookmarkException {
		ArrayList<Board> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "SELECT * FROM (SELECT ROWNUM RNUM, BOARD_NO, NICKNAME, BOOKMARK_DATE, COMMENT_NUM, "
				+ "TITLE, BOARD_DATE, BOARD_GB, BOARD_LINK, THUMBNAIL_NAME, CONTENTS, SHOP_NAME, SHOP_ADDRESS "
				+ "FROM (SELECT * FROM V_BOOKMARK "
				+ "WHERE BOOKMARK_USER_ID = ?  AND BOARD_GB " + board_gb
				+ " AND ( TITLE LIKE ? OR CONTENTS LIKE ? OR SHOP_NAME LIKE ? OR SHOP_ADDRESS LIKE ? ) "
				+ "ORDER BY BOOKMARK_DATE DESC)) "
				+ "WHERE RNUM >= ? AND RNUM <= ?";	
		
		int startRow = (currentPage - 1) * countList + 1;
		int endRow = startRow + countList - 1;	

		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userId);
			//pstmt.setString(2, board_gb); //안 먹힘
			pstmt.setString(2, "%" + keyword + "%");
			pstmt.setString(3, "%" + keyword + "%");
			pstmt.setString(4, "%" + keyword + "%");
			pstmt.setString(5, "%" + keyword + "%");
			pstmt.setInt(6, startRow);
			pstmt.setInt(7, endRow);	
			rset = pstmt.executeQuery();
			
			while(rset.next()){
				Board b = new Board();				
				
				b.setBoardGb(rset.getString("board_gb"));
				b.setBoardNo(rset.getString("board_no"));
				b.setNickName(rset.getString("nickname"));
				b.setBoardDate(rset.getDate("board_date"));
				b.setTitle(rset.getString("title"));
				b.setCommentNum(rset.getInt("comment_num"));
				b.setBoardLink(rset.getString("board_link"));
				b.setThumbnailName(rset.getString("thumbnail_name"));
				
				list.add(b);				
			}
			
			//if(list.size() == 0) //검색결과 없을때
				//throw new BookmarkException("즐겨찾기한 게시물이 없습니다.");
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new BookmarkException(e.getMessage());
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}
	
	//즐겨찾기 삭제
	public int deleteBookmark(Connection conn, String userId, String[] checkedNo) throws BookmarkException{
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "DELETE FROM TB_BOOKMARK WHERE BOOKMARK_USER_ID = ? AND BOARD_NO = ?";
		
		try {
			for(String checkOne : checkedNo){
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, userId);
				pstmt.setString(2, checkOne);
				result = pstmt.executeUpdate();
			}
			if(result <= 0)
				throw new BookmarkException("즐겨찾게 삭제 실패...");
		} catch (Exception e) {
			e.printStackTrace();
			throw new BookmarkException(e.getMessage());
		} finally {
			close(pstmt);
		}
		return result;
	}
	
	

	//즐겨찾기 검색한 개시물 개수
//	public int getSearchListCount(Connection conn, String userId, String board_gb, String keyword) throws BookmarkException{
//		int listCount = 0;
//		PreparedStatement pstmt = null;
//		ResultSet rset = null;
//		String query = "SELECT COUNT(*) FROM V_BOOKMARK WHERE BOOKMARK_USER_ID = ? AND BOARD_GB " + board_gb
//				+ " AND ( TITLE LIKE ? OR CONTENTS LIKE ? OR SHOP_NAME LIKE ? OR SHOP_ADDRESS LIKE ? )";
//		
//		try {
//			pstmt = conn.prepareStatement(query);
//			pstmt.setString(1, userId);
//			pstmt.setString(2, "%" + keyword + "%");
//			pstmt.setString(3, "%" + keyword + "%");
//			pstmt.setString(4, "%" + keyword + "%");
//			pstmt.setString(5, "%" + keyword + "%");
//			rset = pstmt.executeQuery();
//			
//			if(rset.next()){
//				listCount = rset.getInt(1);
//			}else{
//				//게시물이 없을때
//			}
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//			throw new BookmarkException(e.getMessage());
//		} finally {
//			close(rset);
//			close(pstmt);
//		}
//	
//		return listCount;
//	}

	

}
