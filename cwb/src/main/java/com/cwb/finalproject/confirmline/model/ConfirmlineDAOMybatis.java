package com.cwb.finalproject.confirmline.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ConfirmlineDAOMybatis implements ConfirmlineDAO{
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private static final String namespace="config.mybatis.mapper.oracle.comfirmLine.";
	
	public int insertConfirmLine(ConfirmlineVO vo) {
		return sqlSession.insert(namespace+"insertComfirmLine",vo);
	}
	
	public List<Map<String, Object>> selectAll(int regNo){
		return sqlSession.selectList(namespace+"selectAll",regNo);
	}
	
	public int getMaxOrder(int regNo) {
		return sqlSession.selectOne(namespace+"getMaxOrder",regNo);
	}
}
