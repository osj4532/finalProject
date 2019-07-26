package com.cwb.finalproject.webhard.model;

import java.util.Map;

import org.springframework.stereotype.Service;

@Service
public class WebhardServiceImpl implements WebhardService{

	private WebhardDAO webhardDao;
	
	@Override
	public Map<String, String> selectWebhard() {
		return webhardDao.selectWebhard();
	}

}
