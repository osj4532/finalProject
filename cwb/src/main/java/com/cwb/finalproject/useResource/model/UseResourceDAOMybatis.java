package com.cwb.finalproject.useResource.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UseResourceDAOMybatis implements UseResourceDAO{
	private String namespace="config.mybatis.mapper.oracle.resScheduler.";
	
	
	@Autowired SqlSessionTemplate sqlSession;
	
	@Override
	public List<UseResourceVO> selectMyUseRes(int memNo) {
		return sqlSession.selectList(namespace+"selectMyUseRes", memNo);
	}

	@Override
	public List<UseResourceVO> selectMyNotUseRes(int memNo) {
		return sqlSession.selectList(namespace+"selectMyNotUseRes", memNo);
	}

	@Override
	public List<UseResourceVO> selectMyNotWaitRes(int memNo) {
		return sqlSession.selectList(namespace+"selectMyNotWaitRes", memNo);
	}

	@Override
	public List<UseResourceVO> selectMyNotRefuseRes(int memNo) {
		return sqlSession.selectList(namespace+"selectMyNotRefuseRes", memNo);
	}

	
	
}
