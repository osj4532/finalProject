package com.cwb.finalproject.webhard.model;

import java.util.List;
import java.util.Map;

public interface WebhardDAO {

	public List<WebhardListVO> selectWBList();
	
	public List<Map<String, Object>> selectFileByWebNo(WebhardVO vo);
	public int insertWBFile(WebhardVO vo);
}
