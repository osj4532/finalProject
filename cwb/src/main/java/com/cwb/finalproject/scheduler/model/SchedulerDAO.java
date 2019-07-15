package com.cwb.finalproject.scheduler.model;

import java.util.List;

public interface SchedulerDAO {
	int insertUserScd(SchedulerVO schedulerVo);
	List<SchedulerVO> selectByUser(int memNo);
	int insertUserDayScd(SchedulerVO schedulerVo);
	int deleteByscdNo(int scdNo);
	int updateUserDayScd(SchedulerVO schedulerVo);
	int updateUserScd(SchedulerVO schedulerVo);
	int updateUserScdContent(SchedulerVO schedulerVo);
}
