package com.cwb.finalproject.resources.model;

import java.util.List;
import java.util.Map;

public interface ResourcesService {
	int insertResType(Map<String, String> map);
	List<RestypeVO> selectResType();
	String selectResTypeByNo(int typeNo);
	int insertRes(ResourcesVO resourcesVo);
	List<List<ResourcesVO>> selectAllRes();
	ResourcesVO selectResByNo(int resNo); 
	int updateResByNo(ResourcesVO resourcesVo);
	int deleteResByno(int resNo);
	List<ResourcesVO> selectImgNameBytype(int typeNo);
	int delAlltypeandRes(int typeNo);
}
