package com.cwb.finalproject.resScheduler.model;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ResSchedulerServiceImp implements ResSchedulerService{
	Logger logger = LoggerFactory.getLogger(ResSchedulerServiceImp.class);
	
	@Autowired ResSchedulerDAO resSchedulerDao;
	
	@Override
	public int insertResScd(ResSchedulerVO resSchedulerVo, boolean isday) {
		int cnt =0;
		if(isday) {
			cnt = resSchedulerDao.insertResDayScd(resSchedulerVo);
		}else {
			cnt = resSchedulerDao.insertResScd(resSchedulerVo);
		}
		return cnt;
	}

	@Override
	public List<ResSchedulerVO> selectResScdByResNo(int resNo) {
		return resSchedulerDao.selectResScdByResNo(resNo);
	}

	@Override
	public int updateResScdApprove(int reservNo) {
		ResSchedulerVO resVo=resSchedulerDao.findMyRess(reservNo);
		logger.info("서비스에서 불러온 스케줄 resVo={}",resVo);
		int cnt = resSchedulerDao.frontUsefindRes(resVo);
		cnt += resSchedulerDao.backUsefindRes(resVo);
		
		if(cnt>0) {
			return EXIST_USE_RES;
		}else {
			return resSchedulerDao.updateResScdApprove(reservNo);
		}
	}

	@Override
	public int updateResScdRefuse(int reservNo) {
		return resSchedulerDao.updateResScdRefuse(reservNo);
	}

	@Override
	public int updateResScdWait(int reservNo) {
		return resSchedulerDao.updateResScdWait(reservNo);
	}

	@Override
	public String selectExistDay(ResSchedulerVO resSchedulerVo,boolean isday) {
		String result ="O"; // 사용가능
		int cnt =0;
		if(isday) {
			cnt+=resSchedulerDao.selectFrontAllDay(resSchedulerVo);
			cnt+=resSchedulerDao.selectFrontAllnotDay(resSchedulerVo);
			cnt+=resSchedulerDao.selectBackAllDay(resSchedulerVo);
			cnt+=resSchedulerDao.selectBackAllnotDay(resSchedulerVo);
		}else {
			cnt+= resSchedulerDao.selectFrontDay(resSchedulerVo);
			cnt+=resSchedulerDao.selectBackDay(resSchedulerVo);
		}
		int ccnt=resSchedulerDao.selectFrontSys(resSchedulerVo);
		ccnt+=resSchedulerDao.selectBackSys(resSchedulerVo);
		if(cnt>0) {
			result="E";//이미 사용한날짜일때
		}
		if(ccnt>0) {
			result="D";//현시간보다 전에 일때
		} 
		return result;
	}

	@Override
	public int findsysday(ResSchedulerVO resSchedulerVo) {
		int cnt=resSchedulerDao.selectFrontSys(resSchedulerVo);
		cnt+=resSchedulerDao.selectBackSys(resSchedulerVo);
		return cnt;
	}

	@Override
	public int selectNowSysDay(int resNo) {
		return resSchedulerDao.selectNowSysDay(resNo);
	}
	

}
