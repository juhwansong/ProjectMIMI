package recommend.model.dao;

import static common.jdbc.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import recommend.exception.RecommendException;
import userboard.exception.UserBoardException;

public class RecommendDao {

	public int recommendCheck(Connection con, String userId, String boardNo) throws RecommendException{
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int result = 0;
		
		String query = "select * from TB_RECOMMEND "
						+ " where BOARD_NO = ? and USER_ID = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, boardNo);
			pstmt.setString(2, userId);
			
			rset = pstmt.executeQuery();
			
			if(rset!=null){
				result = 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new RecommendException(e.getMessage());
		}finally{
			close(pstmt);
		}		
		
		return result;
	}


}
