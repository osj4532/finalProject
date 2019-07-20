package com.cwb.finalproject.address.model;

import java.util.List;
import java.util.Map;

public interface EmailDAO {
	public int insertEmail(EmailVO vo);
	public List<EmailVO> sendMailList(EmailVO vo);
	public int totalCount(int memNo);
	public EmailVO selectDetail(int mailNo);
	public int selectNext(int mailNo);
	public int selectPre(int mailNo);
	public int countNext(int mailNo);
	public int countPre(int mailNo);
	public int deleteMail(int mailNo);
	
}
