package recommend.model.dao;

import static common.jdbc.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import recommend.exception.RecommendException;

public class RecommendDao {

	public int checkRecommend(Connection con, String userId, String boardNo) throws RecommendException{
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int result = 0;
		
		String query = "select count(*) count from TB_RECOMMEND "
						+ "where BOARD_NO = ? and USER_ID = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, boardNo);
			pstmt.setString(2, userId);
			
			rset = pstmt.executeQuery();
			if(rset.next()){
				if(rset.getInt("count")==1){
					result = 1;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new RecommendException(e.getMessage());
		}finally{
			close(rset);
			close(pstmt);
			
		}		
		
		return result;
	}

	public int insertRecommend(Connection con, String userId, String boardNo) throws RecommendException{
		PreparedStatement pstmt = null;
		int result = 0;
		String query = "insert INTO TB_RECOMMEND "
							+ "(BOARD_NO, USER_ID, RECOMMEND_DATE) "
							+ "values (?, ?, SYSDATE)";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, boardNo);
			pstmt.setString(2, userId);
			
			result = pstmt.executeUpdate();
			if(result <= 0)
				throw new RecommendException("추천 등록 실패!");	
		} catch (Exception e) {
			e.printStackTrace();
			throw new RecommendException(e.getMessage());
		}finally{
			close(pstmt);
		}		
		
		return result;
	}

	public int deleteRecommend(Connection con, String userId, String boardNo) throws RecommendException{
		PreparedStatement pstmt = null;
		int result = 0;
		String query = "delete from TB_RECOMMEND "
						+ "where BOARD_NO = ? and USER_ID = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, boardNo);
			pstmt.setString(2, userId);
			
			result = pstmt.executeUpdate();
			
			if(result <= 0)
				throw new RecommendException("추천 삭제 실패!");
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new RecommendException(e.getMessage());
		}finally{
			close(pstmt);
		}
		
		return result;
	}

	public int countRecommend(Connection con, String boardNo) throws RecommendException{
		int listCount = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "select RECOMMEND from TB_BOARD_REVIEW "
						+ "where BOARD_NO = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, boardNo);
			rset = pstmt.executeQuery();
			
			if(rset.next()){
				listCount = rset.getInt("RECOMMEND");
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new RecommendException(e.getMessage());
		}finally{
			close(rset);
			close(pstmt);
		}
		
		return listCount;
	}

}
