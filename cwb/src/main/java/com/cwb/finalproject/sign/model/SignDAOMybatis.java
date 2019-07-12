package com.cwb.finalproject.sign.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cwb.finalproject.confirm.model.ConfirmVO;

@Repository
public class SignDAOMybatis implements SignDAO{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private static final String namespace = "config.mybatis.mapper.oracle.sign.";
	
	public int insertSign(SignVO vo) {
		return sqlSession.insert(namespace+"insertSign",vo);
	}
	
	public SignVO selectSign(int memberNo) {
		return sqlSession.selectOne(namespace+"selectSign",memberNo);
	}
	
	public int updateSign(SignVO vo) {
		return sqlSession.update(namespace+"updateSign",vo);
	}
	
	public List<SignVO> getSignList(ConfirmVO vo){
		return sqlSession.selectList(namespace+"getSignImg",vo);
	}
	
	public int checkSign(int memNo) {
		return sqlSession.selectOne(namespace+"checkSign",memNo);
	}
}
