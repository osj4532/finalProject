package com.cwb.finalproject.webhard.model;

import java.util.List;
import java.util.Map;

public interface WebhardService {

	public List<WebhardListVO> selectWBList();
	public List<Map<String, Object>> selectFileByWebNo(WebhardVO vo);
	
	public int insertWBFile(WebhardVO vo, List<Map<String, Object>> fileList);
	public WebhardVO selectByFileNo(int fileNo);
	
	public int upDowncount(int[] fileNo);
	
	public int deleteWBFile(int[] selFile, int ranksNo, int memNo);
	
	public int insertWBCate(String webCategory);
	public int updateWBCate(WebhardListVO vo);
	public int deleteWBCate(int webNo);
}
