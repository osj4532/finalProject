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
	// 대기, 반려 문서 조회
	//map key => memNo, state = 1 or state = 3
	public List<Map<String, Object>> selectWaitOrBackList(Map<String,Integer> map);
	// 완료 문서 조회
	public List<Map<String, Object>> selectOkList(int ranksNo);
	// 임시 저장 문서 조회
	public List<Map<String, Object>> selectTmpList(int memNo);
	
	public ConfirmVO confirmDetail(int cfNo);
	public List<ConfirmFileVO> selectDocFiles(int cfNo);
	
	public int deleteDocFile(String fileName);
	
	public int checkFile(int cfNo);
	
	public int updateConfirm(ConfirmVO vo, List<Map<String, Object>> fileList);
}
