package com.cwb.finalproject.member.model;

import java.util.List;
import java.util.Map;

public interface MemberService {
	//로그인처리에서 사용하는 final변수
	int LOGIN_OK=1;			//로그인 성공
	int PWD_DISAGREE=2;		//비밀번호 불일치
	int ID_NONE=3;			//아이디 존재하지 않음
	
	//아이디 중복확인에서 사용하는 final변수
	int USEFUL_USERID=1;  //사용가능한 아이디
	int NON_USEFUL_USERID=2;  //사용불가능한 아이디
		
	public List<Map<String, Object>> selectByDeptNo(int deptNo);
	
	public Map<String, Object> selectByNo(int memNo);
	
	public int loginCheck(String memId, String memPwd);
	
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
	
	public int countMember(Map<String, Object> map);
	
	public List<Map<String, Object>> selectOrSearchPaging(Map<String, Object> map);
	
	public int updateUser(MemberVO vo);
	
	public int selectMonth(int memNo);
	
	public int selectYear(int memNo);
	
	public List<Map<String, Object>> selectYearAll(int memNo);
	
	public List<Map<String, Object>> selectResign();
	
	public int countResign(Map<String, Object> map);
	
	public List<Map<String, Object>> selectOrSearchPagingResign(Map<String, Object> map);
	
	public int updateReIn(int memNo);
}
