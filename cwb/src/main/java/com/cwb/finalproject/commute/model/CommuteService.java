package com.cwb.finalproject.commute.model;

import java.util.List;
import java.util.Map;

public interface CommuteService {
	public List<Map<String, Object>> selectAll(Map<String, Object> map);
	
	public List<Map<String, Object>> selectIndiv(Map<String, Object> map);
	
	public List<Map<String, Object>> selectDep(Map<String, Object> map);
	
	public String selectByMemNo(int memNo);
	
	public List<Map<String, Object>> selectIndivHoly(Map<String, Object> map);
	
	public List<Map<String, Object>> selectAllHoly(Map<String, Object> map);
	
	public int countSelectAll();
	
	public int countSelectIndiv(int memNo);
	
	public int countSelectDep(String deptName);
	
	public int countSelectIndivHoly(int memNo);
	
	public int countSelectAllHoly();
}
