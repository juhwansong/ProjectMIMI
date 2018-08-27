package notice.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class Notice implements Serializable {
	private static final long serialVersionUID = 1L;

	
	private String noticeNo;				//공지사항번호
	private String userId;				//작성자ID
	private String noticeTitle;			//공지사항제목
	private String noticeContents;		//공지사항내용
	private Date noticeDate;			//공지사항작성일
	private String noticeRealFile;		//원본파일명
	private String noticeRenameFile;	//바뀐파일명
	private int fileCnt;				//파일개수
	
	public Notice(){}

	public Notice(String noticeNo, String userId, String noticeTitle, String noticeContents, Date noticeDate,
			String noticeRealFile, String noticeRenameFile, int fileCnt) {
		this.noticeNo = noticeNo;
		this.userId = userId;
		this.noticeTitle = noticeTitle;
		this.noticeContents = noticeContents;
		this.noticeDate = noticeDate;
		this.noticeRealFile = noticeRealFile;
		this.noticeRenameFile = noticeRenameFile;
		this.fileCnt = fileCnt;
	}

	@Override
	public String toString() {
		return "Notice [noticeNo=" + noticeNo + ", userId=" + userId + ", noticeTitle=" + noticeTitle
				+ ", noticeContents=" + noticeContents + ", noticeDate=" + noticeDate + ", noticeRealFile="
				+ noticeRealFile + ", noticeRenameFile=" + noticeRenameFile + ", fileCnt=" + fileCnt + "]";
	}

	public String getNoticeNo() {
		return noticeNo;
	}

	public void setNoticeNo(String noticeNo) {
		this.noticeNo = noticeNo;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getNoticeTitle() {
		return noticeTitle;
	}

	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}

	public String getNoticeContents() {
		return noticeContents;
	}

	public void setNoticeContents(String noticeContents) {
		this.noticeContents = noticeContents;
	}

	public Date getNoticeDate() {
		return noticeDate;
	}

	public void setNoticeDate(Date noticeDate) {
		this.noticeDate = noticeDate;
	}

	public String getNoticeRealFile() {
		return noticeRealFile;
	}

	public void setNoticeRealFile(String noticeRealFile) {
		this.noticeRealFile = noticeRealFile;
	}

	public String getNoticeRenameFile() {
		return noticeRenameFile;
	}

	public void setNoticeRenameFile(String noticeRenameFile) {
		this.noticeRenameFile = noticeRenameFile;
	}

	public int getFileCnt() {
		return fileCnt;
	}

	public void setFileCnt(int fileCnt) {
		this.fileCnt = fileCnt;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	

	
	
	
	
}
