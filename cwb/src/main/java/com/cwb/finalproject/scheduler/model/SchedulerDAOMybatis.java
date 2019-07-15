package com.cwb.finalproject.scheduler.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class SchedulerDAOMybatis implements SchedulerDAO{
	private String namespace="config.mybatis.mapper.oracle.scheduler.";
	
	@Autowired
	private SqlSessionTemplate sqlSesson;

	@Override
	public int insertUserScd(SchedulerVO schedulerVo) {
		return sqlSesson.insert(namespace+"insertUserScd", schedulerVo);
	}

	@Override
	public List<SchedulerVO> selectByUser(int memNo) {
		return sqlSesson.selectList(namespace+"selectByUser", memNo);
	}

	@Override
	public int insertUserDayScd(SchedulerVO schedulerVo) {
		return sqlSesson.insert(namespace+"insertUserDayScd", schedulerVo);
	}

	@Override
	public int deleteByscdNo(int scdNo) {
		return sqlSesson.delete(namespace+"deleteByscdNo",scdNo);
	}

	@Override
	public int updateUserDayScd(SchedulerVO schedulerVo) {
		return sqlSesson.update(namespace+"updateUserDayScd", schedulerVo);
	}

	@Override
	public int updateUserScd(SchedulerVO schedulerVo) {
		return sqlSesson.update(namespace+"updateUserScd", schedulerVo);
	}

	@Override
	public int updateUserScdContent(SchedulerVO schedulerVo) {
		return sqlSesson.update(namespace+"updateUserScdContent", schedulerVo);
	}
	
	
	
	
}
