package com.cwb.finalproject.document.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class DocTypeDAOMybatis implements DocTypeDAO{

	private static final String namespace="config.mybatis.mapper.oracle.document.";
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public List<Map<String, Object>> selectDocType(){
		return sqlSession.selectList(namespace+"selectDocType");
	}
	
	public int docTypeInsert(DocTypeVO vo) {
		return sqlSession.insert(namespace+"docTypeInsert",vo);
	}
	
	public int docTypeDel(String typeName) {
		return sqlSession.update(namespace+"docTypeDel",typeName);
	}
}
