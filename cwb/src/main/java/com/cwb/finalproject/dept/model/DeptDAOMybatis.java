package com.cwb.finalproject.dept.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class DeptDAOMybatis implements DeptDAO{
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private static final String namespace="com.mybatis.mapper.dept.";
	
	public List<DeptVO> selectAll(){
		return sqlSession.selectList(namespace+"selectAll");
	}
}
