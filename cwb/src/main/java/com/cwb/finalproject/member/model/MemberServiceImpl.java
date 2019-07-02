package com.cwb.finalproject.member.model;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberServiceImpl implements MemberService{
	@Autowired
	private MemberDAO memberDAO;
	
	public List<Map<String, Object>> selectByDeptNo(int deptNo){
		return memberDAO.selectByDeptNo(deptNo);
	}
	public Map<String, Object> selectByNo(int memNo){
		return memberDAO.selectByNo(memNo);
	}	
}
