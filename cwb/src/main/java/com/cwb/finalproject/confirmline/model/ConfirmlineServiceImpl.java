package com.cwb.finalproject.confirmline.model;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ConfirmlineServiceImpl implements ConfirmlineService{
	
	@Autowired
	private ConfirmlineDAO confirmlineDAO;
	
	public List<Map<String, Object>> selectAll(int regNo){
		return confirmlineDAO.selectAll(regNo);
	}
}
