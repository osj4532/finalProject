package com.cwb.finalproject.address.controller;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.mail.internet.MimeMultipart;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Component;


@Component
public class EmailSender {
	@Autowired
	private JavaMailSender mailSender;
	private Multipart multipart;
	
	public void init() {
		multipart = new MimeMultipart();
	}
	
	public void sendEmail(String subject,
			String receiver, String sender) throws Exception{
		MimeMessage msg = mailSender.createMimeMessage();
		msg.setSubject(subject);
		msg.setRecipient(RecipientType.TO, new InternetAddress(receiver));
		msg.setFrom(new InternetAddress(sender));
		msg.setContent(multipart);
		mailSender.send(msg);
	}
	
	public void addMsg(String content) {
		try {
			MimeBodyPart mbp1 = new MimeBodyPart();
			mbp1.setContent(content,"text/html");
			multipart.addBodyPart(mbp1);
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void addFile(String savePath, String fileName, String originalFileName) {
		try {
			
			if(fileName != null && !fileName.isEmpty()) {
				DataSource source = new FileDataSource(savePath+"/"+fileName);
				BodyPart messageBodyPart = new MimeBodyPart();
				messageBodyPart.setDataHandler(new DataHandler(source));
				messageBodyPart.setFileName(originalFileName);
				
				multipart.addBodyPart(messageBodyPart);
			}
		
		}catch (AddressException e) {
			e.printStackTrace();
		}catch (MessagingException e) {
			e.printStackTrace();
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
}
