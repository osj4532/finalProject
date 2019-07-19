package com.cwb.finalproject.useResource.model;

import java.util.List;

public interface UseResourceService {
	List<UseResourceVO> selectMyUseRes(int memNo);
	List<UseResourceVO> selectMyNotUseRes(int memNo);
	List<UseResourceVO> selectMyNotWaitRes(int memNo);
	List<UseResourceVO> selectMyNotRefuseRes(int memNo);
}
