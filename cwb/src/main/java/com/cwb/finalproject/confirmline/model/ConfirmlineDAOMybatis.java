package com.cwb.finalproject.confirmline.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ConfirmlineDAOMybatis implements ConfirmlineDAO{
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private static final String namespace="com.mybatis.mapper.oracle.comfirmLine.";
	
	public int insertConfirmLine(ConfirmlineVO vo) {
		return sqlSession.insert(namespace+"insertComfirmLine",vo);
	}
}
