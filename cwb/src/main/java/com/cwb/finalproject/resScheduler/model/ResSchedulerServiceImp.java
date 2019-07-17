package com.cwb.finalproject.resScheduler.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ResSchedulerServiceImp implements ResSchedulerService{

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
		return resSchedulerDao.updateResScdApprove(reservNo);
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
	public String selectExistDay(ResSchedulerVO resSchedulerVo) {
		String result ="O"; // 사용가능
		
		int cnt= resSchedulerDao.selectFrontDay(resSchedulerVo);
		cnt+=resSchedulerDao.selectBackDay(resSchedulerVo);
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

}
