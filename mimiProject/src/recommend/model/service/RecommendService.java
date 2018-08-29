package recommend.model.service;


import static common.jdbc.JDBCTemplate.close;
import static common.jdbc.JDBCTemplate.getConnection;

import java.sql.Connection;

import recommend.exception.RecommendException;
import recommend.model.dao.RecommendDao;
import recommend.model.vo.Recommend;

public class RecommendService {		//추천하기 기능
	
	public int insertRecommand(Recommend recommend) throws RecommendException{//추천하기
		return 0;
	}
	public int deleteRecommand(Recommend recommend) throws RecommendException{//추천 취소하기
		return 0;
	}
	public int recommendCheck(String userId, String boardNo) throws RecommendException{
		Connection con = getConnection();			
		int result = 0;	
		result = new RecommendDao().recommendCheck(con, userId, boardNo);
		close(con);
		
		return result;

	}
}
