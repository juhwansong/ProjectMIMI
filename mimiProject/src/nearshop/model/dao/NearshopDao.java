package nearshop.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import static common.jdbc.JDBCTemplate.*;
import common.model.vo.Board;
import notice.exception.NoticeException;

public class NearshopDao {
	public NearshopDao(){}

	public ArrayList<Board> selectNearshopList(Connection con, int currentPage, int countList, Double latitude, Double longitude) {
		
		ArrayList<Board> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from (select rownum rnum, contents, board_no, shop_name, shop_address, shop_call, title, thumbnail_name, latitude, longitude, distance from(select contents, board_no, shop_name, shop_address, shop_call, title, thumbnail_name, latitude, longitude, DISTNACE_WGS84(?, ?, latitude, longitude) as distance from tb_board_review where state = 'SN' and BOARD_GB = 'UR' order by distance) where distance < 10) where rnum >= ? and rnum <= ? ";
		
		int startRow = (currentPage - 1) * countList +1;
		int endRow = startRow + countList -1;
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setDouble(1, latitude);
			pstmt.setDouble(2, longitude);
			pstmt.setInt(3, startRow);
			pstmt.setInt(4, endRow);
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

	public int getListCount(Connection con, Double latitude, Double longitude) {
		int listCount = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "select count(*) from(select contents, board_no, shop_name, shop_address, shop_call, title, thumbnail_name, latitude, longitude, DISTNACE_WGS84(?, ?, latitude, longitude) as distance from tb_board_review where state = 'SN' order by distance) where distance < 10";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setDouble(1, latitude);
			pstmt.setDouble(2, longitude);
			rset = pstmt.executeQuery();
			
			if(rset.next()){
				listCount = rset.getInt(1);
			}
	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return listCount;
	}

}
