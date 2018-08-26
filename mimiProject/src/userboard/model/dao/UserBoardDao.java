package userboard.model.dao;

import static common.jdbc.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import common.model.vo.Board;
import userboard.exception.UserBoardException;

public class UserBoardDao {
	public UserBoardDao(){}
	
	public int getListCount(Connection con) throws UserBoardException{
		int listCount = 0;
		Statement stmt = null;
		ResultSet rset = null;
		
		String query = "select count(*) from V_USER_REVIEW_LIST";
		
		try {
			stmt = con.createStatement();
			rset = stmt.executeQuery(query);
			
			if(rset.next()){
				listCount = rset.getInt(1);
			}else{
				throw new UserBoardException("게시글이 존재하지 않습니다.");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new UserBoardException(e.getMessage());
		}finally{
			close(rset);
			close(stmt);
		}
		
		return listCount;
	}
	
	public ArrayList<Board> selectList(
			Connection con, int currentPage, 
			int limit) throws UserBoardException {
		ArrayList<Board> list = new ArrayList<Board>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from ( "
				+ "select rownum rnum, "
				+ "BOARD_NO, TITLE, USER_ID, NICKNAME, "
				+ "BOARD_DATE, HITS, RECOMMEND, CONTENTS, "
				+ "CATEGORY_FOOD, COMMENT_NUM, THUMBNAIL_NAME "
				+ "from V_USER_REVIEW_LIST) "
				+ "where rnum >= ? and rnum <= ?";

		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			
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
				b.setThumbnailName(rset.getString("THUMBNAIL_NAME"));	

				list.add(b);

			}
			
			if(list.size() == 0)
				throw new UserBoardException(
						"게시글이 존재하지 않습니다.");
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new UserBoardException(e.getMessage());
		}finally{
			close(rset);
			close(pstmt);
		}
		
		return list;
	}
		
	public int addReadCount(Connection con, 
			String boardNum) throws UserBoardException {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "update TB_BOARD_REVIEW "
							+ "set HITS=HITS+1 "
							+ "where BOARD_NO=?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, boardNum);
			
			result = pstmt.executeUpdate();
			
			if(result <= 0)
				throw new UserBoardException(
						boardNum + "번 게시글 조회수 증가 처리 실패!");
		} catch (Exception e) {
			e.printStackTrace();
			throw new UserBoardException(e.getMessage());
		}finally{
			close(pstmt);
		}
		
