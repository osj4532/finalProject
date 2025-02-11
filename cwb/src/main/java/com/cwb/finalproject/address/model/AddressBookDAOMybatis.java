package com.cwb.finalproject.address.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AddressBookDAOMybatis implements AddressBookDAO{

	private static final String namespace = "config.mybatis.mapper.oracle.address.";
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public int privateTotalCount(Map<String, Object> map) {
		return sqlSession.selectOne(namespace+"privateTotalCount",map);
	}
	public List<Map<String, Object>> selectPrivateAddr(Map<String, Object> map){
		return sqlSession.selectList(namespace+"selectPrivateAddr",map);
	}
	public int addrbookDel(int addrbookNo) {
		return sqlSession.delete(namespace+"addrbookDel",addrbookNo);
	}
	
	public int addrbookAdd(AddressBookVO vo) {
		return sqlSession.insert(namespace+"addrbookAdd",vo);
	}
	
	public AddressBookVO selectByNo(int addrbookNo) {
		return sqlSession.selectOne(namespace+"selectByNo",addrbookNo);
	}
	
	public int addrbookEdit(AddressBookVO vo) {
		return sqlSession.update(namespace+"addrbookEdit",vo);
	}
}
