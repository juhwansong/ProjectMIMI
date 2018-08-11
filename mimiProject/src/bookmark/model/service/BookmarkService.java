package bookmark.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import bookmark.exception.BookmarkException;
import common.model.vo.Board;

public class BookmarkService {	//즐겨찾기 기능
	public BookmarkService(){}
	
	public int getListCount() throws BookmarkException{//전체 게시물 조회 시 페이지네이션 표현을 위한 총 갯수 필요
		return 0;
	}
	public int getSearchListCount(HashMap<String, String> keword) throws BookmarkException{//검색한 게시물 총 갯수(페이지네이션 관리 시 필요)
		return 0;
	}
	public int deleteBookmark(ArrayList<String> BoardNoList) throws BookmarkException{//체크박스에 체크한 게시물 삭제
		return 0;
	}
	public ArrayList<Board> selectBookmarkList() throws BookmarkException{//전체 게시물 조회
		return null;
	}	
	public ArrayList<Board> searchBookmark(HashMap<String, String> keword) throws BookmarkException{//키워드 검색에 필요한 데이터를 map에 다 넣음(key는 쿼리문,value는 ?값)
			
		return null;
	}
}
