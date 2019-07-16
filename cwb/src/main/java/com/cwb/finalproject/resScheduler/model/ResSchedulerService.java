package com.cwb.finalproject.resScheduler.model;

import java.util.List;

public interface ResSchedulerService {
	int insertResScd(ResSchedulerVO resSchedulerVo,boolean isday);
	List<ResSchedulerVO> selectResScdByResNo(int resNo);
}
