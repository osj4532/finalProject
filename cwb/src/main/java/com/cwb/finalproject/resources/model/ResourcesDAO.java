package com.cwb.finalproject.resources.model;

import java.util.List;
import java.util.Map;


public interface ResourcesDAO {
	int insertResType(Map<String, String> map);
	List<RestypeVO> selectResType();
	int delResType(int typeNo);
	String selectResTypeByNo(int typeNo);
	int insertRes(ResourcesVO resourcesVo);
	List<ResourcesVO> selectResBytype(int typeNo);
	ResourcesVO selectResByNo(int resNo);
	int updateResByNo(ResourcesVO resourcesVo);
	int deleteResByno(int resNo);
	List<ResourcesVO> selectImgNameBytype(int typeNo);
	int deleteResByTypeNo(int typeNo);
	
}
