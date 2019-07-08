package com.cwb.finalproject.resources.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ResourcesDAOMybatis implements ResourcesDAO{
	private String namespace="config.mybatis.mapper.oracle.resources.";
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	@Override
	public int insertResType(Map<String, String> map) {
		return sqlSession.insert(namespace+"insertResType", map);
	}


	@Override
	public List<RestypeVO> selectResType() {
		return sqlSession.selectList(namespace+"selectResType");
	}


	@Override
	public int delResType(int typeNo) {
		return sqlSession.delete(namespace+"delResType", typeNo);
	}


	@Override
	public String selectResTypeByNo(int typeNo) {
		return sqlSession.selectOne(namespace+"selectResTypeByNo", typeNo);
	}


	@Override
	public int insertRes(ResourcesVO resourcesVo) {
		return sqlSession.insert(namespace+"insertRes", resourcesVo);
	}


	@Override
	public List<ResourcesVO> selectResBytype(int typeNo) {
		return sqlSession.selectList(namespace+"selectResBytype", typeNo);
	}
	
	
}
