package common.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class Board implements Serializable {
	private static final long serialVersionUID = 5477223519827923309L;
	
	private String boardNo; // 게시판번호
	private String categoryNo; // 카테고리번호
	private String categoryName; // 카테고리이름
	private String userId; // 유저아이디
	private String boardGb; // 게시판 구분
	private String nickName; // 닉네임
	private String gradeName; // 사용자등급
	private String title; // 제목
	private String contents; // 텍스트만 뺀 내용
	private String contentsTag; // html 태그 포함 내용텍스트만 뺀 내용
	private Date boardDate; // 작성일
	private String shopName; // 가게이름
	private String shopAddress; // 가게주소
	private String shopCall; // 전화번호
	private int latitude; // 위도
	private int longitude; // 경도
	private int hits; // 조회수
	private int commentNum;    // 댓글수
	private int recommed; // 추천수
	private String boardLink; // url
	private String state; // 글 상태(삭제대기/일반)
	private String thumbnailName; // 썸네일주소
	private Date delDate; // 삭제날짜
	
	//글목록 볼때도 댓글갯수를 알기 위해 리뷰코멘트 테이블이 필요
	//댓글 ajax통신으로 jsp단에서 처리
	private String commentNo; //댓글번호  (댓글 수정할때 필요)    
	private String commentUserId; // 댓글작성자아이디
	private String commentNickName; // 댓글작성자닉네임
	private String commentGradeName; // 댓글작성자 등급
	private Date commentDate; // 댓글작성일
	private String commentContents; // 댓글내용
	private String commentState; // 댓글 상태
	private Date commentDelDate; // 댓글 삭제일
	
	public Board(){}

	public Board(String boardNo, String categoryNo, String categoryName, String userId, String boardGb, String nickName,
			String gradeName, String title, String contents, String contentsTag, Date boardDate, String shopName,
			String shopAddress, String shopCall, int latitude, int longitude, int hits, int commentNum, int recommed,
			String boardLink, String state, String thumbnailName, Date delDate, String commentNo, String commentUserId,
			String commentNickName, String commentGradeName, Date commentDate, String commentContents,
			String commentState, Date commentDelDate) {
		this.boardNo = boardNo;
		this.categoryNo = categoryNo;
		this.categoryName = categoryName;
		this.userId = userId;
		this.boardGb = boardGb;
		this.nickName = nickName;
		this.gradeName = gradeName;
		this.title = title;
		this.contents = contents;
		this.contentsTag = contentsTag;
		this.boardDate = boardDate;
		this.shopName = shopName;
		this.shopAddress = shopAddress;
		this.shopCall = shopCall;
		this.latitude = latitude;
		this.longitude = longitude;
		this.hits = hits;
		this.commentNum = commentNum;
		this.recommed = recommed;
		this.boardLink = boardLink;
		this.state = state;
		this.thumbnailName = thumbnailName;
		this.delDate = delDate;
		this.commentNo = commentNo;
		this.commentUserId = commentUserId;
		this.commentNickName = commentNickName;
		this.commentGradeName = commentGradeName;
		this.commentDate = commentDate;
		this.commentContents = commentContents;
		this.commentState = commentState;
		this.commentDelDate = commentDelDate;
	}

	@Override
	public String toString() {
		return "Board [boardNo=" + boardNo + ", categoryNo=" + categoryNo + ", categoryName=" + categoryName
				+ ", userId=" + userId + ", boardGb=" + boardGb + ", nickName=" + nickName + ", gradeName=" + gradeName
				+ ", title=" + title + ", contents=" + contents + ", contentsTag=" + contentsTag + ", boardDate="
				+ boardDate + ", shopName=" + shopName + ", shopAddress=" + shopAddress + ", shopCall=" + shopCall
				+ ", latitude=" + latitude + ", longitude=" + longitude + ", hits=" + hits + ", commentNum="
				+ commentNum + ", recommed=" + recommed + ", boardLink=" + boardLink + ", state=" + state
				+ ", thumbnailName=" + thumbnailName + ", delDate=" + delDate + ", commentNo=" + commentNo
				+ ", commentUserId=" + commentUserId + ", commentNickName=" + commentNickName + ", commentGradeName="
				+ commentGradeName + ", commentDate=" + commentDate + ", commentContents=" + commentContents
				+ ", commentState=" + commentState + ", commentDelDate=" + commentDelDate + "]";
	}

	public String getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(String boardNo) {
		this.boardNo = boardNo;
	}

	public String getCategoryNo() {
		return categoryNo;
	}

	public void setCategoryNo(String categoryNo) {
		this.categoryNo = categoryNo;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getBoardGb() {
		return boardGb;
	}

	public void setBoardGb(String boardGb) {
		this.boardGb = boardGb;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getGradeName() {
		return gradeName;
	}

	public void setGradeName(String gradeName) {
		this.gradeName = gradeName;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getContentsTag() {
		return contentsTag;
	}

	public void setContentsTag(String contentsTag) {
		this.contentsTag = contentsTag;
	}

	public Date getBoardDate() {
		return boardDate;
	}

	public void setBoardDate(Date boardDate) {
		this.boardDate = boardDate;
	}

	public String getShopName() {
		return shopName;
	}

	public void setShopName(String shopName) {
		this.shopName = shopName;
	}

	public String getShopAddress() {
		return shopAddress;
	}

	public void setShopAddress(String shopAddress) {
		this.shopAddress = shopAddress;
	}

	public String getShopCall() {
		return shopCall;
	}

	public void setShopCall(String shopCall) {
		this.shopCall = shopCall;
	}

	public int getLatitude() {
		return latitude;
	}

	public void setLatitude(int latitude) {
		this.latitude = latitude;
	}

	public int getLongitude() {
		return longitude;
	}

	public void setLongitude(int longitude) {
		this.longitude = longitude;
	}

	public int getHits() {
		return hits;
	}

	public void setHits(int hits) {
		this.hits = hits;
	}

	public int getCommentNum() {
		return commentNum;
	}

	public void setCommentNum(int commentNum) {
		this.commentNum = commentNum;
	}

	public int getRecommed() {
		return recommed;
	}

	public void setRecommed(int recommed) {
		this.recommed = recommed;
	}

	public String getBoardLink() {
		return boardLink;
	}

	public void setBoardLink(String boardLink) {
		this.boardLink = boardLink;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getThumbnailName() {
		return thumbnailName;
	}

	public void setThumbnailName(String thumbnailName) {
		this.thumbnailName = thumbnailName;
	}

	public Date getDelDate() {
		return delDate;
	}

	public void setDelDate(Date delDate) {
		this.delDate = delDate;
	}

	public String getCommentNo() {
		return commentNo;
	}

	public void setCommentNo(String commentNo) {
		this.commentNo = commentNo;
	}

	public String getCommentUserId() {
		return commentUserId;
	}

	public void setCommentUserId(String commentUserId) {
		this.commentUserId = commentUserId;
	}

	public String getCommentNickName() {
		return commentNickName;
	}

	public void setCommentNickName(String commentNickName) {
		this.commentNickName = commentNickName;
	}

	public String getCommentGradeName() {
		return commentGradeName;
	}

	public void setCommentGradeName(String commentGradeName) {
		this.commentGradeName = commentGradeName;
	}

	public Date getCommentDate() {
		return commentDate;
	}

	public void setCommentDate(Date commentDate) {
		this.commentDate = commentDate;
	}

	public String getCommentContents() {
		return commentContents;
	}

	public void setCommentContents(String commentContents) {
		this.commentContents = commentContents;
	}

	public String getCommentState() {
		return commentState;
	}

	public void setCommentState(String commentState) {
		this.commentState = commentState;
	}

	public Date getCommentDelDate() {
		return commentDelDate;
	}

	public void setCommentDelDate(Date commentDelDate) {
		this.commentDelDate = commentDelDate;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	
	
	
	
}