		return result;
	}

	public Board selectUserBoard(Connection con, String boardNo) throws UserBoardException {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "SELECT * "
				+ "FROM V_USER_REVIEW_VIEW "
				+ "where BOARD_NO=?";
		
		Board urboard = null;
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, boardNo);
			
			rset = pstmt.executeQuery();
			
			if (rset.next()) {
				urboard = new Board();
				
				urboard.setThumbnailName(rset.getString("THUMBNAIL_NAME"));
				urboard.setTitle(rset.getString("TITLE"));
				urboard.setUserId(rset.getString("USER_ID"));
				urboard.setNickName(rset.getString("NICKNAME"));
				urboard.setGradeName(rset.getString("GRADE_NAME"));
				urboard.setBoardDate(rset.getDate("BOARD_DATE"));
				urboard.setBoardNo(rset.getString("BOARD_NO"));
				urboard.setHits(rset.getInt("HITS"));
				urboard.setRecommed(rset.getInt("RECOMMEND"));
				urboard.setContentsTag(rset.getString("CONTENTS_TAG"));
				urboard.setCategoryNo(rset.getString("CATEGORY_NO"));
				urboard.setCategoryName(rset.getString("CATEGORY_FOOD"));
				urboard.setShopName(rset.getString("SHOP_NAME"));
				urboard.setShopCall(rset.getString("SHOP_CALL"));
				urboard.setShopAddress(rset.getString("SHOP_ADDRESS"));
				urboard.setState(rset.getString("STATE"));
				urboard.setLatitude(rset.getDouble("latitude"));
				urboard.setLongitude(rset.getDouble("longitude"));
				
			}else {
				throw new UserBoardException(boardNo + "번 글 조회 실패");
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new UserBoardException(e.getMessage());
		}finally{
			close(rset);
			close(pstmt);
		}
		return urboard;
	}

	public int insertUserBoard(Connection con, Board board) throws UserBoardException {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "INSERT INTO TB_BOARD_REVIEW "
				+ "(BOARD_NO, CATEGORY_NO, USER_ID, BOARD_GB, TITLE, "
				+ "CONTENTS, CONTENTS_TAG, SHOP_NAME, SHOP_ADDRESS, SHOP_CALL, "
				+ "LATITUDE, LONGITUDE, FILE_CNT, BOARD_LINK, THUMBNAIL_NAME) "
				+ "VALUES ('BR'||LPAD(BOARD_REVIEW_SEQ.NEXTVAL, 4, '0'), ?, ?, 'UR', ?, "
				+ "?, ?, ?, ?, ?, "
				+ "?, ?, 0, '링크', ?)";
		
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
			if(result <= 0)
				throw new UserBoardException("새 원글 등록 실패!");			
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new UserBoardException(e.getMessage());
		}finally{
			close(pstmt);
		}		
		
		return result;
	}
	
	public int updateBoard(Connection con, Board board) throws UserBoardException{
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "update TB_BOARD_REVIEW set "
						+ "CATEGORY_NO = ?, TITLE = ?, CONTENTS = ?, CONTENTS_TAG = ?, BOARD_DATE = SYSDATE, "
						+ "SHOP_NAME = ?, SHOP_ADDRESS = ?, SHOP_CALL = ?, LATITUDE = ?, LONGITUDE = ?, "
						+ "THUMBNAIL_NAME = ? "
						+ "where BOARD_NO = ?";
		
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
				throw new UserBoardException("원글 수정 실패!");			
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new UserBoardException(e.getMessage());
		}finally{
			close(pstmt);
		}		
		
		return result;
	}
	
	public int deleteUserBoard(Connection con, String boardNo) throws UserBoardException {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "update TB_BOARD_REVIEW set "
						+ "STATE = 'SD', DEL_DATE = SYSDATE "
						+ "where BOARD_NO = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, boardNo);
			
			result = pstmt.executeUpdate();
			
			if(result <= 0)
				throw new UserBoardException("게시글 삭제 실패!");
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new UserBoardException(e.getMessage());
		}finally{
			close(pstmt);
		}
		
		return result;
	}


	public int insertReply(Connection con, String boardNum, Board board) throws UserBoardException {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "INSERT INTO TB_COMMENT_REVIEW "
						+ "(COMMENT_NO, BOARD_NO, USER_ID, COMMENT_DATE, COMMENT_CONTENTS, "
						+ "COMMENT_STATE, DEL_DATE) VALUES "
						+ "('CR'||LPAD(COMMENT_REVIEW_SEQ.NEXTVAL, 4, '0'), ?, ?, SYSDATE, ?, "
						+ "'SN', NULL)";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, boardNum);
			pstmt.setString(2, board.getCommentUserId());
			pstmt.setString(3, board.getCommentContents());
		
			result = pstmt.executeUpdate();
			
			if(result <= 0)
				throw new UserBoardException("새 댓글 등록 실패!");			
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new UserBoardException(e.getMessage());
		}finally{
			close(pstmt);
		}		
		
		return result;
	}
	
	public int updateReply(Connection con, Board board) throws UserBoardException {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "update TB_COMMENT_REVIEW set "
							+ "COMMENT_CONTENTS = ?, COMMENT_DATE = SYSDATE "
							+ "where COMMENT_NO = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, board.getCommentContents());
			pstmt.setString(2, board.getCommentNo());
			result = pstmt.executeUpdate();
			
			if(result <= 0)
				throw new UserBoardException("댓글 수정 실패!");			
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new UserBoardException(e.getMessage());
		}finally{
			close(pstmt);
		}		
		
		return result;
	}
	
	public int deleteReply(Connection con, String commentNo) throws UserBoardException {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "update TB_COMMENT_REVIEW set "
							+ "COMMENT_STATE = 'SD', DEL_DATE = SYSDATE "
							+ "where COMMENT_NO = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, commentNo);
			result = pstmt.executeUpdate();
			
			if(result <= 0)
				throw new UserBoardException("댓글 삭제 실패!");			
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new UserBoardException(e.getMessage());
		}finally{
			close(pstmt);
		}		
		
		return result;
	}
	
	public int getListReplyCount(Connection con, String boardNo) throws UserBoardException {
		int listCount = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select count(*) from V_USER_REVIEW_COMMENT "
				+ "where BOARD_NO = ? and COMMENT_STATE = 'SN'";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, boardNo);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()){
				listCount = rset.getInt(1);
			}else{
				throw new UserBoardException("댓글이 존재하지 않습니다.");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new UserBoardException(e.getMessage());
		}finally{
			close(rset);
			close(pstmt);
		}
		
		return listCount;
	}
	
	public ArrayList<Board> selectReplyList(Connection con, String boardNum, int currentPage, int limit) throws UserBoardException {
		ArrayList<Board> list = new ArrayList<Board>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from ( "
				+ "select rownum rnum, "
				+ "COMMENT_NO, USER_ID, NICKNAME, GRADE_NAME, COMMENT_DATE, "
				+ "COMMENT_CONTENTS, COMMENT_STATE "
				+ "from V_USER_REVIEW_COMMENT "
				+ "where COMMENT_STATE='SN' "
				+ "and BOARD_NO = ? "
				+ "order by COMMENT_NO asc) "
				+ "where rnum >= ? and rnum <= ?";
		
		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, boardNum);
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
			throw new UserBoardException(e.getMessage());
		}finally{
			close(rset);
			close(pstmt);
		}
		
		return list;
	}
	

	
	
