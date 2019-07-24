package com.cwb.finalproject.commute.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CommuteDAOMybatis implements CommuteDAO{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private String namespace = "config.mybatis.mapper.oracle.commute.";

	@Override
	public List<Map<String, Object>> selectAll(Map<String, Object> map) {
		return sqlSession.selectList(namespace+"selectAll", map);
	}

	@Override
	public List<Map<String, Object>> selectIndiv(Map<String, Object> map) {
		return sqlSession.selectList(namespace+"selectIndiv", map);
	}


	@Override
	public List<Map<String, Object>> selectDep(Map<String, Object> map) {
		return sqlSession.selectList(namespace+"selectDep", map);
	}

	@Override
	public String selectByMemNo(int memNo) {
		return sqlSession.selectOne(namespace+"selectByMemNo", memNo);
	}
	@Override
	public String selectMemNo2(int memNo) {
		return sqlSession.selectOne(namespace+"selectMemNo2", memNo);
	}

	@Override
	public List<Map<String, Object>> selectIndivHoly(Map<String, Object> map) {
		return sqlSession.selectList(namespace+"selectIndivHoly", map);
	}

	@Override
	public List<Map<String, Object>> selectAllHoly(Map<String, Object> map) {
		return sqlSession.selectList(namespace+"selectAllHoly", map);
	}

	@Override
	public int countSelectAll() {
		return sqlSession.selectOne(namespace+"countSelectAll");
	}

	@Override
	public int countSelectIndiv(int memNo) {
		return sqlSession.selectOne(namespace+"countSelectIndiv", memNo);
	}

	@Override
	public int countSelectDep(String deptName) {
		return sqlSession.selectOne(namespace+"countSelectDep", deptName);
	}

	@Override
	public int countSelectIndivHoly(int memNo) {
		return sqlSession.selectOne(namespace+"countSelectIndivHoly", memNo);
	}

	@Override
	public int countSelectAllHoly() {
		return sqlSession.selectOne(namespace+"countSelectAllHoly");
	}

	@Override
	public String selectMemNo(int memNo) {
		return sqlSession.selectOne(namespace+"selectMemNo", memNo);
	}

	@Override
	public int insertComin(CommuteVO vo) {
		return sqlSession.insert(namespace+"insertComin", vo);
	}

	@Override
	public int selectComNo(int memNo) {
		return sqlSession.selectOne(namespace+"selectComNo", memNo);
	}

	@Override
	public int updateComout(int comNo) {
		return sqlSession.update(namespace+"updateComout", comNo);
	}
	@Override
	public int updateComin(int comNo) {
		return sqlSession.update(namespace+"updateComin", comNo);
	}

	@Override
	public List<Map<String, Object>> selectDepAssi() {
		return sqlSession.selectList(namespace+"selectDepAssi");
	}

	@Override
	public int countDepAssi() {
		return sqlSession.selectOne(namespace+"countDepAssi");
	}

}
