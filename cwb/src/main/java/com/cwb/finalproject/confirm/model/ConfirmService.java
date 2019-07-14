package com.cwb.finalproject.confirm.model;

import java.util.List;
import java.util.Map;

public interface ConfirmService {
	//1. 대기(기안자, 결재 순서자)
	//2. 완료(등급에 따라, 모든 사용자)
	//3. 반려(기안자, 반려자)
	//4. 임시저장(기안자)
	public static final int DOC_WAIT = 1;
	public static final int DOC_OK = 2;
	public static final int DOC_BACK = 3;
	public static final int DOC_TMP = 4;
	
	public int insertDoc(ConfirmVO vo, List<Map<String, Object>> fileList);
	public int countWBList(Map<String, Integer> map);
	public List<Map<String, Object>> selectWaitOrBackList(Map<String,Integer> map);
	public int countOkList(int ranksNo);
	public List<Map<String, Object>> selectOkList(int ranksNo);
	public int countTmpList(int memNo);
	public List<Map<String, Object>> selectTmpList(int memNo);
	public ConfirmVO confirmDetail(int cfNo);
	public List<ConfirmFileVO> selectDocFiles(int cfNo);
	public int deleteDocFile(String fileName);
	public int checkFile(int cfNo);
	public int updateConfirm(ConfirmVO vo, List<Map<String, Object>> fileList);
	public int deleteConfirm(int cfNo);
	public int deleteDocFileAll(int cfNo);
	public int docBack(int cfNo);
	public int docOk(int cfNo);
	public int docOkComplete(int cfNo);
}
