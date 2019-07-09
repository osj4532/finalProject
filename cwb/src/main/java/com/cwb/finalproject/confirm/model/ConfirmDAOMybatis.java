package com.cwb.finalproject.confirm.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ConfirmDAOMybatis implements ConfirmDAO{
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private static final String namespace = "config.mybatis.mapper.oracle.confirm.";
	
	public int insertDoc(ConfirmVO vo) {
		return sqlSession.insert(namespace+"insertDoc",vo);
	}
	
	public int insertDocFile(ConfirmFileVO vo) {
		return sqlSession.insert(namespace+"insertDocFile",vo);
	}
}
