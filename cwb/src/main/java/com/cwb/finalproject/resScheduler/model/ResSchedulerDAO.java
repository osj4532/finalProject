package com.cwb.finalproject.resScheduler.model;

import java.util.List;

public interface ResSchedulerDAO {
	int insertResScd(ResSchedulerVO resSchedulerVo);
	int insertResDayScd(ResSchedulerVO resSchedulerVo);
	List<ResSchedulerVO> selectResScdByResNo(int resNo);
	int updateResScdApprove(int reservNo);
	int updateResScdRefuse(int reservNo);
	int updateResScdWait(int reservNo);
	int selectFrontDay(ResSchedulerVO resSchedulerVo);
	int selectBackDay(ResSchedulerVO resSchedulerVo);
	int selectFrontAllDay(ResSchedulerVO resSchedulerVo);
	int selectBackAllDay(ResSchedulerVO resSchedulerVo);
	int selectFrontSys(ResSchedulerVO resSchedulerVo);
	int selectBackSys(ResSchedulerVO resSchedulerVo);
	int selectFrontAllnotDay(ResSchedulerVO resSchedulerVo);
	int selectBackAllnotDay(ResSchedulerVO resSchedulerVo);
	int selectNowSysDay(int resNo);
	ResSchedulerVO findMyRess(int reservNo);
	int frontUsefindRes(ResSchedulerVO resVo);
	int backUsefindRes(ResSchedulerVO resVo);
	
}
