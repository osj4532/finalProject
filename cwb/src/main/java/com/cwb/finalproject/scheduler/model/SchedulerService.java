package com.cwb.finalproject.scheduler.model;

import java.util.List;

public interface SchedulerService {
	int insertUserScd(SchedulerVO schedulerVo,boolean isday);
	List<SchedulerVO> selectByUser(int memNo); 
}
 