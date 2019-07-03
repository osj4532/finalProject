package com.cwb.finalproject.line.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class LineDAOMybatis implements LineDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private static final String namespace="com.mybatis.mapper.line.";
	
	public int insertLine(LineVO vo) {
		return sqlSession.insert(namespace+"regLine",vo);
	}
	
}
