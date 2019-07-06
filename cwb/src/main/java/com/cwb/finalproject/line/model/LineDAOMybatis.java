package com.cwb.finalproject.line.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class LineDAOMybatis implements LineDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private static final String namespace="config.mybatis.mapper.oracle.line.";
	
	public int insertLine(LineVO vo) {
		return sqlSession.insert(namespace+"regLine",vo);
	}
	
	public List<LineVO> selectAll(int userNo){
		return sqlSession.selectList(namespace+"selectAll",userNo);
	}
	
}
