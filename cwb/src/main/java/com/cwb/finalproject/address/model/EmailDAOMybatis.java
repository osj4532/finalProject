package com.cwb.finalproject.address.model;

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
}
