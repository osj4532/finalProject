package com.cwb.finalproject.commute.model;

import java.util.List;
import java.util.Map;

public interface CommuteDAO {
	public List<Map<String, Object>> selectAll(Map<String, Object> map);
	
	public List<Map<String, Object>> selectIndiv(Map<String, Object> map);
	
	public List<Map<String, Object>> selectDep(Map<String, Object> map);
	
	public String selectByMemNo(int memNo);
	
	public String selectMemNo2(int memNo);
	
	public List<Map<String, Object>> selectIndivHoly(Map<String, Object> map);
	
	public List<Map<String, Object>> selectAllHoly(Map<String, Object> map);
	
	public int countSelectAll();
	
	public int countSelectIndiv(int memNo);
	
	public int countSelectDep(String deptName);
	
	public int countSelectIndivHoly(int memNo);
	
	public int countSelectAllHoly();
	
	public String selectMemNo(int memNo);
	
	public int insertComin(CommuteVO vo);
	
	public int selectComNo(int memNo);
	
	public int updateComout(int comNo);
	
	public int updateComin(int comNo);
	
	public List<Map<String, Object>> selectDepAssi();
	
	public int countDepAssi();
	
	public int selectNull(int memNo);
}
