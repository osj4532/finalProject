package com.cwb.finalproject.resScheduler.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ResSchedulerDAOMybatis implements ResSchedulerDAO{
	private String namespace="config.mybatis.mapper.oracle.resScheduler.";
	
	@Autowired SqlSessionTemplate sqlSession;

	@Override
	public int insertResScd(ResSchedulerVO resSchedulerVo) {
		return sqlSession.insert(namespace+"insertResScd", resSchedulerVo);
	}

	@Override
	public int insertResDayScd(ResSchedulerVO resSchedulerVo) {
		return sqlSession.insert(namespace+"insertResDayScd", resSchedulerVo);
	}

	@Override
	public List<ResSchedulerVO> selectResScdByResNo(int resNo) {
		return sqlSession.selectList(namespace+"selectResScdByResNo", resNo);
	}
	
	
}
