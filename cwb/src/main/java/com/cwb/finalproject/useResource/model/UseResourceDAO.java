package com.cwb.finalproject.useResource.model;

import java.util.List;

public interface UseResourceDAO {
	List<UseResourceVO> selectMyUseRes(UseResourceVO useResourceVo);
	List<UseResourceVO> selectMyNotUseRes(int memNo);
	List<UseResourceVO> selectMyNotWaitRes(int memNo);
	List<UseResourceVO> selectMyNotRefuseRes(int memNo);
	int delUseResSchedule(int reservNo);
	int updateUseResSchedule(int reservNo);
	int selectUseRestotalCount(UseResourceVO useResourceVo);
}
