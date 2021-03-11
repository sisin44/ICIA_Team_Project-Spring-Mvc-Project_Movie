package icia.kotlin.beans;

import lombok.Data;

@Data
public class MailBean {
	private String mailReceiver;
	private String mailSubject;
	private String mailContent;
}
