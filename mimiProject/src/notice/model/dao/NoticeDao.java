package notice.model.dao;

import static common.jdbc.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import notice.exception.NoticeException;
import notice.model.vo.Notice;

public class NoticeDao {

	//공지사항 전체 목록
	public ArrayList<Notice> selectNoticeList(Connection conn, int currentPage, int countList) throws NoticeException{
		ArrayList<Notice> list = new ArrayList<Notice>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "SELECT * FROM (SELECT ROWNUM RNUM, NOTICE_NO, NOTICE_TITLE, NICKNAME, NOTICE_DATE "
				+ "FROM (SELECT * FROM V_NOTICE_LIST ORDER BY NOTICE_NO DESC)) WHERE RNUM >= ? AND RNUM <= ?";
		
		int startRow = (currentPage - 1) * countList + 1;
		int endRow = startRow + countList - 1;
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rset = pstmt.executeQuery();
			
			while(rset.next()){
				Notice n = new Notice();
				
				n.setNoticeNo(rset.getString("notice_no"));
				n.setNoticeTitle(rset.getString("notice_title"));
				n.setUserId(rset.getString("nickname")); //id 대신 닉네임 넣음
				n.setNoticeDate(rset.getDate("notice_date"));
				
				list.add(n);
			}
			
			if(list.size() == 0)
				throw new NoticeException("공지사항이 없습니다.....");
		} catch (Exception e) {
			e.printStackTrace();
			throw new NoticeException(e.getMessage());
		} finally {
			close(rset);
			close(pstmt);
		}
				
		return list;
	}

	//전체 게시물 수 조회용
	public int getListCount(Connection conn) throws NoticeException{
		int listCount = 0;
		Statement stmt = null;
		ResultSet rset = null;
		String query = "SELECT COUNT(*) FROM V_NOTICE_LIST";
		
		try {
			stmt = conn.createStatement();
			rset = stmt.executeQuery(query);
			
			if(rset.next()){
				listCount = rset.getInt(1);
			}else{
				throw new NoticeException("공지사항이 존재하지 않습니다.....");
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new NoticeException(e.getMessage());
		} finally {
			close(rset);
			close(stmt);
		}
		return listCount;
	}

	//해당 공지사항 상세보기
	public Notice selectNotice(Connection conn, String noticeNo) throws NoticeException{
		Notice n = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "SELECT * FROM V_NOTICE_VIEW WHERE NOTICE_NO = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, noticeNo);
			rset = pstmt.executeQuery();
			
			if(rset.next()){
				n = new Notice();
				
				n.setNoticeNo(rset.getString("notice_no"));
				n.setNoticeTitle(rset.getString("notice_title"));
				n.setUserId(rset.getString("nickname")); // id대신 nickname 집어넣음
				n.setNoticeDate(rset.getDate("notice_date"));
				n.setNoticeContents(rset.getString("notice_contents"));
				n.setNoticeRealFile(rset.getString("notice_real_file"));
				n.setNoticeRenameFile(rset.getString("notice_rename_file"));
				n.setFileCnt(rset.getInt("file_cnt"));
				
			}else{
				throw new NoticeException("공지사항 상세 조회 실패.....");
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new NoticeException(e.getMessage());
		} finally{
			close(rset);
			close(pstmt);
		}
		return n;
	}

	//공지사항 등록
	public int insertNotice(Connection conn, Notice n) throws NoticeException{
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "INSERT INTO TB_BOARD_NOTICE VALUES "
				+ "('BN'||LPAD(BOARD_NOTICE_SEQ.NEXTVAL, 4, '0'), ?, ?, ?, DEFAULT, ?, ?, ?)";
		//공지사항번호,작성자,공지사항제목,공지사항내용,공지사항작성일(DEFAULT SYSDATE),원본파일명(NULL),바뀐파일명(NULL),파일개수(NULL)
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, n.getUserId()); //닉네임,,,아이디 혼용,,,,
			pstmt.setString(2, n.getNoticeTitle());
			pstmt.setString(3, n.getNoticeContents());
			pstmt.setString(4, n.getNoticeRealFile());
			pstmt.setString(5, n.getNoticeRenameFile());
			pstmt.setInt(6, n.getFileCnt());
			
			result = pstmt.executeUpdate();
			
			if(result <= 0)
				throw new NoticeException("공지사항 등록 실패.....");
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new NoticeException(e.getMessage());
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int deleteNotice(Connection conn, String noticeNo) throws NoticeException{
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "DELETE FROM TB_BOARD_NOTICE WHERE NOTICE_NO = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, noticeNo);
			result = pstmt.executeUpdate();
			
			if(result < 0)
				throw new NoticeException("공지사항 삭제 실패.....");
					
		} catch (Exception e) {
			e.printStackTrace();
			throw new NoticeException(e.getMessage());
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int updateNotice(Connection conn, Notice notice) throws NoticeException{
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "";		
		
		if(notice.getNoticeRealFile() != null) {
			query = "UPDATE TB_BOARD_NOTICE SET NOTICE_TITLE = ?, NOTICE_CONTENTS = ?, NOTICE_REAL_FILE = ?, NOTICE_RENAME_FILE = ? WHERE NOTICE_NO = ?";
		}else{
			query = "UPDATE TB_BOARD_NOTICE SET NOTICE_TITLE = ?, NOTICE_CONTENTS = ? WHERE NOTICE_NO = ?";
		}
		try {
			pstmt = conn.prepareStatement(query);
			if(notice.getNoticeRealFile() != null){
				pstmt.setString(1, notice.getNoticeTitle());
				pstmt.setString(2, notice.getNoticeContents());
				pstmt.setString(3, notice.getNoticeRealFile());
				pstmt.setString(4, notice.getNoticeRenameFile());
				pstmt.setString(5, notice.getNoticeNo());
			}else{
				pstmt.setString(1, notice.getNoticeTitle());
				pstmt.setString(2, notice.getNoticeContents());
				pstmt.setString(3, notice.getNoticeNo());
			}
			
			result = pstmt.executeUpdate();
			
			if(result <= 0)
				throw new NoticeException("새 공지글 수정 실패.....");
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new NoticeException(e.getMessage());
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	//통합검색
	public ArrayList<Notice> searchNotice(Connection conn, String keyword) throws NoticeException{
		ArrayList<Notice> list = new ArrayList<Notice>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "SELECT * FROM V_NOTICE_VIEW WHERE NOTICE_TITLE LIKE ? OR NOTICE_CONTENTS LIKE ?"
				+ " ORDER BY NOTICE_NO DESC";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, "%" + keyword + "%");
			pstmt.setString(2, "%" + keyword + "%");
			
			rset = pstmt.executeQuery();
			
			while(rset.next()){
				Notice n = new Notice();
				
				n.setNoticeNo(rset.getString("notice_no"));
				n.setNoticeTitle(rset.getString("notice_title"));
				n.setUserId(rset.getString("nickname")); //id 대신 닉네임///////////////////
				n.setNoticeDate(rset.getDate("notice_date"));
				
				list.add(n);
				//System.out.println(n); //가져오는거 확인용
			}
			
			if(list.size() == 0)
				throw new NoticeException("공지글이 없습니다.");
		} catch (Exception e) {
			e.printStackTrace();
			throw new NoticeException(e.getMessage());
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

}
