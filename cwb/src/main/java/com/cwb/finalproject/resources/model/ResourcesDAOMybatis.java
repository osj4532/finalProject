package com.cwb.finalproject.resources.model;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ResourcesDAOMybatis implements ResourcesDAO{
	private String namespace="config.mybatis.mapper.oracle.resources.";
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	@Override
	public int insertResType(Map<String, String> map) {
		return sqlSession.insert(namespace+"insertResType", map);
	}
	
	
}
