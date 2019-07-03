package com.cwb.finalproject.resources.model;

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

}
