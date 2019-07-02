package com.cwb.finalproject.member.model;

import java.util.List;
import java.util.Map;

public interface MemberService {
	public List<Map<String, Object>> selectByDeptNo(int deptNo);
	public Map<String, Object> selectByNo(int memNo);
}
