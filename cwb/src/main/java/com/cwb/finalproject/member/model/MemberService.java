package com.cwb.finalproject.member.model;

import java.util.List;
import java.util.Map;

public interface MemberService {
	//로그인처리에서 사용하는 final변수
	int LOGIN_OK=1;			//로그인 성공
	int PWD_DISAGREE=2;		//비밀번호 불일치
	int ID_NONE=3;			//아이디 존재하지 않음
		
	public List<Map<String, Object>> selectByDeptNo(int deptNo);
	
	public Map<String, Object> selectByNo(int memNo);
	
	public int loginCheck(String memId, String memPwd);
	
	public MemberVO selectByUserid(String memId);
}
