package com.cwb.finalproject.scheduler.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import oracle.net.aso.e;

@Service
public class SchedulerServiceImpl implements SchedulerService{
	
	@Autowired private SchedulerDAO schedulerDao;

	@Override
	public int insertUserScd(SchedulerVO schedulerVo,boolean isday) {
		int cnt = 0;
		if(isday) {
			cnt=schedulerDao.insertUserDayScd(schedulerVo);
		}else {
			cnt = schedulerDao.insertUserScd(schedulerVo);
		}
		return cnt;
	}

	@Override
	public List<SchedulerVO> selectByUser(int memNo) {
		return schedulerDao.selectByUser(memNo);
	}
	
}
