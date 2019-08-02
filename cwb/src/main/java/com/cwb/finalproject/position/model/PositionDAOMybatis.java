package com.cwb.finalproject.position.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class PositionDAOMybatis implements PositionDAO{

	private String namespace = "config.mybatis.mapper.oracle.position.";
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<PositionVO> selectAll() {
		return sqlSession.selectList(namespace+"selectAll");
	}
}
