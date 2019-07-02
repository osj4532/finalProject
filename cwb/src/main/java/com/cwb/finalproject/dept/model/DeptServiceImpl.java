package com.cwb.finalproject.dept.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DeptServiceImpl implements DeptService{
	@Autowired
	private DeptDAO deptDAO;
	
	public List<DeptVO> selectAll(){
		return deptDAO.selectAll();
	}
}
