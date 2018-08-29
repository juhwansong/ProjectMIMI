package support.model.service;

import static common.jdbc.JDBCTemplate.close;
import static common.jdbc.JDBCTemplate.commit;
import static common.jdbc.JDBCTemplate.getConnection;
import static common.jdbc.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.ArrayList;

import notice.model.dao.NoticeDao;
import notice.model.vo.Notice;
import support.exception.SupportException;
import support.model.dao.SupportDao;
import support.model.vo.Support;

public class SupportService {	//고객센터 페이지 기능
	public SupportService(){}
	
	public int getListCount() throws SupportException{//게시물 총 갯수(페이지네이션 관리 시 필요)
		Connection con = getConnection();
		int listCount = new SupportDao().getListCount(con);
		close(con);
		return listCount;
		
	}
	public int getSearchListCount(String column, String keword) throws SupportException{ //검색한 게시물 총 갯수(페이지네이션 관리 시 필요)
		Connection con = getConnection();
		int listCount = new SupportDao().getSearchListCount(con, column, keword);
		close(con);
		return listCount;
	}
	public Support selectSupport(String boardNo) throws SupportException{//해당 게시물 클릭
		Connection con = getConnection();
		Support support = new SupportDao().selectSupport(con, boardNo);
		close(con);
		return support;
	}
	
	public int updateSupport(Support support) throws SupportException{ // 게시물 수정
		Connection con = getConnection();
		int result = new SupportDao().updateSupport(con, support);
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		return result;
	}
	
	public int insertSupport(Support support) throws SupportException{ //게시물 추가
		Connection con = getConnection();
		int result = new SupportDao().insertSupport(con, support);
		
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		return result;
		
	}
	public ArrayList<Support> selectSupportList(int currentPage, int limit) throws SupportException{//전체 게시물 조회
		Connection con = getConnection();
		ArrayList<Support> list = new SupportDao().selectList(con, currentPage, limit);
		close(con);
		return list;
		
	}
	
	public ArrayList<Support> searchSupport(int currentPage, int limit, String column, String keyword) throws SupportException{//키워드 검색/////////////////////
		Connection con = getConnection();
		ArrayList<Support> list = new SupportDao().searchSupport(con, currentPage, limit, column, keyword);
		close(con);
		return list;
	}
	
	public int insertSupportReply(Support support) throws SupportException{//게시물 댓글 추가
		Connection con = getConnection();
		int result = new SupportDao().replyinsertSupport(con, support);
		
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		return result;
		
	}
	public ArrayList<Support> selectSupportReplyList(String boardNo) throws SupportException{//해당 게시물의 전체 댓글 조회
		Connection con = getConnection();
		
		ArrayList<Support> list = new SupportDao().selectReplyList(con, boardNo);
		close(con);
		
		return list;
	}



	public int deleteSupport(String boardNo) throws SupportException{ // 게시물 삭제
		Connection con = getConnection();
		int result = new SupportDao().deleteSupport(
				con, boardNo);
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		
		return result;
	}
	
	public int changeState(String boardNo, String state) throws SupportException {
		Connection con = getConnection();
		int result = new SupportDao().changeState(con, boardNo, state);
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		return result;
	}
	
}
