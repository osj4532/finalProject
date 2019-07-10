package com.cwb.finalproject.scheduler.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SchedulerServiceImpl implements SchedulerService{
	
	@Autowired private SchedulerDAO schedulerDao;

	@Override
	public int insertUserScd(SchedulerVO schedulerVo) {
		return schedulerDao.insertUserScd(schedulerVo);
	}

	@Override
	public List<SchedulerVO> selectByUser(int memNo) {
		return schedulerDao.selectByUser(memNo);
	}
	
}
