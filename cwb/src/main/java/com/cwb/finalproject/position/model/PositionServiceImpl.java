package com.cwb.finalproject.position.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PositionServiceImpl implements PositionService{

	@Autowired
	private PositionDAO positionDao;
	
	@Override
	public List<PositionVO> selectAll() {
		return positionDao.selectAll();
	}

}
