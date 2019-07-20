package com.cwb.finalproject.address.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class EmailDAOMybatis implements EmailDAO{
	private static final String namespace = "config.mybatis.mapper.oracle.address.";
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public int insertEmail(EmailVO vo) {
		return sqlSession.insert(namespace+"insertEmail",vo);
	}
	
	public List<EmailVO> sendMailList(EmailVO vo){
		return sqlSession.selectList(namespace+"sendMailList",vo);
	}
	
	public int totalCount(int memNo) {
		return sqlSession.selectOne(namespace+"totalCount",memNo);
	}
	
	public EmailVO selectDetail(int mailNo) {
		return sqlSession.selectOne(namespace+"selectDetail",mailNo);
	}
	
	public int selectNext(int mailNo) {
		return sqlSession.selectOne(namespace+"selectNext",mailNo);
	}
	public int selectPre(int mailNo) {
		return sqlSession.selectOne(namespace+"selectPre",mailNo);
	}
	public int countNext(int mailNo) {
		return sqlSession.selectOne(namespace+"countNext",mailNo);
	}
	public int countPre(int mailNo) {
		return sqlSession.selectOne(namespace+"countPre",mailNo);
	}
	public int deleteMail(int mailNo) {
		return sqlSession.delete(namespace+"deleteMail",mailNo);
	}
	
}

