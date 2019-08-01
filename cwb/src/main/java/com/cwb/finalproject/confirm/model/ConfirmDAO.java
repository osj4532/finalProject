package com.cwb.finalproject.confirm.model;

import java.util.List;
import java.util.Map;

public interface ConfirmDAO {
	public int insertDoc(ConfirmVO vo);
	public int insertDocFile(ConfirmFileVO vo);
	// 대기, 반려 문서 조회
	public List<Map<String, Object>> selectWaitOrBackList(Map<String,Integer> map);
	public int countWBList(Map<String, Integer> map);
	// 완료 문서 조회
	public List<Map<String, Object>> selectOkList(Map<String,Integer> map);
	public int countOkList(int ranksNo);
	// 임시 저장 문서 조회
	public List<Map<String, Object>> selectTmpList(Map<String,Integer> map);
	public int countTmpList(int memNo);
	
	public ConfirmVO confirmDetail(int cfNo);
	public List<ConfirmFileVO> selectDocFiles(int cfNo);
	public int deleteDocFile(String fileName);
	public int selectFileCount(int cfNo);
	public int updateCFFileN(int cfNo);
	public int updateConfirm(ConfirmVO vo);
	public int deleteConfirm(int cfNo);
	public int deleteDocFileAll(int cfNo);
	public int docBack(int cfNo);
	public int docOk(int cfNo);
	public int docOkComplete(int cfNo);
	
	public List<Map<String, Object>> indexConfirmWaitList(int memNo);
	public List<Map<String, Object>> recentConfirmList(int memNo);
}
