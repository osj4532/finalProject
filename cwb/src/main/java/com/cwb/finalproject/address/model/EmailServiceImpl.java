package com.cwb.finalproject.address.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class EmailServiceImpl implements EmailService{
	@Autowired
	private EmailDAO emailDAO;
	
	public int insertEmail(EmailVO vo) {
		return emailDAO.insertEmail(vo);
	}
}
