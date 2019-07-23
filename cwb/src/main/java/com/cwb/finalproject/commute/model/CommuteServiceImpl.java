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
	public List<Map<String, Object>> selectAll(Map<String, Object> map) {
		return commuteDao.selectAll(map);
	}

	@Override
	public List<Map<String, Object>> selectIndiv(Map<String, Object> map) {
		return commuteDao.selectIndiv(map);
	}

	@Override
	public List<Map<String, Object>> selectDep(Map<String, Object> map) {
		return commuteDao.selectDep(map);
	}

	@Override
	public String selectByMemNo(int memNo) {
		return commuteDao.selectByMemNo(memNo);
	}
	@Override
	public String selectMemNo2(int memNo) {
		return commuteDao.selectMemNo2(memNo);
	}

	@Override
	public List<Map<String, Object>> selectIndivHoly(Map<String, Object> map) {
		return commuteDao.selectIndivHoly(map);
	}

	@Override
	public List<Map<String, Object>> selectAllHoly(Map<String, Object> map) {
		return commuteDao.selectAllHoly(map);
	}

	@Override
	public int countSelectAll() {
		return commuteDao.countSelectAll();
	}

	@Override
	public int countSelectIndiv(int memNo) {
		return commuteDao.countSelectIndiv(memNo);
	}

	@Override
	public int countSelectDep(String deptName) {
		return commuteDao.countSelectDep(deptName);
	}

	@Override
	public int countSelectIndivHoly(int memNo) {
		return commuteDao.countSelectIndivHoly(memNo);
	}

	@Override
	public int countSelectAllHoly() {
		return commuteDao.countSelectAllHoly();
	}

	@Override
	public String selectMemNo(int memNo) {
		return commuteDao.selectMemNo(memNo);
	}

	@Override
	public int insertComin(CommuteVO vo) {
		return commuteDao.insertComin(vo);
	}

	@Override
	public int selectComNo(int memNo) {
		return commuteDao.selectComNo(memNo);
	}

	@Override
	public int updateComout(int comNo) {
		return commuteDao.updateComout(comNo);
	}
	@Override
	public int updateComin(int comNo) {
		return commuteDao.updateComin(comNo);
	}

	@Override
	public List<Map<String, Object>> selectDepAssi() {
		return commuteDao.selectDepAssi();
	}

	@Override
	public List<Integer> countDepAssi() {
		return commuteDao.countDepAssi();
	}

	
	
}
