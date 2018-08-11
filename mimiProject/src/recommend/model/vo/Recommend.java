package recommend.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class Recommend implements Serializable {
	private static final long serialVersionUID = -2555855725703536799L;
	
	private String boardNo;		//글번호
	private String userId;		//아이디
	private Date recommendDate;	//추천일
	
	public Recommend(){}

	public Recommend(String boardNo, String userId, Date recommendDate) {
		this.boardNo = boardNo;
		this.userId = userId;
		this.recommendDate = recommendDate;
	}

	@Override
	public String toString() {
		return "Recommend [boardNo=" + boardNo + ", userId=" + userId + ", recommendDate=" + recommendDate + "]";
	}

	public String getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(String boardNo) {
		this.boardNo = boardNo;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public Date getRecommendDate() {
		return recommendDate;
	}

	public void setRecommendDate(Date recommendDate) {
		this.recommendDate = recommendDate;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	

	
	
	
}
