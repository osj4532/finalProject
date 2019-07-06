package com.cwb.finalproject.document.model;

import java.util.List;
import java.util.Map;

public interface DocFormDAO {
	public List<Map<String, Object>> selectDocForm();
	public Map<String, Object> selectDocFormByNo(int formNo);
}

