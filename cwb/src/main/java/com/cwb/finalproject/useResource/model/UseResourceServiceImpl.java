package com.cwb.finalproject.useResource.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UseResourceServiceImpl implements UseResourceService{

	@Autowired UseResourceDAO useResourceDao;

	@Override
	public List<UseResourceVO> selectMyUseRes(UseResourceVO useResourceVo) {
		return useResourceDao.selectMyUseRes(useResourceVo);
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

	@Override
	public int delUseResSchedule(int reservNo) {
		return useResourceDao.delUseResSchedule(reservNo);
	}

	@Override
	public int updateUseResSchedule(int reservNo) {
		return useResourceDao.updateUseResSchedule(reservNo);
	}

	@Override
	public int selectUseRestotalCount(UseResourceVO useResourceVo) {
		return useResourceDao.selectUseRestotalCount(useResourceVo);
	}

	@Override
	public List<UseResourceVO> selectAllUseRes(UseResourceVO useResourceVo) {
		return useResourceDao.selectAllUseRes(useResourceVo);
	}

	@Override
	public int selectAllUseRestotalCount(UseResourceVO useResourceVo) {
		return useResourceDao.selectAllUseRestotalCount(useResourceVo);
	}

	@Override
	public List<UseResourceVO> selectAllNotUseRes(UseResourceVO useResourceVo) {
		return useResourceDao.selectAllNotUseRes(useResourceVo);
	}

	@Override
	public List<UseResourceVO> selectAllNotWaitRes() {
		return useResourceDao.selectAllNotWaitRes();
	}

	@Override
	public List<UseResourceVO> selectAllNotRefuseRes() {
		return useResourceDao.selectAllNotRefuseRes();
	}

	@Override
	public int selectAllNotUseRestotalCount(UseResourceVO useResourceVo) {
		return useResourceDao.selectAllNotUseRestotalCount(useResourceVo);
	}
	 
	
	
}
