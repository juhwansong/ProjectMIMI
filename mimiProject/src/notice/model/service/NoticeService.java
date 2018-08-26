package notice.model.service;

import static common.jdbc.JDBCTemplate.*;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;

import adminboard.model.dao.AdminBoardDao;
import notice.exception.NoticeException;
import notice.model.dao.NoticeDao;
import notice.model.vo.Notice;

public class NoticeService {//공지사항 게시판 기능
	public NoticeService(){}
	
	public void addReadCount(String noticeNo) throws NoticeException{//조회수 증가
		
	}
	public int getListCount() throws NoticeException{//게시물 총 갯수(페이지네이션 관리 시 필요)
		Connection conn = getConnection();
		int listCount = new NoticeDao().getListCount(conn);
		close(conn);
		return listCount;
	}

	public int deleteNotice(String noticeNo) throws NoticeException{//게시물 삭제
		Connection conn = getConnection();
		int result = new NoticeDao().deleteNotice(conn, noticeNo);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);	
		close(conn);
		return result;
	}
	public Notice selectNotice(String noticeNo) throws NoticeException{//해당 게시물 상세보기
		Connection conn = getConnection();
		Notice notice = new NoticeDao().selectNotice(conn, noticeNo);
		close(conn);
		return notice;
	}
	
	public int insertNotice(Notice notice) throws NoticeException{ //공지사항 등록
		Connection conn = getConnection();
		int result = new NoticeDao().insertNotice(conn, notice);
		
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;
	}
	public ArrayList<Notice> selectNoticeList(int currentPage, int countList) throws NoticeException{//전체 게시물 조회
		Connection conn = getConnection();
		ArrayList<Notice> list = new NoticeDao().selectNoticeList(conn, currentPage, countList);
		close(conn);
		return list;
	}
	public int updateNotice(Notice notice) throws NoticeException{ //게시물 수정
		Connection conn = getConnection();
		int result = new NoticeDao().updateNotice(conn, notice);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;
	}
	
	//통합검색
	public ArrayList<Notice> searchNotice(String keyword, int currentPage, int countList) throws NoticeException{//검색한 키워드 데이터를 map에 다 넣음(key는 쿼리문,value는 ?값)//통합 검색으로 수정
		Connection conn = getConnection();
		ArrayList<Notice> list = new NoticeDao().searchNotice(conn, keyword, currentPage, countList);
		close(conn);
		return list;
	}

	//검색한 게시물 총 갯수(페이지네이션 관리 시 필요)
	public int getSearchListCount(String keyword) throws NoticeException{
		Connection conn = getConnection();
		int listCount = new NoticeDao().getListCount(conn, keyword);
		close(conn);
		return listCount;
	}

}
