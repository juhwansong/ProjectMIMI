package member.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import common.model.vo.Member;
import member.exception.MemberException;

import static common.jdbc.JDBCTemplate.*;

public class MemberDao {
	public String selectCheckInfo(Connection con, String whereQuery, String value) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String result = null;
		String query = "select " + whereQuery + " from tb_user where "+ whereQuery +" = ? ";
		
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, value);
			
			rset = pstmt.executeQuery();
			if(rset.next()){
				result = rset.getString(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(pstmt);
			close(rset);
		}
		return result;
	}

	public int insertMember(Connection con, Member member) throws MemberException{
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "insert into tb_user (user_id, user_pwd, user_name, nickname, email, birth, phone) values (?,?,?,?,?,?,?) ";
		
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, member.getUserId());
			pstmt.setString(2, member.getUserPwd());
			pstmt.setString(3, member.getUserName());
			pstmt.setString(4, member.getNickName());
			pstmt.setString(5, member.getEmail());
			pstmt.setString(6, member.getBirth());
			pstmt.setString(7, member.getPhone());
			
			result = pstmt.executeUpdate();
			
			if(result <= 0){
				throw new MemberException("회원 가입에 실패하셨습니다.");
			}
			
		}catch(Exception e){
			e.printStackTrace();
			throw new MemberException(e.getMessage());
		}finally{
			close(pstmt);
		}
		
		return result;
	}

	public Member selectMember(Connection con, String userId) throws MemberException{
		
		Member member = null;
		PreparedStatement pstmt =null;
		ResultSet rset = null;
		String query = "select * from tb_user where user_id = ? ";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, userId);
			rset = pstmt.executeQuery();
			
			if(rset.next()){
				member = new Member();
				member.setUserId(userId);
				member.setUserPwd(rset.getString("user_pwd"));
				member.setUserName(rset.getString("user_name"));
				member.setNickName(rset.getString("nickname"));
				member.setEmail(rset.getString("email"));
				member.setBirth(rset.getString("birth"));
				member.setPhone(rset.getString("phone"));
				member.setGradePoint(rset.getInt("grade_point"));
				member.setGradeName(rset.getString("grade_name"));
				member.setAuthority(rset.getString("authority"));
				member.setState(rset.getString("state"));
				member.setDelDate(rset.getDate("del_date"));
				
			}
			else{
				throw new MemberException("회원님의 정보를 불러올수 없습니다.");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new MemberException(e.getMessage());
		} finally{
			close(rset);
			close(pstmt);
		}
		
		return member;
	}

	public String loginCheck(Connection con, String userId, String userPwd) throws MemberException{
		String authority = null;
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select authority from tb_user where user_id = ? and user_pwd = ? and state = 'SN' ";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, userId);
			pstmt.setString(2, userPwd);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()){
				authority = rset.getString("authority");
			}
			else{
				throw new MemberException("아이디나 암호가 일치하지 않습니다.!");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new MemberException(e.getMessage());
		} finally{
			close(pstmt);
			close(rset);
		}
		
		return authority;
	}

	public int updateMember(Connection con, Member member) throws MemberException{
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "update tb_user set user_pwd = ?, nickname = ?, email = ?, birth = ?, phone = ? where user_id = ? and state = 'SN' ";
		
		try{
			pstmt = con.prepareStatement(query);
			
			pstmt.setString(1, member.getUserPwd());
			pstmt.setString(2, member.getNickName());
			pstmt.setString(3, member.getEmail());
			pstmt.setString(4, member.getBirth());
			pstmt.setString(5, member.getPhone());
			pstmt.setString(6, member.getUserId());
			
			result = pstmt.executeUpdate();
			
			if(result <=0){
				throw new MemberException("회원 정보 수정에 실패했습니다.");
			}
			
		} catch(Exception e){
			e.printStackTrace();
			throw new MemberException(e.getMessage());
		} finally{
			close(pstmt);
		}
		
		return result;
	}

	public int leaveMember(Connection con, String userId) throws MemberException{
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "update tb_user set state = 'SD', del_date = sysdate where user_id = ? and state = 'SN' ";
		
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, userId);
			
			result = pstmt.executeUpdate();
			if(result <= 0){
				throw new MemberException("회원 탈퇴에 실패하셨습니다!");
			}
			
		} catch(Exception e){
			e.printStackTrace();
			throw new MemberException(e.getMessage());
		} finally{
			close(pstmt);
		}
		
		return result;
	}

	public String findId(Connection con, String userName, String email) {
		
		String resultId = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select user_id from tb_user where user_name = ? and email = ? and state = 'SN' ";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, userName);
			pstmt.setString(2, email);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()){
				resultId = rset.getString(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			close(pstmt);
			close(rset);
		}
		
		return resultId;
	}

	public String findPassword(Connection con, String userId, String email) {
		
		String resultId = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select user_id from tb_user where user_id = ? and email = ? and state = 'SN' ";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, userId);
			pstmt.setString(2, email);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()){
				resultId = rset.getString(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			close(pstmt);
			close(rset);
		}
		
		return resultId;
		
	}

	public int updatePassword(Connection con, String userId, String userPwd) throws MemberException{
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "update tb_user set user_pwd = ? where user_id = ? and state = 'SN' ";
		
		try{
			pstmt = con.prepareStatement(query);
			
			pstmt.setString(1, userPwd);
			pstmt.setString(2, userId);
			
			result = pstmt.executeUpdate();
			
			if(result <=0){
				throw new MemberException("새비밀번호 등록에 실패했습니다.");
			}
			
		} catch(Exception e){
			e.printStackTrace();
			throw new MemberException(e.getMessage());
		} finally{
			close(pstmt);
		}
		
		return result;
	}

}
