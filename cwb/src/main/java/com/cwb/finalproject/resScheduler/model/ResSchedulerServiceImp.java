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

}
