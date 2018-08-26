package myboard.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import common.model.vo.Board;
import myboard.exception.MyBoardException;

public class MyBoardService {	//회원 기능 중 본인이 작성한 게시물
	public MyBoardService(){}
	
	public int getListCount() throws MyBoardException{ //전체 게시물 조회 시 페이지네이션 표현을 위한 총 갯수 필요
		return 0;
	}
	public int getSearchListCount(HashMap<String, String> keword) throws MyBoardException{ //검색한 게시물 총 갯수(페이지네이션 관리 시 필요)
		return 0;
	}
	public int deleteMyBoard(ArrayList<String> boardNoList) throws MyBoardException{ //체크박스에 체크한 게시물 삭제
		return 0;
	}
	public ArrayList<Board> selectMyBoardList() throws MyBoardException{ //전체 게시물 조회
		return null;
	}
	public ArrayList<Board> searchMyBoard(HashMap<String, String> keword) throws MyBoardException{//키워드 검색에 필요한 데이터를 map에 다 넣음(key는 쿼리문,value는 ?값)
		return null;
	}
}
