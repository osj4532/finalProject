package com.cwb.finalproject.member.model;

import java.util.List;
import java.util.Map;

public interface MemberDAO {
	
	public List<Map<String, Object>> selectByDeptNo(int deptNo);
	
	public Map<String, Object> selectByNo(int memNo);
	
	public String selectForLogin(String memId);
	
	public MemberVO selectByUserid(String memId);
	
	public List<Map<String, Object>> selectOrSearch(Map<String, Object> map);
	
	public List<Map<String, Object>> selectOrSearchEmail(Map<String, Object> map);
	
	public int countEmail(Map<String, Object> map);
	
	public int insertMember(MemberVO vo);
	
	public int dupUserid(String memId);
	
	public MemberVO selectByMemNotoVo(int memNO);
	
	public int updateMember(MemberVO vo);
	
	public int updateResign(int memNo);
	
	public int changePwd(MemberVO vo);
}
