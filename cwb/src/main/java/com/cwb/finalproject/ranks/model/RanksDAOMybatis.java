package com.cwb.finalproject.ranks.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class RanksDAOMybatis implements RanksDAO{
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private static final String namespace="config.mybatis.mapper.oracle.ranks.";
	
	public List<RanksVO> selectAll(){
		return sqlSession.selectList(namespace+"selectAll");
	}
}
