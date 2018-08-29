package nearshop.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import static common.jdbc.JDBCTemplate.*;
import common.model.vo.Board;

public class NearshopDao {
	public NearshopDao(){}

	public ArrayList<Board> selectNearshopList(Connection con, Double latitude, Double longitude) {
		
		ArrayList<Board> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from(select contents, board_no, shop_name, shop_address, shop_call, title, thumbnail_name, latitude, longitude, DISTNACE_WGS84(?, ?, latitude, longitude) as distance from tb_board_review where state = 'SN' order by distance) where distance < 10 ";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setDouble(1, latitude);
			pstmt.setDouble(2, longitude);
			rset = pstmt.executeQuery();
			
			while(rset.next()){
				
				Board board = new Board();
				board.setBoardNo(rset.getString("board_no"));
				board.setTitle(rset.getString("title"));
				board.setContents(rset.getString("contents"));
				board.setThumbnailName(rset.getString("thumbnail_name"));
				board.setLatitude(rset.getDouble("latitude"));
				board.setLongitude(rset.getDouble("longitude"));
				board.setShopName(rset.getString("shop_name"));
				board.setShopAddress(rset.getString("shop_address"));
				board.setShopCall(rset.getString("shop_call"));
				
				list.add(board);
				
			}			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			close(rset);
			close(pstmt);
		}
		
		return list;
	}

}