///////////////////////////////////////////////////////////////////////////////////////////////////////	
	//검색한 게시물 개수
	public int getListCount(Connection conn, String qr) throws UserBoardException{
		int listCount = 0;
		Statement stmt = null;
		ResultSet rset = null;
		
		String query = "SELECT COUNT(*) FROM V_USER_REVIEW_LIST" + qr;
		
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
			throw new UserBoardException(e.getMessage());
		} finally {
			close(rset);
			close(stmt);
		}
		return listCount;
	}
	
	
	
	//검색한 게시물 목록
	public ArrayList<Board> searchUserBoard(Connection conn, String qr, int currentPage,
			int countList) throws UserBoardException{
		ArrayList<Board> list = new ArrayList<Board>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;	
		int startRow = (currentPage - 1) * countList + 1;
		int endRow = startRow + countList - 1;
		
		String query = "SELECT * FROM (SELECT ROWNUM RNUM, BOARD_NO, TITLE, BOARD_DATE, CATEGORY_NO, "
					+ "CATEGORY_FOOD, COMMENT_NUM, RECOMMEND, THUMBNAIL_NAME, BOARD_LINK, NICKNAME "
					+ "FROM (SELECT * FROM V_USER_REVIEW_LIST " + qr
					+ " )) WHERE RNUM >= ? AND RNUM <= ?";

		//System.out.println("쿼리 확인...2 : " + query);
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rset = pstmt.executeQuery();
			
			while(rset.next()){
				Board b = new Board();
				b.setBoardNo(rset.getString("board_no"));
				b.setTitle(rset.getString("title"));
				b.setBoardDate(rset.getDate("board_date"));
				b.setCategoryName(rset.getString("category_food"));
				b.setCommentNum(rset.getInt("comment_num"));
				b.setRecommed(rset.getInt("recommend"));
				b.setThumbnailName(rset.getString("thumbnail_name"));
				b.setBoardLink(rset.getString("board_link"));
				b.setNickName(rset.getString("nickname"));
				
				list.add(b);
			}
			
//			if(list.size() == 0)
//				throw new AdminBoardException("게시글이 없습니다.");
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new UserBoardException(e.getMessage());
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}
}
