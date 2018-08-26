package support.model.dao;

import static common.jdbc.JDBCTemplate.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import notice.model.vo.Notice;
import support.exception.SupportException;
import support.model.vo.Support;

public class SupportDao {
	public SupportDao(){}
	
	/*public int getSListCount(Connection con) throws SupportException {
		int listCount = 0;
		Statement stmt = null;
		ResultSet rset = null;
		
		String query = "select count(*) from tb_board_service";
		
		
		return listCount;
		
	}*/

	public ArrayList<Support> selectList(Connection con, int currentPage, int limit) throws SupportException { // 고객센터 글 리스트
		ArrayList<Support> slist = new ArrayList<Support>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from ("
				+ "select rownum rnum, board_no, "
				+ "user_id, title, contents, write_date, category, state "
				+ "from (select * from tb_board_service "
				+ "order by board_no desc)) "
				+ "where rnum >= ? and rnum <= ?";
		
		
		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			
			rset = pstmt.executeQuery();
			while (rset.next()) {
				Support s = new Support();
				
				s.setBoardNo(rset.getString("board_no"));
				s.setUserId(rset.getString("user_id"));
				s.setTitle(rset.getString("title"));
				s.setContents(rset.getString("contents"));
				s.setWriteDate(rset.getDate("write_date"));
				s.setCategory(rset.getInt("category"));
				s.setState(rset.getString("state"));
			
				slist.add(s);				
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		return slist;
		
	}

	public Support selectSupport(Connection con, String boardNo) throws SupportException { // 고객센터 글 상세보기
		Support support = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from tb_board_service where board_no = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, boardNo);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				support = new Support();
				
				support.setBoardNo(rset.getString("board_no"));
				support.setUserId(rset.getString("user_id"));
				support.setTitle(rset.getString("title"));
				support.setContents(rset.getString("contents"));
				support.setWriteDate(rset.getDate("write_date"));
				support.setCategory(rset.getInt("category"));
				support.setState(rset.getString("state"));
				
			}else
				throw new SupportException("문의글 상세 조회 실패");
				
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		return support;
	}


	public int insertSupport(Connection con, Support support) throws SupportException { // 고객센터 새글 쓰기
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "insert into tb_board_service values ('BS'||LPAD(BOARD_SERVICE_SEQ.NEXTVAL, 4, '0'), 'user01', ?, ?, sysdate, ?, ?)";
		
		try {
			pstmt = con.prepareStatement(query);
			//pstmt.setString(1, support.getUserId());
			pstmt.setString(1, support.getTitle());
			pstmt.setString(2, support.getContents());
			pstmt.setInt(3, support.getCategory());			
			pstmt.setString(4, support.getState());
			
			result = pstmt.executeUpdate();
			
			if (result <= 0)
				throw new SupportException("새 글 등록 실패");
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new SupportException(e.getMessage());
		}finally {
			close(pstmt);
		}
		return result;
		
	}

	public int updateSupport(Connection con, Support support) throws SupportException { // 글 수정하기
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "update tb_board_service set "
				+ "title = ?, "
				+ "contents = ? "
				+ "where board_no = ? ";
		
		try {
			pstmt=con.prepareStatement(query);
			pstmt.setString(1, support.getTitle());
			pstmt.setString(2, support.getContents());
			pstmt.setString(3, support.getBoardNo());
			
			result = pstmt.executeUpdate();		
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new SupportException(e.getMessage());
		}finally {
			close(pstmt);
		}
		
		return result;
	}

	public int getListCount(Connection con) throws SupportException {
		int listCount = 0;
		Statement stmt = null;
		ResultSet rset = null;
		
		String query = "select count(*) from tb_board_service";
		
		try {
			stmt = con.createStatement();
			rset = stmt.executeQuery(query);
			
			if(rset.next()){
				listCount = rset.getInt(1);
			}else{
				throw new SupportException("게시글이 존재하지 않습니다.");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new SupportException(e.getMessage());
		}finally{
			close(rset);
			close(stmt);
		}
		
		return listCount;
		
	}
	
	public int deleteSupport(Connection con, 
			String boardNo) throws SupportException{ //문의게시판 글 삭제
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "delete from tb_board_service where board_no= ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, boardNo);
			
			result = pstmt.executeUpdate();
			
			if(result <= 0)
				throw new SupportException("게시글 삭제 실패!");
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new SupportException(e.getMessage());
		}finally{
			close(pstmt);
		}
		
		return result;
	}
	
	public int replyinsertSupport(Connection con, Support support) throws SupportException { // 고객센터 댓글 쓰기
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "insert into tb_comment_service values ('CS'||LPAD(COMMENT_SERVICE_SEQ.NEXTVAL, 4, '0'), ?, ?, sysdate, ?)";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, support.getBoardNo());
			pstmt.setString(2, support.getUserId());
			pstmt.setString(3, support.getCommentContents());	
			
			result = pstmt.executeUpdate();
			
			if (result <= 0)
				throw new SupportException("댓글 등록 실패");
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new SupportException(e.getMessage());
		}finally {
			close(pstmt);
		}
		return result;
		
	}

	public ArrayList<Support> selectReplyList(Connection con, String boardNo) throws SupportException { //댓글 불러오기
		ArrayList<Support> slist = new ArrayList<Support>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from tb_comment_service where board_no = ? order by comment_date asc";
		
		try {
			pstmt = con.prepareStatement(query);
			
			pstmt.setString(1, boardNo);
			
			rset = pstmt.executeQuery();
		
			
			while(rset.next()){
				Support support = new Support();
				
				support.setBoardNo(rset.getString("board_no"));
				support.setUserId(rset.getString("user_id"));
				support.setCommentNo(rset.getString("comment_no"));
				support.setCommentDate(rset.getDate("comment_date"));
				support.setContents(rset.getString("comment_contents"));		
				
				slist.add(support);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new SupportException(e.getMessage());
		} finally {
			close(rset);
			close(pstmt);
		}
		return slist;
		
	}

	public int getSearchListCount(Connection con, String column, String keword) throws SupportException {
		int listCount = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select count(*) from tb_board_service where " + column + " like ? ";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, "%" +keword + "%");
			
			rset = pstmt.executeQuery();
			
			if(rset.next()){
				listCount = rset.getInt(1);
			}else{
				throw new SupportException("게시글이 존재하지 않습니다.");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new SupportException(e.getMessage());
		}finally{
			close(rset);
			close(pstmt);
		}
		
		return listCount;
	}

	public ArrayList<Support> searchSupport(Connection con, int currentPage, int limit, String column, String keyword) throws SupportException {
		ArrayList<Support> slist = new ArrayList<Support>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from ("
				+ "select rownum rnum, board_no, "
				+ "user_id, title, contents, write_date, category, state "
				+ "from (select * from tb_board_service where " + column + " like ? "
				+ "order by board_no desc)) "
				+ "where rnum >= ? and rnum <= ?";
		
		
		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, "%" + keyword + "%");
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			
			rset = pstmt.executeQuery();
			while (rset.next()) {
				Support s = new Support();
				
				s.setBoardNo(rset.getString("board_no"));
				s.setUserId(rset.getString("user_id"));
				s.setTitle(rset.getString("title"));
				s.setContents(rset.getString("contents"));
				s.setWriteDate(rset.getDate("write_date"));
				s.setCategory(rset.getInt("category"));
				s.setState(rset.getString("state"));
			
				slist.add(s);
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		return slist;

	}
}

























