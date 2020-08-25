package jsp;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SendingEmail {
	private String userEmail;
	private String myHash;
	private String rollno;
	public SendingEmail(String rollno, String userEmail, String myHash) {
		this.rollno = rollno;
		this.userEmail = userEmail;
		this.myHash = myHash;
	}
	
	public boolean sendMail() {
		// Enter the email address and password for the account from which verification link will be send
		String email = "rastogicharles@gmail.com";
		String password = "Cre@tepassword1";
		
		Properties theProperties = new Properties();
		
		theProperties.put("mail.smtp.auth", "true");
		theProperties.put("mail.smtp.starttls.enable", "true");
		theProperties.put("mail.smtp.host", "smtp.gmail.com");
		theProperties.put("mail.smtp.port", "587");
		
		Session session = Session.getDefaultInstance(theProperties, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(email, password);
			}
		});
		
		try {
			
			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(email));
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(userEmail));
			message.setSubject("Email Verification Link for rollno "+rollno+" is:");
			message.setText("your otp to confirm your email address and complete setup for your account is "+ myHash);
			Transport.send(message);
			System.out.println("Successfully sent one time password");	
			return true;
		} catch (Exception e) {
			System.out.println("Error at SendingEmail.java: " + e);
			return false;
		}	
	}
}
