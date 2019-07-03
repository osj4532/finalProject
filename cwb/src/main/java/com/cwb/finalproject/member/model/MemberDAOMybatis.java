package com.cwb.finalproject.member.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDAOMybatis implements MemberDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	private static final String namespace = "com.mybatis.mapper.oracle.member.";
	
	public List<Map<String, Object>> selectByDeptNo(int deptNo){
		return sqlSession.selectList(namespace+"selectByCate", deptNo);
	}
	public Map<String, Object> selectByNo(int memNo){
		return sqlSession.selectOne(namespace+"selectByNo",memNo);
	}
}
