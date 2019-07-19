package com.cwb.finalproject.useResource.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UseResourceServiceImpl implements UseResourceService{

	@Autowired UseResourceDAO useResourceDao;

	@Override
	public List<UseResourceVO> selectMyUseRes(int memNo) {
		return useResourceDao.selectMyUseRes(memNo);
	}

	@Override
	public List<UseResourceVO> selectMyNotUseRes(int memNo) {
		return useResourceDao.selectMyNotUseRes(memNo);
	}

	@Override
	public List<UseResourceVO> selectMyNotWaitRes(int memNo) {
		return useResourceDao.selectMyNotWaitRes(memNo);
	}

	@Override
	public List<UseResourceVO> selectMyNotRefuseRes(int memNo) {
		return useResourceDao.selectMyNotRefuseRes(memNo);
	}
	
	
	
}
