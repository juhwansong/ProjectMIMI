package bestboard.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import bestboard.exception.BestBoardException;
import common.model.vo.Board;

public class BestBoardService {	//베스트리뷰 게시판 기능
	public BestBoardService(){}
	
	public int getListCount() throws BestBoardException{//전체 게시물 조회 시 페이지네이션 표현을 위한 총 갯수 필요
		return 0;
	}
	public int getSearchListCount(HashMap<String, String> keword) throws BestBoardException{//검색한 게시물 총 갯수(페이지네이션 관리 시 필요)
		return 0;
	}
		
	public ArrayList<Board> selectBestBoardList() throws BestBoardException{//전체 게시물 조회
		return null;
	}
	public ArrayList<Board> searchBestBoard(HashMap<String, String> keword) throws BestBoardException{//키워드 검색에 필요한 데이터를 map에 다 넣음(key는 쿼리문,value는 ?값)
		return null;
	}
	
	public int deleteBestBoard(ArrayList<String> boardNoList) throws BestBoardException{ //베스트 게시판 목록에서 선택한 게시물들 삭제(관리자 기능)
		return 0;
	}

}
