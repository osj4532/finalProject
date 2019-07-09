package com.cwb.finalproject.resources.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ResourcesServiceImpl implements ResourcesService{

	@Autowired private ResourcesDAO resourcesDao;
	
	@Override
	public int insertResType(Map<String, String> map) {
		return resourcesDao.insertResType(map);
	}

	@Override
	public List<RestypeVO> selectResType() {
		return resourcesDao.selectResType();
	}

	@Override
	public int delResType(int typeNo) {
		return resourcesDao.delResType(typeNo);
	}

	@Override
	public String selectResTypeByNo(int typeNo) {
		return resourcesDao.selectResTypeByNo(typeNo);
	}

	
	@Override
	public int insertRes(ResourcesVO resourcesVo) {
		return resourcesDao.insertRes(resourcesVo);
	}

	@Override
	public List<List<ResourcesVO>> selectAllRes() {
		List<RestypeVO> typelist=resourcesDao.selectResType();
		List<List<ResourcesVO>> resList=new ArrayList<List<ResourcesVO>>();
		for (RestypeVO restypeVO : typelist) {
			resList.add(resourcesDao.selectResBytype(restypeVO.getTypeNo()));
		}
		
		return resList;
	}

	@Override
	public ResourcesVO selectResByNo(int resNo) {
		return resourcesDao.selectResByNo(resNo);
	}

	@Override
	public int updateResByNo(ResourcesVO resourcesVo) {
		return resourcesDao.updateResByNo(resourcesVo);
	}

}
