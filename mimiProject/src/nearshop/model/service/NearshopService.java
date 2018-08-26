package nearshop.model.service;

import static common.jdbc.JDBCTemplate.close;
import static common.jdbc.JDBCTemplate.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import common.model.vo.Board;
import nearshop.model.dao.NearshopDao;

public class NearshopService {
	public NearshopService(){}
	
	public ArrayList<Board> selectNearshopList(Double latitude, Double longitude) {
		Connection con = getConnection();
		ArrayList<Board> list = new NearshopDao().selectNearshopList(con, latitude, longitude);
		close(con);
		return list;
	}

}
