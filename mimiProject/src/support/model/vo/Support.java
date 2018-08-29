package support.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class Support implements Serializable { 
	private static final long serialVersionUID = -4136341026752257164L;
	
	private String boardNo;			//글번호
	private String userId;			//아이디
	private String nickName; 		// 닉네임
	private String gradeName; 		// 사용자등급
	private String title;			//제목
	private String contents;		//내용
	private Date writeDate;			//작성일
	private int category;			//카테고리
	private String state;			//상태
	//서비스게시판댓글
	//댓글 ajax통신으로 jsp단에서 처리
	private String commentNo;		//댓글번호
	private String commentUserId;	//댓글작성자ID
	private String commentNickName; // 댓글작성자닉네임
	private String commentGradeName; // 댓글작성자 등급
	private Date commentDate;		//댓글작성일
	private String commentContents;	//댓글내용
	private int boardLevel;
	
	public Support(){}

	public Support(String boardNo, String userId, String nickName, String gradeName, String title, String contents,
			Date writeDate, int category, String state, String commentNo, String commentUserId, String commentNickName,
			String commentGradeName, Date commentDate, String commentContents, int boardLevel) {
		this.boardNo = boardNo;
		this.userId = userId;
		this.nickName = nickName;
		this.gradeName = gradeName;
		this.title = title;
		this.contents = contents;
		this.writeDate = writeDate;
		this.category = category;
		this.state = state;
		this.commentNo = commentNo;
		this.commentUserId = commentUserId;
		this.commentNickName = commentNickName;
		this.commentGradeName = commentGradeName;
		this.commentDate = commentDate;
		this.commentContents = commentContents;
	}

	@Override
	public String toString() {
		return this.boardNo + ", " + this.userId + ", " + this.nickName + ", " + this.gradeName + ", " + this.title + ", " + this.contents + ", " + this.writeDate
				 + ", " + this.category + ", " + this.state + ", " + this.commentNo + ", " + this.commentUserId + ", " + this.commentNickName
				 + ", " + this.commentGradeName + ", " + this.commentDate + ", " + this.commentContents + ", " + this.boardLevel;
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

	public Date getWriteDate() {
		return writeDate;
	}

	public void setWriteDate(Date writeDate) {
		this.writeDate = writeDate;
	}

	public int getCategory() {
		return category;
	}

	public void setCategory(int category) {
		this.category = category;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
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
	
	public int getBoardLevel() {
		return boardLevel;
	}

	public void setBoardLevel(int boardLevel) {
		this.boardLevel = boardLevel;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	
	
	
	
}
