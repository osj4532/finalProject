package com.cwb.finalproject.ranks.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RanksServiceImpl implements RanksService{

	@Autowired
	private RanksDAO ranksDAO;
	
	public List<RanksVO> selectAll(){
		return ranksDAO.selectAll();
	}
}
