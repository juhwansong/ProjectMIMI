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
				+ "from V_USER_REVIEW_LIST "
				+ "order by BOARD_NO desc) "
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
	

	
	public ArrayList<Board> selectList2(
			Connection con) throws UserBoardException {
		ArrayList<Board> list = new ArrayList<Board>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from V_USER_REVIEW_LIST";
		
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
				System.out.println(list);
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
				urboard.setCategoryName(rset.getString("CATEGORY_FOOD"));
				urboard.setShopName(rset.getString("SHOP_NAME"));
				urboard.setShopCall(rset.getString("SHOP_CALL"));
				urboard.setShopAddress(rset.getString("SHOP_ADDRESS"));
				urboard.setState(rset.getString("STATE"));
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

	public int insertBoard(Connection con, Board board) throws UserBoardException {
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
			pstmt.setInt(9, board.getLatitude());
			pstmt.setInt(10, board.getLongitude());
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

	public int deleteBoard(Connection con, 
			String boardNum) throws UserBoardException{
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "delete from board "
				+ "where board_num = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, boardNum);
			
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

	public int insertReply(Connection con, Board replyBoard) throws UserBoardException {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = null;
		
		/*
		//원글의 댓글인 경우
		if(replyBoard.getBoardLevel() == 1){
			query = "insert into board values ("
				+ "(select max(board_num) + 1 from board), "
				+ "?, ?, ?, null, null, sysdate, ?, ?, "
				+ "(select max(board_num) + 1 from board), "
				+ "1, default)";
		}
		
		//댓글의 댓글인 경우
		if(replyBoard.getBoardLevel() == 2){
			query = "insert into board values ("
					+ "(select max(board_num) + 1 from board), "
					+ "?, ?, ?, null, null, sysdate, ?, ?, ?, "
					+ "1, default)";
		}
		*/
		/*
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, replyBoard.getTitle());
			pstmt.setString(2, replyBoard.getUserId());
			
			if(replyBoard.getBoardLevel() == 2)
				pstmt.setInt(6, replyBoard.getBoardReplyRef());
			
			result = pstmt.executeUpdate();
			
			if(result <= 0)
				throw new BoardException(
					replyBoard.getBoardRef()
					+ "번글에 대한 댓글 달기 실패!");
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new BoardException(e.getMessage());
		}finally{
			close(pstmt);
		}
		*/
		return result;
	}


}
