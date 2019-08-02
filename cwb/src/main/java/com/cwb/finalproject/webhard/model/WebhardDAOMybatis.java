package com.cwb.finalproject.webhard.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class WebhardDAOMybatis implements WebhardDAO{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private static final String namespace = "config.mybatis.mapper.oracle.webhard.";

	public List<WebhardListVO> selectWBList(){
		return sqlSession.selectList(namespace+"selectWBList");
	}
	
	public List<Map<String, Object>> selectFileByWebNo(WebhardVO vo){
		return sqlSession.selectList(namespace+"selectFileByWebNo",vo);
	}
	
	public int insertWBFile(WebhardVO vo) {
		return sqlSession.insert(namespace+"insertWBFile",vo);
	}
}
