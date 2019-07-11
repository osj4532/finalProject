package com.cwb.finalproject.commute.model;

import java.util.List;
import java.util.Map;

public interface CommuteService {
	public List<Map<String, Object>> selectAll();
	
	public List<Map<String, Object>> selectIndiv(int memNo);
	
	public List<Map<String, Object>> selectDep(String deptName);
	
	public String selectByMemNo(int memNo);
	
	public List<Map<String, Object>> selectIndivHoly(int memNo);
	
	public List<Map<String, Object>> selectAllHoly();
}
