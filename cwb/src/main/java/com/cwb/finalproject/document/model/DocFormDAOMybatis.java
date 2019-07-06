package com.cwb.finalproject.document.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class DocFormDAOMybatis implements DocFormDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private static final String namespace = "config.mybatis.mapper.oracle.document.";
	
	public List<Map<String, Object>> selectDocForm(){
		return sqlSession.selectList(namespace+"selectDocForm");
	}
	
	public Map<String, Object> selectDocFormByNo(int formNo){
		return sqlSession.selectOne(namespace+"selectDocFormByNo",formNo);
	}
}
