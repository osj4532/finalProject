package com.cwb.finalproject.scheduler.model;

import java.util.List;

public interface SchedulerService {
	int insertUserScd(SchedulerVO schedulerVo);
	List<SchedulerVO> selectByUser(int memNo); 
}
 