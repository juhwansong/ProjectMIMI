package member.wrapper;

import java.nio.charset.Charset;
import java.security.MessageDigest;
import java.util.Base64;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

public class MemberPasswordWrapper extends HttpServletRequestWrapper {
	
	public MemberPasswordWrapper(HttpServletRequest request){
		super(request);
	}

	@Override
	public String getParameter(String name) {
		if(name != null && name.equals("userpassword")){
			name = getSha512(super.getParameter(name));
		}
		else{
			name = super.getParameter(name);
		}
		
		return name;
	}
	
	private String getSha512(String userpwd) {
		//자바가 제공하는 암호화클래스의 메소드 사용함
		String value = null;
		
		try {
			MessageDigest md = MessageDigest.getInstance("SHA-512");
			byte[] pwdValues = userpwd.getBytes(Charset.forName("UTF-8"));
			md.update(pwdValues);
			value = Base64.getEncoder().encodeToString(md.digest());
			
		} catch (Exception e) {
			System.out.println("Sha512 error...");
			e.printStackTrace();
			return null;
		}
		
		return value;
	}
}
