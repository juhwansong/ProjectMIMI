package common.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class Member implements Serializable {
	private static final long serialVersionUID = 4966048561640205818L;
	
	private String userId; 		//아이디
	private String userPwd;		//비밀번호
	private String userName;	//이름
	private String nickName;	//닉네임
	private String email;		//이메일
	private String birth;		//생일
	private String phone;		//전화번호
	private int gradePoint;		//등급포인트
	private String gradeName;	//등급이름
	private String authority;		//권한
	private String state;		//상태
	private Date delDate;		//삭제일
	
	public Member(){}

	public Member(String userId, String userPwd, String userName, String nickName, String email, String birth,
			String phone, int gradePoint, String gradeName, String authority, String state, Date delDate) {
		this.userId = userId;
		this.userPwd = userPwd;
		this.userName = userName;
		this.nickName = nickName;
		this.email = email;
		this.birth = birth;
		this.phone = phone;
		this.gradePoint = gradePoint;
		this.gradeName = gradeName;
		this.authority = authority;
		this.state = state;
		this.delDate = delDate;
	}

	@Override
	public String toString() {
		return "Member [userId=" + userId + ", userPwd=" + userPwd + ", userName=" + userName + ", nickName=" + nickName
				+ ", email=" + email + ", birth=" + birth + ", phone=" + phone + ", gradePoint=" + gradePoint
				+ ", gradeName=" + gradeName + ", authority=" + authority + ", state=" + state + ", delDate=" + delDate
				+ "]";
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserPwd() {
		return userPwd;
	}

	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public int getGradePoint() {
		return gradePoint;
	}

	public void setGradePoint(int gradePoint) {
		this.gradePoint = gradePoint;
	}

	public String getGradeName() {
		return gradeName;
	}

	public void setGradeName(String gradeName) {
		this.gradeName = gradeName;
	}

	public String getAuthority() {
		return authority;
	}

	public void setAuthority(String authority) {
		this.authority = authority;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public Date getDelDate() {
		return delDate;
	}

	public void setDelDate(Date delDate) {
		this.delDate = delDate;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	

	
}
