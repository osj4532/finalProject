package com.cwb.finalproject.webhard.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class WebhardDAOMybatis implements WebhardDAO{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private static final String namespace = "config.mybatis.mapper.oracle.webhard.";

	public List<WebhardListVO> selectWBList(){
		return sqlSession.selectList(namespace+"selectWBList");
	}
	
	public List<Map<String, Object>> selectFileByWebNo(WebhardVO vo){
		return sqlSession.selectList(namespace+"selectFileByWebNo",vo);
	}
	
	public int insertWBFile(WebhardVO vo) {
		return sqlSession.insert(namespace+"insertWBFile",vo);
	}
	
	public WebhardVO selectByFileNo(int fileNo) {
		return sqlSession.selectOne(namespace+"selectByFileNo",fileNo);
	}
	
	public int upDowncount(int fileNo) {
		return sqlSession.update(namespace+"upDowncount",fileNo);
	}
	
	public int deleteWBFile(Map<String, Object> map) {
		return sqlSession.delete(namespace+"deleteWBFile",map);
	}
	
	public int insertWBCate(String webCategory) {
		return sqlSession.insert(namespace+"insertWBCate",webCategory);
	}
	public int updateWBCate(WebhardListVO vo) {
		return sqlSession.update(namespace+"updateWBCate",vo);
	}
	public int deleteWBFileAll(int webNo) {
		return sqlSession.delete(namespace+"deleteWBFileAll",webNo);
	}
	public int deleteWBCate(int webNo) {
		return sqlSession.delete(namespace+"deleteWBCate",webNo);
	}
}
