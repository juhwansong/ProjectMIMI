package bestboard.model.dao;

import static common.jdbc.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import bestboard.exception.BestBoardException;
import common.model.vo.Board;

public class BestBoardDao {


	//게시물 내리기 (state변경용)
	public int deleteBestBoard(Connection conn, String[] boardNoList) throws BestBoardException {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "UPDATE TB_BOARD_BEST SET BEST_REVIEW_STATE = 'SD' WHERE BOARD_NO = ?";
		
		try {
			for(String boardNo : boardNoList){
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, boardNo);
				result = pstmt.executeUpdate();
			}
			
			if(result <= 0)
				throw new BestBoardException("상태 변경 실패...ㅠ");
		} catch (Exception e) {
			e.printStackTrace();
			throw new BestBoardException(e.getMessage());
		} finally {
			close(pstmt);
		}
		return result;
	}

	//전체 게시물 조회
	public ArrayList<Board> selectBestBoardList(Connection conn) throws BestBoardException {
		ArrayList<Board> list = new ArrayList<>();
		Statement stmt = null;
		ResultSet rset = null;
		
		String query = "SELECT * FROM TB_BOARD_BEST"
				+ " WHERE SELECTED_MONTH = TO_CHAR(SYSDATE, 'RR/MM')"
				+ " ORDER BY RANK ASC";
		
		try {
			stmt = conn.createStatement();
			rset = stmt.executeQuery(query);
			
			
			while(rset.next()){
				Board b = new Board();
				
				b.setBoardNo(rset.getString("board_no"));
				b.setNickName(rset.getString("nickname"));
				b.setTitle(rset.getString("title"));
				b.setContents(rset.getString("contents"));
				b.setCommentNum(rset.getInt("comment_num"));
				b.setBoardLink(rset.getString("board_link"));
				b.setThumbnailName(rset.getString("thumbnail_name"));
				b.setHits(rset.getInt("hits"));
				
				//변수이름이 없어서 다른곳에 대체
				b.setGradeName(rset.getString("selected_month"));
				b.setLongitude(rset.getInt("rank"));
				
				list.add(b);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new BestBoardException(e.getMessage());
		} finally {
			close(rset);
			close(stmt);
		}
		return list;
	}

	//키워드 검색용 목록 개수
	public int getSearchListCount(Connection conn, String keyword) throws BestBoardException {
		int listCount = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "SELECT COUNT(*) FROM V_BEST_REVIEW"
				+ " WHERE (TITLE LIKE ? OR CONTENTS LIKE ? OR NICKNAME LIKE ?)"
				+ " AND STATE = 'SN' ORDER BY SELECTED_MONTH DESC, RANK ASC";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, "%" + keyword + "%");
			pstmt.setString(2, "%" + keyword + "%");
			pstmt.setString(3, "%" + keyword + "%");
			rset = pstmt.executeQuery();
			
			if(rset.next()){
				listCount = rset.getInt(1);
			}else{
				//없을 때
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new BestBoardException(e.getMessage());
		} finally {
			close(rset);
			close(pstmt);
		}
		return listCount;
	}

	//키워드 검색(제목, 내용, 닉네임 통합)
	public ArrayList<Board> searchBestBoard(Connection conn, String keyword, int currentPage, int countList) throws BestBoardException {
		ArrayList<Board> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "SELECT * FROM (SELECT ROWNUM RNUM, BOARD_NO, TITLE, CONTENTS, USER_ID,"
				+ " NICKNAME, HITS, RECOMMEND, THUMBNAIL_NAME, BOARD_LINK, COMMENT_NUM, RANK, STATE"
				+ " FROM (SELECT * FROM V_BEST_REVIEW WHERE (TITLE LIKE ? OR CONTENTS LIKE ? OR NICKNAME LIKE ?)"
				+ " AND STATE = 'SN' ORDER BY SELECTED_MONTH DESC, RANK ASC)) WHERE RNUM >= ? AND RNUM <= ?";
		
		int startRow = (currentPage - 1) * countList + 1;
		int endRow = startRow + countList - 1;
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, "%" + keyword + "%");
			pstmt.setString(2, "%" + keyword + "%");
			pstmt.setString(3, "%" + keyword + "%");
			pstmt.setInt(4, startRow);
			pstmt.setInt(5, endRow);
			rset = pstmt.executeQuery();
			
			while(rset.next()){
				Board b = new Board();
				
				b.setBoardNo(rset.getString("board_no"));
				b.setNickName(rset.getString("nickname"));
				b.setTitle(rset.getString("title"));
				b.setContents(rset.getString("contents"));
				b.setCommentNum(rset.getInt("comment_num"));
				b.setBoardLink(rset.getString("board_link"));
				b.setThumbnailName(rset.getString("thumbnail_name"));
				b.setHits(rset.getInt("hits"));
				
				//변수이름이 없어서 다른곳에 대체
				b.setGradeName(rset.getString("selected_month"));
				b.setLongitude(rset.getInt("rank"));
				
				list.add(b);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new BestBoardException(e.getMessage());
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return list;
	}
	
	//연월 검색
	public ArrayList<Board> searchMonthBestBoard(Connection conn, String keyword) throws BestBoardException {
		ArrayList<Board> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "SELECT * FROM V_BEST_REVIEW WHERE SELECTED_MONTH = ? ORDER BY RANK ASC";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, keyword);
			rset = pstmt.executeQuery();
			
			while(rset.next()){
				Board b = new Board();
				
				b.setBoardNo(rset.getString("board_no"));
				b.setNickName(rset.getString("nickname"));
				b.setTitle(rset.getString("title"));
				b.setContents(rset.getString("contents"));
				b.setCommentNum(rset.getInt("comment_num"));
				b.setBoardLink(rset.getString("board_link"));
				b.setThumbnailName(rset.getString("thumbnail_name"));
				b.setHits(rset.getInt("hits"));
				
				//변수이름이 없어서 다른곳에 대체
				b.setGradeName(rset.getString("selected_month"));
				b.setLongitude(rset.getInt("rank"));
				
				list.add(b);
				
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new BestBoardException(e.getMessage());
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return list;
	}

}
