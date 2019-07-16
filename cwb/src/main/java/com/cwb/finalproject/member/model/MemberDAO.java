package com.cwb.finalproject.member.model;

import java.util.List;
import java.util.Map;

public interface MemberDAO {
	
	public List<Map<String, Object>> selectByDeptNo(int deptNo);
	
	public Map<String, Object> selectByNo(int memNo);
	
	public String selectForLogin(String memId);
	
	public MemberVO selectByUserid(String memId);
	
	public List<Map<String, Object>> selectOrSearch(Map<String, Object> map);
}
