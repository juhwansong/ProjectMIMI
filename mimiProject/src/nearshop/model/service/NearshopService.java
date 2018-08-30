package nearshop.model.service;

import static common.jdbc.JDBCTemplate.close;
import static common.jdbc.JDBCTemplate.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import common.model.vo.Board;
import nearshop.model.dao.NearshopDao;
import notice.model.dao.NoticeDao;

public class NearshopService {
	public NearshopService(){}
	
	public ArrayList<Board> selectNearshopList(int currentPage, int countList, Double latitude, Double longitude) {
		Connection con = getConnection();
		ArrayList<Board> list = new NearshopDao().selectNearshopList(con, currentPage, countList, latitude, longitude);
		close(con);
		return list;
	}

	public int getListCount(Double latitude, Double longitude) {
		Connection con = getConnection();
		int listCount = new NearshopDao().getListCount(con, latitude, longitude);
		close(con);
		return listCount;
	}

}
