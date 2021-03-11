package icia.kotlin.service;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import icia.kotlin.beans.MailBean;
@Service
public class Mail {

	@Autowired
	private JavaMailSenderImpl sendMail;
	
	ModelAndView mav;
	
	public Mail() {}
	
	public ModelAndView entrance(MailBean mail) {
		mav = this.sendTextMail(mail);
		return mav;
		
	}

	private ModelAndView sendTextMail(MailBean mail) {
		mav = new ModelAndView();
		try {
			MimeMessage mailMessage = this.sendMail.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(mailMessage, true, "UTF-8");
			

			helper.setFrom("vltjddn24@naver.com");
			helper.setTo(mail.getMailReceiver());
			helper.setSubject(mail.getMailSubject());
			helper.setText(mail.getMailContent());
			
			
			this.sendMail.send(mailMessage);
			
			mav.addObject("receiver", mail.getMailReceiver());
			mav.setViewName("sendResult");
		} catch (Exception e) {
			e.printStackTrace();
			
			mav.setViewName("mail");
		}
		
		
		
		return mav;
	}
}
