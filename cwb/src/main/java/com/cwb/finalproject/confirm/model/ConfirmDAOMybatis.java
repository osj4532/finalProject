package com.cwb.finalproject.confirm.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ConfirmDAOMybatis implements ConfirmDAO{
	@Autowired
	private SqlSessionTemplate sqlSession;
}
