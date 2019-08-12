package com.cwb.finalproject.resScheduler.model;

import java.util.List;

public interface ResSchedulerService {
	int EXIST_USE_RES=101;
	
	int insertResScd(ResSchedulerVO resSchedulerVo,boolean isday);
	List<ResSchedulerVO> selectResScdByResNo(int resNo);
	int updateResScdApprove(int reservNo);
	int updateResScdRefuse(int reservNo);
	int updateResScdWait(int reservNo);
	String selectExistDay(ResSchedulerVO resSchedulerVo,boolean isday);
	int findsysday(ResSchedulerVO resSchedulerVo);
	int selectNowSysDay(int resNo);
}
