package com.cwb.finalproject.document.model;

import java.util.List;
import java.util.Map;

public interface DocFormService {
	public List<Map<String, Object>> selectDocForm();
	public Map<String, Object> selectDocFormByNo(int formNo);
	public int docFormInsert(DocFormVO vo);
	public int docFormDel(List<Integer> selForm);
}
