package adminboard.model.dao;


import static common.jdbc.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map.Entry;

import adminboard.exception.AdminBoardException;
import common.model.vo.Board;
import userboard.exception.UserBoardException;

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
//				throw new AdminBoardException("게시글이 존재하지 않습니다.");
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
//				throw new AdminBoardException("게시글이 존재하지 않습니다.");
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new AdminBoardException(e.getMessage());
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}
	
	
	//검색한 게시물 개수
	public int getListCount(Connection conn, String qr) throws AdminBoardException{
		int listCount = 0;
		Statement stmt = null;
		ResultSet rset = null;
		
		String query = "SELECT COUNT(*) FROM V_ADMIN_REVIEW_LIST" + qr;
		
		try {
			stmt = conn.createStatement();
			rset = stmt.executeQuery(query);
			
//			System.out.println("쿼리확인1 : " + query);
			if(rset.next()){
				listCount = rset.getInt(1);
			}else{
//				throw new AdminBoardException("게시글이 존재하지 않습니다.");
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
	
	//검색한 게시물 목록
	public ArrayList<Board> searchAdminBoard(Connection conn, String qr, int currentPage,
			int countList) throws AdminBoardException{
		ArrayList<Board> list = new ArrayList<Board>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;	
		int startRow = (currentPage - 1) * countList + 1;
		int endRow = startRow + countList - 1;
		
		String query = "SELECT * FROM (SELECT ROWNUM RNUM, BOARD_NO, TITLE, CONTENTS, BOARD_DATE, CATEGORY_NO, "
					+ "CATEGORY_FOOD, COMMENT_NUM, RECOMMEND, THUMBNAIL_NAME "
					+ "FROM (SELECT * FROM V_ADMIN_REVIEW_LIST " + qr
					+ " )) WHERE RNUM >= ? AND RNUM <= ?";

//		System.out.println("쿼리 확인...2 : " + query);
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


	public int addReadCount(Connection con, String boardNo) throws AdminBoardException{
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "UPDATE TB_BOARD_REVIEW SET HITS = HITS + 1 WHERE BOARD_NO = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, boardNo);
			
			result = pstmt.executeUpdate();
			
//			if(result <= 0)
//				throw new AdminBoardException( boardNo + "번 게시글 조회수 증가 처리 실패!");
		} catch (Exception e) {
			e.printStackTrace();
			throw new AdminBoardException(e.getMessage());
		}finally{
			close(pstmt);
		}
		
		return result;
	}

	public int deleteAdminBoard(Connection con, String boardNo) throws AdminBoardException{
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "UPDATE TB_BOARD_REVIEW SET STATE = 'SD', DEL_DATE = SYSDATE WHERE BOARD_NO = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, boardNo);
			
			result = pstmt.executeUpdate();
			
//			if(result <= 0)
//				throw new AdminBoardException("게시글 삭제 실패!");
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new AdminBoardException(e.getMessage());
		}finally{
			close(pstmt);
		}
		
		return result;
	}

	public Board selectAdminBoard(Connection con, String boardNo) throws AdminBoardException{
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "SELECT * FROM V_ADMIN_REVIEW_VIEW WHERE BOARD_NO = ?";
		
		Board b = null;
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, boardNo);
			
			rset = pstmt.executeQuery();
			
			if (rset.next()) {
				b = new Board();
				
				b.setThumbnailName(rset.getString("THUMBNAIL_NAME"));
				b.setTitle(rset.getString("TITLE"));
				b.setUserId(rset.getString("USER_ID"));
				b.setNickName(rset.getString("NICKNAME"));
				b.setGradeName(rset.getString("GRADE_NAME"));
				b.setBoardDate(rset.getDate("BOARD_DATE"));
				b.setBoardNo(rset.getString("BOARD_NO"));
				b.setHits(rset.getInt("HITS"));
				b.setRecommed(rset.getInt("RECOMMEND"));
				b.setContentsTag(rset.getString("CONTENTS_TAG"));
				b.setCategoryNo(rset.getString("CATEGORY_NO"));
				b.setCategoryName(rset.getString("CATEGORY_FOOD"));
				b.setShopName(rset.getString("SHOP_NAME"));
				b.setShopCall(rset.getString("SHOP_CALL"));
				b.setShopAddress(rset.getString("SHOP_ADDRESS"));
				b.setState(rset.getString("STATE"));
				b.setLatitude(rset.getDouble("latitude"));
				b.setLongitude(rset.getDouble("longitude"));
				
//			}else {
//				throw new AdminBoardException(boardNo + "번 글 조회 실패");
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new AdminBoardException(e.getMessage());
		}finally{
			close(rset);
			close(pstmt);
		}
		return b;
	}

	public ArrayList<Board> selectList2(Connection con) throws AdminBoardException{
		ArrayList<Board> list = new ArrayList<Board>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "SELECT * FROM V_ADMIN_REVIEW_LIST";
		
		try {
			pstmt = con.prepareStatement(query);
			rset = pstmt.executeQuery();
			
			while(rset.next()){
				Board b = new Board();
				b.setBoardNo(rset.getString("BOARD_NO"));
				b.setTitle(rset.getString("TITLE"));
				b.setUserId(rset.getString("USER_ID"));
				b.setNickName(rset.getString("NICKNAME"));
				b.setBoardDate(rset.getDate("BOARD_DATE"));
				b.setHits(rset.getInt("HITS"));
				b.setRecommed(rset.getInt("RECOMMEND"));
				b.setContents(rset.getString("CONTENTS"));
				b.setCategoryName(rset.getString("CATEGORY_FOOD"));
				b.setCommentNum(rset.getInt("COMMENT_NUM"));	
				list.add(b);
//				System.out.println(list);
			}
			
//			if(list.size() == 0)
//				throw new AdminBoardException("게시글이 존재하지 않습니다.");
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new AdminBoardException(e.getMessage());
		}finally{
			close(rset);
			close(pstmt);
		}
		
		return list;
	}
	

	public int insertAdminBoard(Connection con, Board board) throws AdminBoardException{
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "INSERT INTO TB_BOARD_REVIEW (BOARD_NO, CATEGORY_NO, USER_ID, BOARD_GB, TITLE, "
				+ "CONTENTS, CONTENTS_TAG, SHOP_NAME, SHOP_ADDRESS, SHOP_CALL, LATITUDE, LONGITUDE, FILE_CNT, "
				+ "BOARD_LINK, THUMBNAIL_NAME) VALUES ('BR'||LPAD(BOARD_REVIEW_SEQ.NEXTVAL, 4, '0'), ?, ?, 'AR', ?, "
				+ "?, ?, ?, ?, ?, ?, ?, 0, '링크', ?)";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, board.getCategoryNo());
			pstmt.setString(2, board.getUserId());
			pstmt.setString(3, board.getTitle());
			pstmt.setString(4, board.getContents());
			pstmt.setString(5, board.getContentsTag());
			pstmt.setString(6, board.getShopName());
			pstmt.setString(7, board.getShopAddress());
			pstmt.setString(8, board.getShopCall());
			pstmt.setDouble(9, board.getLatitude());
			pstmt.setDouble(10, board.getLongitude());
			pstmt.setString(11, board.getThumbnailName());
			
			result = pstmt.executeUpdate();
//			if(result <= 0)
//				throw new UserBoardException("새 글 등록 실패!");			
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new AdminBoardException(e.getMessage());
		}finally{
			close(pstmt);
		}		
		
		return result;
	}

	public int updateAdminBoard(Connection con, Board board) throws AdminBoardException{
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "UPDATE TB_BOARD_REVIEW SET CATEGORY_NO = ?, TITLE = ?, CONTENTS = ?, CONTENTS_TAG = ?, BOARD_DATE = SYSDATE, "
				+ "SHOP_NAME = ?, SHOP_ADDRESS = ?, SHOP_CALL = ?, LATITUDE = ?, LONGITUDE = ?, THUMBNAIL_NAME = ? "
				+ "WHERE BOARD_NO = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, board.getCategoryNo());
			pstmt.setString(2, board.getTitle());
			pstmt.setString(3, board.getContents());
			pstmt.setString(4, board.getContentsTag());
			pstmt.setString(5, board.getShopName());
			pstmt.setString(6, board.getShopAddress());
			pstmt.setString(7, board.getShopCall());
			pstmt.setDouble(8, board.getLatitude());
			pstmt.setDouble(9, board.getLongitude());
			pstmt.setString(10, board.getThumbnailName());
			pstmt.setString(11, board.getBoardNo());
		
			result = pstmt.executeUpdate();
			
			if(result <= 0)
				throw new AdminBoardException("게시글 수정 실패!");			
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new AdminBoardException(e.getMessage());
		}finally{
			close(pstmt);
		}		
		
		return result;
	}

	public ArrayList<Board> selectAdminBoardReplyList(Connection con, String boardNo, int currentPage, int limit) throws AdminBoardException{
		ArrayList<Board> list = new ArrayList<Board>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
	
		String query = "SELECT * FROM (SELECT ROWNUM RNUM, COMMENT_NO, USER_ID, NICKNAME, GRADE_NAME, COMMENT_DATE, "
					+ "COMMENT_CONTENTS, COMMENT_STATE FROM V_ADMIN_REVIEW_COMMENT WHERE COMMENT_STATE = 'SN' "
					+ "AND BOARD_NO = ? ORDER BY COMMENT_NO ASC) WHERE RNUM >= ? AND RNUM <= ?";
		
		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, boardNo);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);

			
			rset = pstmt.executeQuery();

			while(rset.next()){
				Board b = new Board();
				b.setCommentNo(rset.getString("COMMENT_NO"));
				b.setCommentUserId(rset.getString("USER_ID"));
				b.setCommentNickName(rset.getString("NICKNAME"));
				b.setCommentGradeName(rset.getString("GRADE_NAME"));
				b.setCommentDate(rset.getDate("COMMENT_DATE"));
				b.setCommentContents(rset.getString("COMMENT_CONTENTS"));
				b.setCommentState(rset.getString("COMMENT_STATE"));
				list.add(b);
			}			
		} catch (Exception e) {
			e.printStackTrace();
			throw new AdminBoardException(e.getMessage());
		}finally{
			close(rset);
			close(pstmt);
		}
		
		return list;
	}

	public int insertAdminBoardReply(Connection con, String boardNum, Board board) throws AdminBoardException{
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "INSERT INTO TB_COMMENT_REVIEW "
						+ "(COMMENT_NO, BOARD_NO, USER_ID, COMMENT_DATE, COMMENT_CONTENTS, COMMENT_STATE, DEL_DATE) VALUES "
						+ "('CR'||LPAD(COMMENT_REVIEW_SEQ.NEXTVAL, 4, '0'), ?, ?, SYSDATE, ?, 'SN', NULL)";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, boardNum);
			pstmt.setString(2, board.getCommentUserId());
			pstmt.setString(3, board.getCommentContents());
		
			result = pstmt.executeUpdate();
			
