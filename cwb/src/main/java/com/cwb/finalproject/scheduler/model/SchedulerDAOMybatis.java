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
	
	
	
	
}
