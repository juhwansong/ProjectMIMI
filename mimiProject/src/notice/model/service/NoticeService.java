package notice.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import notice.exception.NoticeException;
import notice.model.vo.Notice;

public class NoticeService {//공지사항 게시판 기능
	public NoticeService(){}
	
	public void addReadCount(String noticeNo) throws NoticeException{//조회수 증가
		
	}
	public int getListCount() throws NoticeException{//게시물 총 갯수(페이지네이션 관리 시 필요)
		return 0;
	}
	public int getSearchListCount(HashMap<String, String> keword) throws NoticeException{ //검색한 게시물 총 갯수(페이지네이션 관리 시 필요)
		return 0;
	}
	public int deleteNotice(String noticeNo) throws NoticeException{//게시물 삭제
		return 0;
	}
	public Notice selectNotice(String noticeNo) throws NoticeException{//해당 게시물 클릭
		return null;
	}
	
	public int insertNotice(Notice notice) throws NoticeException{ //게시물 추가
		return 0;
	}
	public ArrayList<Notice> selectNoticeList() throws NoticeException{//전체 게시물 조회
		return null;
	}
	public int updateNotice(Notice notice) throws NoticeException{ //게시물 수정
		return 0;
	}
	
	public ArrayList<Notice> searchNotice(HashMap<String, String> keword) throws NoticeException{//검색한 키워드 데이터를 map에 다 넣음(key는 쿼리문,value는 ?값)
		return null;
	}

}
