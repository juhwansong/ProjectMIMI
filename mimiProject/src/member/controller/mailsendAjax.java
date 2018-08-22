package member.controller;

import java.io.IOException;
import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/msendaj")
public class mailsendAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		Properties props = System.getProperties();
		props.put("mail.smtp.user", "cookmimi0402@gmail.com"); // 서버 아이디만 쓰기
		props.put("mail.smtp.host", "smtp.gmail.com"); // 구글 SMTP
		props.put("mail.smtp.port", "465");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.socketFactory.port", "465");
		props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		props.put("mail.smtp.socketFactory.fallback", "false");

		Authenticator auth = new MyAuthenticationAj();

		// session 생성 및 MimeMessage생성
		Session session = Session.getDefaultInstance(props, auth);
		MimeMessage msg = new MimeMessage(session);

		try {
			// 편지보낸시간
			msg.setSentDate(new Date());

			InternetAddress from = new InternetAddress("MIMI<cookmimi0402@gmail.com>");

			// 이메일 발신자
			msg.setFrom(from);

			// 이메일 수신자
			String email = request.getParameter("receiver"); // 사용자가 입력한 이메일
																// 받아오기
			InternetAddress to = new InternetAddress(email);
			msg.setRecipient(Message.RecipientType.TO, to);

			// 이메일 제목
			msg.setSubject("비밀번호 인증번호", "UTF-8");

			// 이메일 내용
			String code = request.getParameter("code_check"); // 인증번호 값 받기
			request.setAttribute("code", code);
			
			//보낼 컨텐츠 꾸미기
			String contentHtml = "<html><body><article style='background: #FB908D;width: 600px;padding-top:10px;padding-right: 15px;padding-left: 15px;'>"
					+ "<div style='background:white;padding-left:15px;padding-top:10px;margin-top:20px;padding-bottom:5px;'>"
					+ "<img style='display:inline-block;position:relative;height:15px;top:2pt;' src=\"https://imgur.com/2xodeTB.jpg\">&nbsp;"
					+ "<h4 style='display:inline-block;margin-bottom:0px;'>회원정보</h4><br>"
					+ "<h3 style='display:inline-block;'>요청하신&nbsp;</h3><h3 style='color:#5cb85c;display:inline-block;'>인증번호&nbsp;</h3><h3 style='display:inline-block;'>입니다!</h3>"
					+ "<hr><label style='margin-top: 15px;margin-bottom: 20px;'>아래의 인증번호를 인증번호 입력창에 입력해 주세요.</label><br>"
					+ "<label style='margin-bottom:20px;'>인증번호&nbsp;:&nbsp;</label><label style='color:#5cb85c;'>" + code + "</label>"
					+ "<p>MIMI를 이용해 주셔서 감사합니다!<br>더욱 편리한 서비스를 위해 노력하겠습니다!</p></div>"
					+ "<nav style='display:inline-block;margin-top:10px;padding-top:10px;padding-right:5px;'>"
					+ "<p>본 메일은 발신전용 입니다. MIMI 서비스관련 궁금하신 사항은 <a style='color:#555;' href='http://localhost:9987/mimi/views/member/customer.jsp'>고객센터</a>에서 확인해주세요!</p>"
					+ "<p style='padding-bottom:20pt;'>Copyright MIMI Corp.All Rights Reserved.</p></nav></article><body><html>";
			
			// 이메일 헤더
			msg.setHeader("content-Type", "text/html");
			msg.setContent(contentHtml, "text/html; charset=utf-8");
			
			// 메일보내기
			javax.mail.Transport.send(msg);
			

		} catch (AddressException addr_e) {
			addr_e.printStackTrace();
		} catch (MessagingException msg_e) {
			msg_e.printStackTrace();
		}

		//RequestDispatcher rd = request.getRequestDispatcher("checkcode.jsp");
		//rd.forward(request, response);
	}
}

class MyAuthenticationAj extends Authenticator {

	PasswordAuthentication pa;

	public MyAuthenticationAj() {
		String id = "cookmimi0402@gmail.com"; // 구글 ID
		String pw = "mimicook1"; // 구글 비밀번호

		// ID와 비밀번호를 입력한다.
		pa = new PasswordAuthentication(id, pw);
	}

	// 시스템에서 사용하는 인증정보
	public PasswordAuthentication getPasswordAuthentication() {
		return pa;
	}

}