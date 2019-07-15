package com.cwb.finalproject.confirm.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ConfirmDAOMybatis implements ConfirmDAO{
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private static final String namespace = "config.mybatis.mapper.oracle.confirm.";
	
	public int insertDoc(ConfirmVO vo) {
		return sqlSession.insert(namespace+"insertDoc",vo);
	}
	
	public int insertDocFile(ConfirmFileVO vo) {
		return sqlSession.insert(namespace+"insertDocFile",vo);
	}
	
	// 대기, 반려 문서 조회
	public int countWBList(Map<String, Integer> map) {
		return sqlSession.selectOne(namespace+"countWBList",map);
	}
	public List<Map<String, Object>> selectWaitOrBackList(Map<String,Integer> map){
		return sqlSession.selectList(namespace+"selectWaitOrBackList",map);
		//map key => memNo, state
	}
	
	// 완료 문서 조회
	public int countOkList(int ranksNo){
		return sqlSession.selectOne(namespace+"countOkList",ranksNo);
	}
	public List<Map<String, Object>> selectOkList(Map<String,Integer> map){
		return sqlSession.selectList(namespace+"selectOkList",map);
	}
	// 임시 저장 문서 조회
	public int countTmpList(int memNo) {
		return sqlSession.selectOne(namespace+"countTmpList",memNo);
	}
	public List<Map<String, Object>> selectTmpList(Map<String,Integer> map){
		return sqlSession.selectList(namespace+"selectTmpList",map);
	}
	
	public ConfirmVO confirmDetail(int cfNo) {
		return sqlSession.selectOne(namespace+"confirmDetail",cfNo);
	}
	
	public List<ConfirmFileVO> selectDocFiles(int cfNo){
		return sqlSession.selectList(namespace+"selectDocFiles",cfNo);
	}
	
	public int deleteDocFile(String fileName) {
		return sqlSession.delete(namespace+"deleteDocFile",fileName);
	}
	
	public int selectFileCount(int cfNo) {
		return sqlSession.selectOne(namespace+"selectFileCount",cfNo);
	}
	
	public int updateCFFileN(int cfNo) {
		return sqlSession.update(namespace+"updateCFFileN",cfNo);
	}
	
	public int updateConfirm(ConfirmVO vo) {
		return sqlSession.update(namespace+"updateConfirm",vo);
	}
	
	public int deleteConfirm(int cfNo) {
		return sqlSession.delete(namespace+"deleteConfirm",cfNo);
	}
	
	public int deleteDocFileAll(int cfNo) {
		return sqlSession.delete(namespace+"deleteDocFileAll",cfNo);
	}
	
	public int docBack(int cfNo) {
		return sqlSession.update(namespace+"docBack",cfNo);
	}
	
	public int docOk(int cfNo) {
		return sqlSession.update(namespace+"docOk",cfNo);
	}
	
	public int docOkComplete(int cfNo) {
		return sqlSession.update(namespace+"docOkComplete",cfNo);
	}
}
