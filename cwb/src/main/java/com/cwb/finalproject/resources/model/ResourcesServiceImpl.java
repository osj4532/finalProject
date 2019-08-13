package com.cwb.finalproject.resources.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cwb.finalproject.board.model.BoardVO;
import com.cwb.finalproject.resScheduler.model.ResSchedulerDAO;

@Service
public class ResourcesServiceImpl implements ResourcesService{

	@Autowired private ResourcesDAO resourcesDao;
	@Autowired private ResSchedulerDAO ResSchedulrDao;
	
	@Override
	public int insertResType(Map<String, String> map) {
		return resourcesDao.insertResType(map);
	}

	@Override
	public List<RestypeVO> selectResType() {
		return resourcesDao.selectResType();
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

	@Override
	public int deleteResByno(int resNo) {
		ResSchedulrDao.delAllResBySchedule(resNo);
		return resourcesDao.deleteResByno(resNo);
	}

	@Override
	public List<ResourcesVO> selectImgNameBytype(int typeNo) {
		return resourcesDao.selectImgNameBytype(typeNo);
	}
	
	@Override
	@Transactional
	public int delAlltypeandRes(int typeNo) {
		int result=resourcesDao.deleteResByTypeNo(typeNo);
		result+=resourcesDao.delResType(typeNo);
		return result;
	}


}
