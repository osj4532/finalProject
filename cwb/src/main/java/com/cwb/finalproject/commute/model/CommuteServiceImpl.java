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

	@Override
	public List<Map<String, Object>> selectIndiv(int memNo) {
		return commuteDao.selectIndiv(memNo);
	}

	@Override
	public List<Map<String, Object>> selectDep(String deptName) {
		return commuteDao.selectDep(deptName);
	}

	@Override
	public String selectByMemNo(int memNo) {
		return commuteDao.selectByMemNo(memNo);
	}

	@Override
	public List<Map<String, Object>> selectIndivHoly(int memNo) {
		return commuteDao.selectIndivHoly(memNo);
	}

	@Override
	public List<Map<String, Object>> selectAllHoly() {
		return commuteDao.selectAllHoly();
	}

	
	
}
