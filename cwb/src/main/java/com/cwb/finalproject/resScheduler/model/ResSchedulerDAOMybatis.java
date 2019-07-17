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

	@Override
	public int updateResScdApprove(int reservNo) {
		return sqlSession.update(namespace+"updateResScdApprove", reservNo);
	}

	@Override
	public int updateResScdRefuse(int reservNo) {
		return sqlSession.update(namespace+"updateResScdRefuse", reservNo);
	}
 
	@Override
	public int updateResScdWait(int reservNo) {
		return sqlSession.update(namespace+"updateResScdWait", reservNo);
	}

	@Override
	public int selectFrontDay(ResSchedulerVO resSchedulerVo) {
		return sqlSession.selectOne(namespace+"selectFrontDay", resSchedulerVo);
	}

	@Override
	public int selectBackDay(ResSchedulerVO resSchedulerVo) {
		return sqlSession.selectOne(namespace+"selectBackDay", resSchedulerVo);
	}

	@Override
	public int selectFrontSys(ResSchedulerVO resSchedulerVo) {
		return sqlSession.selectOne(namespace+"selectFrontSys", resSchedulerVo);
	}

	@Override
	public int selectBackSys(ResSchedulerVO resSchedulerVo) {
		return  sqlSession.selectOne(namespace+"selectBackSys", resSchedulerVo);
	}
	
	
}
