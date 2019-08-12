package com.cwb.finalproject.useResource.model;

import java.util.List;

public interface UseResourceService {
	//사원 자원내역
	List<UseResourceVO> selectMyUseRes(UseResourceVO useResourceVo);
	List<UseResourceVO> selectMyNotUseRes(int memNo);
	List<UseResourceVO> selectMyNotWaitRes(int memNo);
	List<UseResourceVO> selectMyNotRefuseRes(int memNo);
	int selectUseRestotalCount(UseResourceVO useResourceVo);
	//내역 수정 삭제
	int delUseResSchedule(int reservNo);
	int updateUseResSchedule(int reservNo);
	//전체 자원내역 
		List<UseResourceVO> selectAllUseRes(UseResourceVO useResourceVo);
		int selectAllUseRestotalCount(UseResourceVO useResourceVo);
		List<UseResourceVO> selectAllNotUseRes(UseResourceVO useResourceVo);
		int selectAllNotUseRestotalCount(UseResourceVO useResourceVo);
		List<UseResourceVO> selectAllNotWaitRes(UseResourceVO useResourceVo);
		int selectAllNotWaitRestotalCount(UseResourceVO useResourceVo);
		List<UseResourceVO> selectAllNotRefuseRes(UseResourceVO useResourceVo);
		int selectAllNotRefuesRestotalCount(UseResourceVO useResourceVo);
		
		List<UseResourceVO> selectResRow(int memNo);
		
}










