package com.cwb.finalproject.confirm.model;

import java.util.List;
import java.util.Map;

public interface ConfirmService {
	public int insertDoc(ConfirmVO vo, List<Map<String, Object>> fileList);
}
