package com.cwb.finalproject.resScheduler.model;

import java.util.List;

public interface ResSchedulerDAO {
	int insertResScd(ResSchedulerVO resSchedulerVo);
	int insertResDayScd(ResSchedulerVO resSchedulerVo);
	List<ResSchedulerVO> selectResScdByResNo(int resNo);
	
}
