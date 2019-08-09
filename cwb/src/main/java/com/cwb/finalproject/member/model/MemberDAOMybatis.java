package com.cwb.finalproject.member.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDAOMybatis implements MemberDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	private static final String namespace = "config.mybatis.mapper.oracle.member.";
	
	public List<Map<String, Object>> selectByDeptNo(int deptNo){
		return sqlSession.selectList(namespace+"selectByCate", deptNo);
	}
	public Map<String, Object> selectByNo(int memNo){
		return sqlSession.selectOne(namespace+"selectByNo",memNo);
	}
	@Override
	public String selectForLogin(String memId) {
		return sqlSession.selectOne(namespace+"selectPwdForLogin", memId);
	}
	@Override
	public MemberVO selectByUserid(String memId) {
		return sqlSession.selectOne(namespace+"selectMember", memId);
	}
	@Override
	public List<Map<String, Object>> selectOrSearch(Map<String, Object> map){
		return sqlSession.selectList(namespace+"selectOrSearch",map);
	}
	
	public List<Map<String, Object>> selectOrSearchEmail(Map<String, Object> map){
		return sqlSession.selectList(namespace+"selectOrSearchEmail",map);
	}
	
	public int countEmail(Map<String, Object> map) {
		return sqlSession.selectOne(namespace+"countEmail",map);
	}
	@Override
	public int insertMember(MemberVO vo) {
		return sqlSession.insert(namespace+"insertMember", vo);
	}
	@Override
	public int dupUserid(String memId) {
		return sqlSession.selectOne(namespace+"dupUserid", memId);
	}
	@Override
	public MemberVO selectByMemNotoVo(int memNO) {
		return sqlSession.selectOne(namespace+"selectByMemNotoVo",memNO);
	}
	@Override
	public int updateMember(MemberVO vo) {
		return sqlSession.update(namespace+"updateMember", vo);
	}
	@Override
	public int updateResign(int memNo) {
		return sqlSession.update(namespace+"updateResign", memNo);
	}
	public int changePwd(MemberVO vo) {
		return sqlSession.update(namespace+"changePwd",vo);
	}
	@Override
	public int countMember(Map<String, Object> map) {
		return sqlSession.selectOne(namespace+"countMember", map);
	}
	@Override
	public List<Map<String, Object>> selectOrSearchPaging(Map<String, Object> map) {
		return sqlSession.selectList(namespace+"selectOrSearchPaging", map);
	}
	@Override
	public int updateUser(MemberVO vo) {
		return sqlSession.update(namespace+"updateUser", vo);
	}
	@Override
	public int selectMonth(int memNo) {
		return sqlSession.selectOne(namespace+"selectMonth", memNo);
	}
	@Override
	public List<Map<String, Object>> selectYearAll(int memNo) {
		return sqlSession.selectList(namespace+"selectYearAll", memNo);
	}
	@Override
	public int selectYear(int memNo) {
		return sqlSession.selectOne(namespace+"selectYear", memNo);
	}
}
