package com.cwb.finalproject.address.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class EmailServiceImpl implements EmailService{
	@Autowired
	private EmailDAO emailDAO;
	
	public int insertEmail(EmailVO vo) {
		return emailDAO.insertEmail(vo);
	}
	
	public List<EmailVO> sendMailList(EmailVO vo){
		return emailDAO.sendMailList(vo);
	}
	
	public int totalCount(int memNo) {
		return emailDAO.totalCount(memNo);
	}
	
	public EmailVO selectDetail(int mailNo) {
		return emailDAO.selectDetail(mailNo);
	}
	
	public int selectNext(int mailNo) {
		return emailDAO.selectNext(mailNo);
	}
	public int selectPre(int mailNo) {
		return emailDAO.selectPre(mailNo);
	}
	public int countNext(int mailNo) {
		return emailDAO.countNext(mailNo);
	}
	public int countPre(int mailNo) {
		return emailDAO.countPre(mailNo);
	}
	public int deleteMail(int mailNo) {
		return emailDAO.deleteMail(mailNo);
	}
}
