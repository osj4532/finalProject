package com.cwb.finalproject.commute.model;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CommuteServiceImpl implements CommuteService{

	@Autowired
	private CommuteDAO commuteDao;

	@Override
	public List<Map<String, Object>> selectAll() {
		return commuteDao.selectAll();
	}
	
	
}
