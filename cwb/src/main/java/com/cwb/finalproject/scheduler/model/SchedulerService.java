package com.cwb.finalproject.scheduler.model;

import java.util.List;

public interface SchedulerService {
	int insertUserScd(SchedulerVO schedulerVo,boolean isday);
	List<SchedulerVO> selectByUser(int memNo); 
	int deleteByscdNo(int scdNo);
	int updateUserScd(SchedulerVO schedulerVo,boolean isday);
	int updateUserScdContent(SchedulerVO schedulerVo);
}
 