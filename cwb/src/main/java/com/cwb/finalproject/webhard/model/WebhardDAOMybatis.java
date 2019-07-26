package com.cwb.finalproject.webhard.model;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class WebhardDAOMybatis implements WebhardDAO{

	private SqlSessionTemplate sqlSession;
	
	String namespace = "config.mybatis.mapper.oracle.webhard.";
	
	@Override
	public Map<String, String> selectWebhard() {
		return sqlSession.selectOne(namespace+"selectWebhard");
	}

}