//			if(result <= 0)
//				throw new AdminBoardException("댓글 등록 실패!");			
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new AdminBoardException(e.getMessage());
		}finally{
			close(pstmt);
		}		
		
		return result;
	}

	public int updateAdminBoardReply(Connection con, Board board) throws AdminBoardException{
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "UPDATE TB_COMMENT_REVIEW SET COMMENT_CONTENTS = ?, COMMENT_DATE = SYSDATE WHERE COMMENT_NO = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, board.getCommentContents());
			pstmt.setString(2, board.getCommentNo());
			result = pstmt.executeUpdate();
			
//			if(result <= 0)
//				throw new AdminBoardException("댓글 수정 실패!");			
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new AdminBoardException(e.getMessage());
		}finally{
			close(pstmt);
		}		
		
		return result;
	}

	public int deleteAdminBoardReply(Connection con, String commentNo) throws AdminBoardException{
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "UPDATE TB_COMMENT_REVIEW SET COMMENT_STATE = 'SD', DEL_DATE = SYSDATE WHERE COMMENT_NO = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, commentNo);
			result = pstmt.executeUpdate();
			
//			if(result <= 0)
//				throw new AdminBoardException("댓글 삭제 실패!");			
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new AdminBoardException(e.getMessage());
		}finally{
			close(pstmt);
		}		
		
		return result;
	}

	public int getListReplyCount(Connection con, String boardNo) throws AdminBoardException{
		int listCount = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "SELECT COUNT(*) FROM V_ADMIN_REVIEW_COMMENT WHERE BOARD_NO = ? AND COMMENT_STATE = 'SN'";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, boardNo);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()){
				listCount = rset.getInt(1);
//			}else{
//				throw new UserBoardException("댓글이 존재하지 않습니다.");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new AdminBoardException(e.getMessage());
		}finally{
			close(rset);
			close(pstmt);
		}
		
		return listCount;
	}


}
