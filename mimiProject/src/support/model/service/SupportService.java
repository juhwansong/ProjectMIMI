package support.model.service;

import java.util.ArrayList;

import support.exception.SupportException;
import support.model.vo.Support;

public class SupportService {	//고객센터 페이지 기능
	public SupportService(){}
	
	public int getListCount() throws SupportException{//게시물 총 갯수(페이지네이션 관리 시 필요)
		return 0;
	}
	public int getSearchListCount(String keword) throws SupportException{ //검색한 게시물 총 갯수(페이지네이션 관리 시 필요)
		return 0;
	}
	public Support selectSupport(String boardNo) throws SupportException{//해당 게시물 클릭
		return null;
	}
	
	public int insertSupport(Support support) throws SupportException{ //게시물 추가
		return 0;
	}
	public ArrayList<Support> selectSupportList() throws SupportException{//전체 게시물 조회
		return null;
	}
	
	public ArrayList<Support> searchSupport(String keword) throws SupportException{//키워드 검색
		return null;
	}
	
	public int insertSupportReply(Support support) throws SupportException{//게시물 댓글 추가
		return 0;
	}
	public ArrayList<Support> selectSupportReplyList(int boardNo) throws SupportException{//해당 게시물의 전체 댓글 조회
		return null;
	}
	
}
