package com.cwb.finalproject.message.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MessageDAOMybatis implements MessageDAO{
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private static final String namespace = "config.mybatis.mapper.oracle.message.";
	
	public int insertMsg(MessageVO vo) {
		return sqlSession.insert(namespace+"insertMsg",vo);
	}
	
	public int insertMsgRev(MsgRevVO vo) {
		return sqlSession.insert(namespace+"insertMsgRev",vo);
	}
	
	public List<Map<String, Object>> selectRevMsg(Map<String, Object> map){
		return sqlSession.selectList(namespace+"selectRevMsg",map);
	}
	public int countRevMsg(Map<String, Object> map) {
		return sqlSession.selectOne(namespace+"countRevMsg",map);
	}
	public List<Map<String, Object>> selectSenMsg(Map<String, Object> map){
		return sqlSession.selectList(namespace+"selectSenMsg",map);
	}
	public int countSenMsg(Map<String, Object> map) {
		return sqlSession.selectOne(namespace+"countSenMsg",map);
	}
	public int readCheck(int msgrevNo) {
		return sqlSession.update(namespace+"readCheck",msgrevNo);
	}
	public Map<String, Object> selectByNo(Map<String, Object> map){
		return sqlSession.selectOne(namespace+"selectByNo",map);
	}
	public Map<String, Object> selectByNoSen(Map<String, Object> map){
		return sqlSession.selectOne(namespace+"selectByNoSen",map);
	}
	public int msgRevDel(int revNo) {
		return sqlSession.delete(namespace+"msgRevDel",revNo);
	}
	public int msgPre(Map<String, Object> map) {
		return sqlSession.selectOne(namespace+"msgPre",map);
	}
	public int countMsgPre(Map<String, Object> map) {
		return sqlSession.selectOne(namespace+"countMsgPre",map);
	}
	public int msgNext(Map<String, Object> map) {
		return sqlSession.selectOne(namespace+"msgNext",map);
	}
	public int countMsgNext(Map<String, Object> map) {
		return sqlSession.selectOne(namespace+"countMsgNext",map);
	}
	public int senMsgPre(Map<String, Object> map) {
		return sqlSession.selectOne(namespace+"senMsgPre",map);
	}
	public int countSenMsgPre(Map<String, Object> map) {
		return sqlSession.selectOne(namespace+"countSenMsgPre",map);
	}
	public int senMsgNext(Map<String, Object> map) {
		return sqlSession.selectOne(namespace+"senMsgNext",map);
	}
	public int countSenMsgNext(Map<String, Object> map) {
		return sqlSession.selectOne(namespace+"countSenMsgNext",map);
	}
}
