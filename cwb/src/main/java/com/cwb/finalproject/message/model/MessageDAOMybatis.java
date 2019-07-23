package com.cwb.finalproject.message.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MessageDAOMybatis implements MessageDAO{
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private static final String namespace = "config.mybatis.mapper.oracle.message.";
	
	public int insertMsg(MessageVO vo) {
		return sqlSession.insert(namespace+"insertMsg",vo);
	}
	
	public int insertMsgRev(MsgRevVO vo) {
		return sqlSession.insert(namespace+"insertMsgRev",vo);
	}
}
