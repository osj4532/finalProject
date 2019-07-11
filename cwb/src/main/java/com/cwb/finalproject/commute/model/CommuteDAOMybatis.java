package com.cwb.finalproject.commute.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CommuteDAOMybatis implements CommuteDAO{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private String namespace = "config.mybatis.mapper.oracle.commute.";

	@Override
	public List<Map<String, Object>> selectAll() {
		return sqlSession.selectList(namespace+"selectAll");
	}

	@Override
	public List<Map<String, Object>> selectIndiv(int memNo) {
		return sqlSession.selectList(namespace+"selectIndiv", memNo);
	}


	@Override
	public List<Map<String, Object>> selectDep(String deptName) {
		return sqlSession.selectList(namespace+"selectDep", deptName);
	}

	@Override
	public String selectByMemNo(int memNo) {
		return sqlSession.selectOne(namespace+"selectByMemNo", memNo);
	}

	@Override
	public List<Map<String, Object>> selectIndivHoly(int memNo) {
		return sqlSession.selectList(namespace+"selectIndivHoly", memNo);
	}

	@Override
	public List<Map<String, Object>> selectAllHoly() {
		return sqlSession.selectList(namespace+"selectAllHoly");
	}

}
