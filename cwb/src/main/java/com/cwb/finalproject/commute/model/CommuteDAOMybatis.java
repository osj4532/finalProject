package com.cwb.finalproject.commute.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CommuteDAOMybatis implements CommuteDAO{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private String namespace = "config.mybatis.mapper.oracle.commute.";

	@Override
	public List<CommuteVO> selectAll() {
		return sqlSession.selectList(namespace+"selectAll");
	}
}
