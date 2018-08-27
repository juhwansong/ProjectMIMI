package recommend.model.service;


import static common.jdbc.JDBCTemplate.close;
import static common.jdbc.JDBCTemplate.commit;
import static common.jdbc.JDBCTemplate.getConnection;
import static common.jdbc.JDBCTemplate.rollback;

import java.sql.Connection;

import recommend.exception.RecommendException;
import recommend.model.dao.RecommendDao;
import recommend.model.vo.Recommend;

public class RecommendService {		//추천하기 기능
	
	public int insertRecommend(String userId, String boardNo) throws RecommendException{//추천하기
		Connection con = getConnection();			
		int result = new RecommendDao().insertRecommend(con, userId, boardNo);
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		return result;
	}
	public int deleteRecommend(String userId, String boardNo) throws RecommendException{//추천 취소하기
		Connection con = getConnection();			
		int result = new RecommendDao().deleteRecommend(con, userId, boardNo);
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		return result;
	}
	public int checkRecommend(String userId, String boardNo) throws RecommendException{
		Connection con = getConnection();			
		int result = 0;	
		result = new RecommendDao().checkRecommend(con, userId, boardNo);
		close(con);
		
		return result;
	}
	
	public int countRecommend(String boardNo) throws RecommendException{
		Connection con = getConnection();	
		int recommendCount = new RecommendDao().countRecommend(con, boardNo);
		close(con);
		return recommendCount;
	}
}
